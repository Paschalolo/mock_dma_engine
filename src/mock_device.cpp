


#include <cstdint>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <linux/mman.h>
#include <atomic>
#include <new> 
#include <cstdio>
#include <type_traits>
#include <bit>
/* Error Definitions */ 

/* Definitions */
constexpr size_t CACHE_LINE {std::hardware_destructive_interference_size};
constexpr size_t HD_DES_2TYPE {std::hardware_destructive_interference_size * 2ULL };
constexpr size_t MAX_SLOT_SZ = 4096ULL;
/* ENum Definitions */
enum Descriptor_state : std::uint32_t{
	DES_FREE  = 0x00 , 
	DES_READY = 0x01 , 
	DES_PROCESSING = 0x02 , 
	DES_DONE = 0x03, 
	DES_SKIPPED , 
	DES_EMPTY 
};
/* Struct Defintions */ 

struct alignas(HD_DES_2TYPE)Descriptor_t{
	std::atomic<std::uint64_t> m_state ;
	size_t m_payload_offset ;
	size_t m_length; 
};


struct alignas(HD_DES_2TYPE) SPSC_queue{
	std::atomic<std::uint64_t> m_ctrl_plane_pos ; 
	std::atomic<std::uint64_t> m_actual_ctrl_plane_pos ; 
	std::uint8_t m_ctrl_mask ;


	alignas(HD_DES_2TYPE) std::atomic<std::uint64_t> m_data_plane_pos;
	std::atomic<std::uint64_t> m_actual_data_plane_pos;
	std::uint8_t m_data_mask ;
};


struct alignas(CACHE_LINE) Control_plane{
	SPSC_queue* m_queue ;
	void* m_payload_queue;
	Descriptor_t* m_descriptor_queue;
	void* m_local_buffer;
	size_t m_local_ctrl_plane_pos ;
	size_t m_local_data_plane_pos ;
	void* m_actual_mmap_space;
	size_t payload_count ;
	size_t descriptor_cnt ;
	size_t m_total_sz;
	Control_plane( const char* fd_name , size_t max_slot_cnt, size_t descr_cnt ) noexcept;
	~Control_plane() ;
	void*  acquire_write_slot() noexcept;
	int publish_slot() noexcept;

	private : 
		 int flush() noexcept;
};

struct alignas(CACHE_LINE) Data_plane{
	SPSC_queue* m_queue ;
	void* m_payload_queue;
	Descriptor_t* m_descriptor_queue;
	size_t m_local_ctrl_plane_pos ;
	size_t m_local_data_plane_pos ;
	size_t payload_count ;
	size_t descriptor_cnt ;
	size_t m_total_sz;
	Data_plane(size_t sz , const char* fd_name ,size_t max_slot_cnt  , size_t descr_cnt ) noexcept;
	~Data_plane();
	void*  peek_data() noexcept;
	int read_free()noexcept;
	private :
};

/* Helper functions */ 
template <typename T>
void __attribute__((cold , noinline)) total_failure(){
	if constexpr (std::is_same_v<Control_plane , T>) {
	
		std::fprintf(stderr , "Failure intializing Control Plane\n");
	}else if constexpr (std::is_same_v<Data_plane , T >) {
		std::fprintf(stderr , "Failure intializing Data Plane\n");
	}else {
		static_assert(false,"Unknown type in initilization" );
	}
}


/* Function definitions */

Control_plane::Control_plane(const char* fd_name,  size_t max_slot_cnt  ,size_t descr_cnt) noexcept {
	if(fd_name == nullptr){
		total_failure<Control_plane>();
	}
	// check for if it is not rounded to the power of 2
	// use bit ceil on the max slo tand descrnt 
	size_t total_sz = sizeof(SPSC_queue) + HD_DES_2TYPE  + (max_slot_cnt * MAX_SLOT_SZ) + HD_DES_2TYPE + (descr_cnt * sizeof(Descriptor_t)) ; 
	int fd =shm_open(fd_name, int oflag, mode_t mode) ;	
	//ftruncate 
	// mmap 
	// madvise 
	// mlock 

}

// Please rememnber to round to a 128 bytes payload 
int main(){

	return 0;
}
