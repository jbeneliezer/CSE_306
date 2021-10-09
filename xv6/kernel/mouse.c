#include "types.h"
#include "x86.h"
#include "defs.h"
#include "mouse.h"

void
mouseinit(void)
{
    uchar status;

    status = inb(MSTATP);
    while (status & 1);
    outb(MSTATP, 0x20);
    status = inb(MDATAP);

    status = ((status | 0x02) & 0xDF);

    outb(MSTATP, 0x60);         // set status, enable IRQ12
    outb(MDATAP, status);

    outb(MSTATP, 0xA8);         // enable auxiliary device
    while (inb(MDATAP) == 0xFA);

    outb(MSTATP, 0xD4);
    outb(MDATAP, 0xF4);

    status = inb(MDATAP);
    while (inb(MDATAP) == 0xFA);

}

void
mouseintr(void)
{
    mbuffer_in = MBUFFER;
    mbuffer_out = MBUFFER;
    mbuffer_end = &MBUFFER[255];

    if (inb(MSTATP) & 1)
    {
        uint i = 0;
        while (i < 3)
        {
            *mbuffer_in[i++] = inb(MDATAP);
            if ((uint)mbuffer_in == (uint)mbuffer_end) mbuffer_in = MBUFFER;
            else ++mbuffer_in;
            cprintf("mouse: %d\n", mbuffer_in[i-1]);
        }
    }
}