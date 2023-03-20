#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

int main()
{
  struct timeval tv;

  gettimeofday(&tv,NULL);

  printf("main @ 0x%08lx, malloc @ 0x%08lx, printf @ 0x%08lx, exit @ 0x%08lx, gettimeofday @ 0x%08lx\n",main,malloc,printf,exit,gettimeofday);
  printf("tv_sec: %ld\n",(long)tv.tv_sec);
  printf("sizeof \"foo\" = %d\n",sizeof "foo");
  return 0;
}
