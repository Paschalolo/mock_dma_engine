
; for x86 
; unsigned long bit_ceil(unsigned long x){
; auto mask = (!x) -1 ; 
;  auto count  = (63 - __builtin_clzll(x)) + 1 ; 
;   return ((0x1ULL << count ) & mask) | 0x00ULL;
;
;}
; MOre efficeint bit ceil without branching 
bit_ceil:
  xor eax, eax
  test rdi, rdi
  setne al
  bsr rdi, rdi
  lea ecx, [rdi+1]
  sal rax, cl
  ret
