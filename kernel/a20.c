#include <linus/types.h>
#include <linus/linkage.h>
#include <asm/io.h>

BOOL A20Enable(VOID) {
	int *test_1 = (int *)0x00000000, test_1_buf;
	int *test_2 = (int *)0x00100000, test_2_buf;
	UCHAR status, flag;

	/* read current falg */
	do { status = READ_PORT_UCHAR((PUCHAR)0x64); } while( status & 0x02 );
	WRITE_PORT_UCHAR((PUCHAR)0x64, 0xd0);
	do { status = READ_PORT_UCHAR((PUCHAR)0x64); } while( !(status&0x01) );
	flag = READ_PORT_UCHAR((PUCHAR)0x60);
	flag |= 0x02; /* enable a20 */

	/* write modified flag */
	do { status = READ_PORT_UCHAR((PUCHAR)0x64); } while( status & 0x02 );
	WRITE_PORT_UCHAR((PUCHAR)0x64, 0xd1);
	do { status = READ_PORT_UCHAR((PUCHAR)0x64); } while( status & 0x02 );
	WRITE_PORT_UCHAR((PUCHAR)0x60, flag); /* write new flag */

	/* wait until the new flag has adapted */
	do { status = READ_PORT_UCHAR((PUCHAR)0x64); } while( status & 0x02 );

	/* test a20 line */
	test_1_buf = *test_1;
	test_2_buf = *test_2;
	*test_1 = 0xff00ccaa;
	*test_2 = 0x22cc11dd;
	if(*test_1 == *test_2) {
		*test_1 = test_1_buf;
		return FALSE;
	}
	*test_1 = test_1_buf;
	*test_2 = test_2_buf;

	return TRUE;
}

