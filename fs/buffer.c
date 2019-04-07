#include <linus/fs.h>

//extern int end;
BUFFER * pBufferStart = (BUFFER *)0x2000/*&end*/;
BUFFER * pBufferFreeList;

INT nr_buffers = 0;
#define NR_BUFFERS nr_buffers

INT BufferSyncDevice(INT dev) {
    int i;
    BUFFER * bh;

    for(i = 0; i < NR_BUFFERS; i++, bh++) {
    }
}

VOID BufferInitialize(LONG buffer_end) {
    BUFFER * bh = pBufferStart;
    
}
