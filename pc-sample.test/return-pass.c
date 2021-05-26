#include "mandel.h"

extern int rasterize();

void init_display(char display[][YRES]) {
	for (int x=0; x<XRES; x++) {
		for (int y=0; y<YRES; y++) {
			display[x][y] = ' ';
		}
	}
}
int main() {
	char display[XRES][YRES];

	while (1) {
		rasterize(display);
	}
}
