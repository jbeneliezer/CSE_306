#define MOUSE           0x20    // mouse data port
#define MSTATP          0x64
#define MDATAP          0x60

uchar MBUFFER[256][3];
uchar** mbuffer_in;
uchar** mbuffer_out;
uchar** mbuffer_end;
