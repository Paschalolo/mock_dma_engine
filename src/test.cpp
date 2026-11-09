

#include <cstdio>
#include <bit> 


int main(){
	volatile auto x = 129ULL;
	std::printf("%llu\n" , std::bit_ceil(x));
	return 0;
}
