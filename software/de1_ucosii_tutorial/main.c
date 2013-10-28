/*
 * main.c
 *
 *  Created on: Oct 13, 2013
 *      Author: alex
 */
#include <stdio.h>
#include "includes.h"
#include "altera_avalon_pio_regs.h"

#define HEX0 0x01003060
#define HEX1 0x01003050
#define HEX2 0x01003040
#define HEX3 0x01003030
#define GREEN_LEDS 0x01003020

void scroll1337(void *pdata)
{
	unsigned int displays[] = {HEX0, HEX1, HEX2, HEX3};
	char word[] = {0xF8, 0xB0, 0xB0, 0xf9};
	int start = 0;
	while(1) {
		int i = 0;
		for(i = 0; i < sizeof(word); ++i) {
			IOWR_ALTERA_AVALON_PIO_DATA(displays[start], word[i]);
			start = (start + 1)%(sizeof(displays)/4);
		}
		start = (start + 1)%(sizeof(displays)/4);
		OSTimeDlyHMSM(0, 0, 3, 0);
	}
}

void rotateGreen(void *pdata)
{
	char disp = 0x1;
	while(1) {
		IOWR_ALTERA_AVALON_PIO_DATA(GREEN_LEDS, disp);
		disp = disp << 1;
		if(disp == 0)
			disp = 1;
		OSTimeDlyHMSM(0, 0, 0, 500);
	}
}

#define TASK_STACKSIZE 2048
OS_STK scroll_stk[TASK_STACKSIZE];
OS_STK leds_stk[TASK_STACKSIZE];

int main(int nargs, char * argv[])
{
	OSTaskCreateExt(scroll1337,
					NULL,
					(void*)&scroll_stk[TASK_STACKSIZE-1],
					1,
					1,
					scroll_stk,
					TASK_STACKSIZE,
					NULL,
					0);

	OSTaskCreateExt(rotateGreen,
					NULL,
					(void*)&leds_stk[TASK_STACKSIZE-1],
					2,
					2,
					leds_stk,
					TASK_STACKSIZE,
					NULL,
					0);
	OSStart();
}



