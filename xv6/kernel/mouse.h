#define MOUSE           0x20    // mouse data port
#define MSTATP          0x64
#define MDATAP          0x60
#define BUF_SIZE        256

uchar MBUFFER[BUF_SIZE][3];
uchar (*mbuffer_in)[3];
uchar (*mbuffer_out)[3];
uchar (*mbuffer_end)[3];
