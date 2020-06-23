#include <stdio.h>

void initialise_benchmark();
void warm_caches(int heat);
int benchmark();
int verify_benchmark(int rpt);

void main()
{
	initialise_benchmark();

	for (int i = 0; i < 10; i++ ) {
		warm_caches(32);
	}

	int r = benchmark(32);
	if (verify_benchmark(r)) {
		printf("pass\n");
	}
	else {
		printf("fail\n");
	}
}
