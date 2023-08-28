/* 
 *	Touchscreen and PIN Logic
 *	
 *	This file serves as a driver and provides an ISR for the AR1100 chip that drives the touchscreen
 *  The file also contains the logic that drives and remembers the PIN as required. 
 * 
 *	Using the Hello World Small Project, manually add the following files to the BSP:
 *				altera_avalon_uart_regs.h
 *  			altera_avalon_timer_regs.h
 */

#include "sys/alt_stdio.h"
#include "altera_avalon_uart_regs.h"
#include "system.h"
#include "unistd.h"
#include "sys/alt_irq.h"
#include "altera_avalon_timer_regs.h"

#define RX_BUFFER_SIZE 1024
#define TX_BUFFER_SIZE 1024

unsigned short TxHead = 0;
unsigned short TxTail = 0;
unsigned char tx_buffer[TX_BUFFER_SIZE] = "";

unsigned short RxHead = 0;
unsigned short RxTail = 0;
unsigned short RxToSkip = 0;
unsigned char rx_buffer[RX_BUFFER_SIZE] = "";

volatile unsigned *base = (volatile unsigned *)0x11028;

int master[4] = {5,2,8,0};

void TOUCHSCREEN_ISR(void* context) {

    int status;
    status = IORD_ALTERA_AVALON_UART_STATUS(TOUCHSCREEN_BASE);

    if (status & ALTERA_AVALON_UART_STATUS_RRDY_MSK) {

    	unsigned char read = IORD_ALTERA_AVALON_UART_RXDATA(TOUCHSCREEN_BASE);
    	if (read == 0x80){
    		RxToSkip = 4;
    	}
    	if (RxToSkip){
    		RxToSkip--;
    	}
    	else {
			rx_buffer[RxHead] = read;
			if (++RxHead > (RX_BUFFER_SIZE-1))
				RxHead = 0;
    	}
    	IOWR_ALTERA_AVALON_UART_STATUS(TOUCHSCREEN_BASE, 0);

    }

    if (status & ALTERA_AVALON_UART_STATUS_TRDY_MSK) {

        if (IORD_ALTERA_AVALON_UART_CONTROL(TOUCHSCREEN_BASE) & ALTERA_AVALON_UART_CONTROL_TRDY_MSK) {

            if (TxTail != TxHead) {

                IOWR_ALTERA_AVALON_UART_TXDATA(TOUCHSCREEN_BASE, tx_buffer[TxTail]);

                if (++TxTail > (TX_BUFFER_SIZE -1))
                    TxTail = 0;
            }

            else
                IOWR_ALTERA_AVALON_UART_CONTROL(TOUCHSCREEN_BASE, ALTERA_AVALON_UART_CONTROL_RRDY_MSK);

        }

    }

}

unsigned char put_char(unsigned char in_char) {

    unsigned short size;
    unsigned int CTRL;

    CTRL = IORD_ALTERA_AVALON_UART_STATUS(TOUCHSCREEN_BASE) & ALTERA_AVALON_UART_STATUS_TRDY_MSK;

    if ((TxHead==TxTail) && CTRL)
        IOWR_ALTERA_AVALON_UART_TXDATA(TOUCHSCREEN_BASE, in_char);

    else {
        if (TxHead >= TxTail)
            size = TxHead - TxTail;
        else
            size = ((TX_BUFFER_SIZE-1) - TxTail) + TxHead;

        if (size > (TX_BUFFER_SIZE - 3))
            return (-1);

        tx_buffer[TxHead] = in_char;

        if (++TxHead > (TX_BUFFER_SIZE-1))
            TxHead = 0;

        CTRL = IORD_ALTERA_AVALON_UART_CONTROL(TOUCHSCREEN_BASE) | ALTERA_AVALON_UART_CONTROL_TRDY_MSK;

        IOWR_ALTERA_AVALON_UART_CONTROL(TOUCHSCREEN_BASE, CTRL);
    }

    return 1;

}


unsigned char get_char(void) {

    unsigned char rxChar;
    usleep(50000);
    /* buffer is empty */
    rxChar=rx_buffer[RxTail];
    rx_buffer[RxTail] = "";

    if (++RxTail > (RX_BUFFER_SIZE-1))
    	RxTail = 0;

    return rxChar;

}

typedef struct { int x, y; } Point ;

void Init_Touch(void)
{
	usleep(50000);

	put_char(0x55);
	put_char(0x01);
	put_char(0x12);

	usleep(50000);

	char SYNC = get_char();
	char SIZE = get_char();
	char STATUS = get_char();
	char CMD = get_char();

	alt_printf("SYNC: %x", SYNC);
	alt_putstr("\n");
	alt_printf("SIZE: %x", SIZE);
	alt_putstr("\n");
	alt_printf("STATUS: %x (OK)", STATUS);
	alt_putstr("\n");
	alt_printf("COMMAND: %x (ENABLE)", CMD);
	alt_putstr("\n\n");



}

void Touch_Disable(void)
{
	put_char(0x55);
	put_char(0x01);
	put_char(0x13);

	usleep(50000);

	char SYNC = get_char();
	char SIZE = get_char();
	char STATUS = get_char();
	char CMD = get_char();

	alt_printf("SYNC: %x", SYNC);
	alt_putstr("\n");
	alt_printf("SIZE: %x", SIZE);
	alt_putstr("\n");
	alt_printf("STATUS: %x (OK)", STATUS);
	alt_putstr("\n");
	alt_printf("COMMAND: %x (DISABLE)", CMD);
	alt_putstr("\n\n");

}


