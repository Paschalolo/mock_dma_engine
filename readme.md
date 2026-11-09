A Lock-Free Host-to-Device Ring Buffer Protocol (Mock DMA Engine)

A high-performance, user-space software simulation of a hardware accelerator interface (modeled after enterprise PCIe DMA engines like AWS Nitro or Trainium). This project demonstrates extreme low-latency concurrency, separating the **control plane** (metadata descriptors) from the **data plane** (zero-copy payload arenas) using lock-free Single-Producer Single-Consumer (SPSC) rings and explicit memory barriers.

---

## 🚀 The Core Concept

In high-throughput distributed systems and hardware acceleration, relying on operating system primitives (mutexes, semaphores, condition variables) introduces catastrophic latency spikes and kernel context-switch overhead. 

This project simulates how a **Host CPU** and a **Device Accelerator** communicate at line rate over a mock PCIe bus by implementing:
1. **Zero-Copy Architecture:** Pre-allocated payload arenas backed by Linux Huge Pages (`MAP_HUGETLB`) to eliminate TLB thrashing and memory copying.
2. **Control-Data Decoupling:** A lightweight metadata ring containing fixed-size descriptors that point directly into the payload arena.
3. **Pure Atomic Concurrency:** Complete elimination of locks (`std::mutex`), replaced entirely by strict atomic operations and memory fences (`std::memory_order_acquire` and `std::memory_order_release`).

---

## 🏛️ System Architecture

```text
+-----------------------------------------------------------------+
|                        HOST CPU THREAD                          |
|  - Writes payload data directly to Huge Page Arena              |
|  - Allocates/populates 64-byte Descriptor (Control Plane)       |
|  - Updates Ring Tail Index (std::memory_order_release)          |
+-----------------------------------------------------------------+
                                 |
                                 v
+-----------------------------------------------------------------+
|                   SHARED MEMORY RING BUFFER                     |
|                                                                 |
|  +-------------------+  +-------------------+  +-------------+  |
|  | Descriptor 0      |  | Descriptor 1      |  | ... [N-1]   |  |
|  | - Payload Offset  |  | - Payload Offset  |  |             |  |
|  | - Transfer Length |  | - Transfer Length |  |             |  |
|  | - Status Flags    |  | - Status Flags    |  |             |  |
|  +-------------------+  +-------------------+  +-------------+  |
|                                                                 |
|  [Cache-Line Separated Head & Tail Pointers]                    |
+-----------------------------------------------------------------+
                                 |
                                 v
+-----------------------------------------------------------------+
|                       DEVICE THREAD (ACCELERATOR)               |
|  - Polls Ring Head Index (std::memory_order_acquire)            |
|  - Reads Descriptor metadata                                    |
|  - Processes zero-copy payload directly from Huge Page arena    |
|  - Marks Descriptor COMPLETE                                    |
+-----------------------------------------------------------------+
```

---

## 🛠️ Key Technical Components

### 1. Control Plane: SPSC Descriptor Ring
* **Fixed-Size Ring Buffer:** Array of 32-byte or 64-byte `Descriptor` structs.
* **Layout Alignment:** Every descriptor aligns with standard CPU cache lines to prevent multi-core cache thrashing.
* **Fields:**
  * `uint64_t payload_offset`: Byte offset into the huge-page payload arena.
  * `uint32_t length`: Size of the transaction in bytes.
  * `std::atomic<uint32_t> status_flags`: State machine (`FREE`, `READY`, `PROCESSING`, `DONE`).

### 2. Data Plane: Zero-Copy Huge Page Arena
* Allocated at startup using `mmap()` with `MAP_HUGETLB` and `MAP_ANONYMOUS`.
* Guarantees 2MB or 1GB pages, drastically minimizing Translation Lookaside Buffer (TLB) misses under heavy transaction loads.
* Payloads are written once by the producer and read/processed in place by the consumer.

### 3. Concurrency & False Sharing Prevention
* **Cache-Line Isolation:** Head and tail pointers are padded using `alignas(64)` (or `std::hardware_destructive_interference_size`) to ensure they never inhabit the same cache line.
* **Acquire-Release Semantics:** 
  * The Producer publishes writes with `memory_order_release`.
  * The Consumer synchronizes state observation using `memory_order_acquire`.
  * Guarantees zero race conditions without atomic CAS retry loops.

---

## 📂 Suggested Project Layout

```text
.
├── CMakeLists.txt
├── include/
│   ├── ring_buffer.hpp       # Lock-free SPSC template class
│   ├── descriptor.hpp        # 64-byte aligned metadata structure
│   ├── huge_page_allocator.hpp # MAP_HUGETLB wrapper helper
│   └── mock_device.hpp       # Accelerator thread logic
├── src/
│   └── main.cpp              # Orchestrates Host/Device thread lifecycles
└── tests/
    └── benchmark.cpp         # Throughput & latency stress tests
```

---

## 🚦 Getting Started & Building

### Prerequisites
* A modern C++20 compliant compiler (`g++-11+` or `clang++-13+`).
* Linux OS environment (required for `MAP_HUGETLB` support).
* Configured Huge Pages on your host system:
  ```bash
  sudo sysctl -w vm.nr_hugepages=64
  ```

### Compilation
```bash
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```

### Running the Simulation
```bash
./final_boss_dma --transactions 1000000 --ring-size 1024
```
