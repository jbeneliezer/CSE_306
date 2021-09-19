#include "types.h"
#include "x86.h"
#include "defs.h"
#include "mouse.h"

void
mouseinit(void)
{
    uchar status;
    // uchar data[3];

    outb(0x64, 0x20);
    status = inb(0x60);

    cprintf("status: %d\n", status);
    status = ((status | 0x02) & 0xDF);
    cprintf("status: %d\n", status);

    outb(0x64, 0x60);
    outb(0x60, status);

    outb(0x64, 0xD4);
    outb(0x60, 0xF4);

    status = inb(0x60);
    if (status != 0xFA) cprintf("Error");
    // while(1)
    // {
    //     uchar i = 0;
    //     while (i < 3)
    //     {
    //         data[i++] = inb(0x60);
    //     }
    //     cprintf("mouse -- %d %d %d", data[0], data[1], data[2]);
    // }

}

void
mouseintr(void)
{

}