Point Get_Release (void)
{
    Point p1;
    // wait for a pen up command then return the X,Y coord of the point
    // calibrated correctly so that it maps to a pixel on screen
    usleep(50000);
	while (1) {
		int firstByte = get_char();
		if (firstByte == 0x81){
			int i2 = get_char();
			int i3 = get_char();
			int i4 = get_char();
			int i5 = get_char();

			RxHead = 0;
			RxTail = 0;

			int y_coordinate = (i2 + (i3 << 7)) * 480/4096; // scale x coordinate to fit in 800px
			int x_coordinate = (i4 + (i5 << 7)) * 800/4096; // scale y coordinate to fit in 480px

			p1.x = x_coordinate;
			p1.y = y_coordinate;

			for (int i = 0; i < RX_BUFFER_SIZE; i++) {
				rx_buffer[i] = "";
			}

			return p1;
		}
	}

}

int checknum (int x, int y) {

	if ( (x >= (275-50)) && (x <= (275+50)) && (y >=  (96-40)) && (y <= (96+40)) ) {
		return 1;
	}
	else if ( (x >= (400-50)) && (x <= (400+50)) && (y >=  (96-40)) && (y <= (96+40)) ) {
		return 2;
	}
	else if ( (x >= (525-50)) && (x <= (525+50)) && (y >=  (96-40)) && (y <= (96+40)) ) {
		return 3;
	}
	else if ( (x >= (275-50)) && (x <= (275+50)) && (y >=  (192-40)) && (y <= (192+40)) ) {
		return 4;
	}
	else if ( (x >= (400-50)) && (x <= (400+50)) && (y >=  (192-40)) && (y <= (192+40)) ) {
		return 5;
	}
	else if ( (x >= (525-50)) && (x <= (525+50)) && (y >=  (192-40)) && (y <= (192+40)) ) {
		return 6;
	}
	else if ( (x >= (275-50)) && (x <= (275+50)) && (y >=  (288-40)) && (y <= (288+40)) ) {
		return 7;
	}
	else if ( (x >= (400-50)) && (x <= (400+50)) && (y >=  (288-40)) && (y <= (288+40)) ) {
		return 8;
	}
	else if ( (x >= (525-50)) && (x <= (525+50)) && (y >=  (288-40)) && (y <= (288+40)) ) {
		return 9;
	}
	else if ( (x >= (275-50)) && (x <= (275+50)) && (y >=  (384-40)) && (y <= (384+40)) ) {
		return -1;
	}
	else if ( (x >= (400-50)) && (x <= (400+50)) && (y >=  (384-40)) && (y <= (384+40)) ) {
		return 0;
	}
	else if ( (x >= (525-50)) && (x <= (525+50)) && (y >=  (384-40)) && (y <= (384+40)) ) {
		return 10;
	}
	else {
		return 11;
	}

}

//void firsttouch(){
//	Point p;
//	p = Get_Release();
//	*base = 4;
//	// assign screen 2 - pin
//}

int main()
{

//	while(1) {
//		*base = 15;
//		usleep(5000000);
//		*base = 0;
//		usleep(5000000);
//
//	}


	// Register the ISR for timer event
	alt_ic_isr_register(TOUCHSCREEN_IRQ_INTERRUPT_CONTROLLER_ID, TOUCHSCREEN_IRQ, TOUCHSCREEN_ISR, 0, 0x0);

	// Start timer
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TOUCHSCREEN_BASE, 0x0007);

	alt_putstr("Hello from Nios II!\n\n");

	// assign screen 1 - welcome

	usleep(50000);

	Touch_Disable();

	int code[50] = {0};
	int i;

success:
	*base = 4;
	while ((*base) < 1) {

	}
	Init_Touch();
	usleep(50000);
fail:
	i = 0;
	while (1) {
		Point p;
		p = Get_Release();
		int press = checknum(p.x, p.y);
		if (press == -1) {
			*base = 0;
			usleep(1000000);
			goto success;
		}
		else if (press == 10) {
			break;
		}
		else if (press == 11){
			continue;
		}
		else {
			code[i] = press;
		}
		i++;
	}
	int correct = 1;
	for (int i = 0; i<4; i++){
		if (master[i] != code[i]){
			correct = 0;
		}
	}

	if(correct) {
		usleep(5000);
		Touch_Disable();
		while (*base < 4) {
			*base = 0;
		}
		if (*base == 5) {
			*base = 17;
			goto success;
		}
		alt_printf("UNLOCKED \n\n");
		*base = 14;
		usleep(7000000);
		usleep(500000);
		*base = 1;
		usleep(500000);
		// assign screen 1 - Welcome
		usleep(3000000);
		*base = 16;
		alt_printf("LOCKED \n\n");
		goto success;
	}
	else {
		*base = 5;	// light all LEDs
		usleep(500000);
		*base = 4;
		alt_printf("INCORRECT: LOCKED \n\n");
		goto fail;
	}

	return 0;

}


// This code has been adapted fromt he following sources with modifications made to suit our needs.
// TRANSLAITE: https://github.com/ShreyansK2000/Translaite
// https://community.intel.com/t5/Nios-II-Embedded-Design-Suite/NiosII-Uart-Interrupt-Handler/m-p/84690