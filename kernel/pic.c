#include <linus/pic.h>
#include <linus/types.h>
#include <asm/io.h>
#include <linus/linkage.h>
#include <linus/trap.h>
#include <linus/x86.h>

#define IO_PIC1 0x20 // Master (IRQs 0-7)
#define IO_PIC2 0xA0 // Slave (IRQs 8-15)

#define IRQ_SLAVE 2 // IRQ at which slave connects to master

// Initial IRQ mask has interrupt 2 enabled (for slave 8259A)
static INT16U irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

VOID PicSetMask(INT16U mask) {
    irqmask = mask;
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1+1, mask);
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2+1, mask >> 8);
}

VOID PicEnable(INT irq) {
    PicSetMask(irqmask & ~(1<<irq));
}

BOOL PicInitialize(VOID) {
#if 0
    /* master 8259 */
    //__outb(0x11, 0x20); /* edge trig, cascade mode, ICW4 */
    //__outb(0x20, 0x21); /* start at INT vector 20h */
    //__outb(0x04, 0x21); /* #IR2 pin has a slave */
    //__outb(0x01, 0x21); /* not sp, nonbuffered mode, normal EOI, for x86 */
    //__outb(0x00, 0x21);

    // mask all interrupts
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1+1, 0xFF);
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2+1, 0xFF);
    
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1, 0x11); /* edge trig, cascade mode, ICW4 */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1+1, T_IRQ0); /* start at INT vector 20h */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1+1, 0x04); /* #IR2 pin has a slave */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1+1, 0x01); /* not sp, nonbuffered mode, normal EOI, for x86 */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC1+1, 0x00);

    /* slave 8259 */
    //__outb(0x11, 0xa0); /* edge trig, cascade mode, ICW4 */
    //__outb(0x28, 0xa1); /* start at INT vector 28h */
    //__outb(0x02, 0xa1); /* slave 8259 has been linked to master's #IR2 pin */
    //__outb(0x01, 0xa1); /* not sp, nonbuffered mode, normal EOI, for x86 */
    //__outb(0x00, 0xa1);
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2, 0x11); /* edge trig, cascade mode, ICW4 */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2+1, 0x28); /* start at INT vector 28h */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2+1, 0x02); /* slave 8259 has been linked to master's #IR2 pin */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2+1, 0x01); /* not sp, nonbuffered mode, normal EOI, for x86 */
    WRITE_PORT_UCHAR((PUCHAR)IO_PIC2+1, 0x00);

    if(irqmask != 0xFFFF)
        PicSetMask(irqmask);
        
    return TRUE;
#else
    // mask all interrupts
    outb(IO_PIC1+1, 0xFF);
    outb(IO_PIC2+1, 0xFF);

    // Set up master (8259A-1)

    // ICW1:    0001g0hi
    //        g:    0 = edge triggering, 1 = level triggering
    //        h:    0 = cascaded PICs, 1 = master only
    //        i:    0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);

    // ICW2:    Vector offset
    outb(IO_PIC1+1, T_IRQ0);

    // ICW3:    (master PIC) bit mask of IR lines connected to slaves
    //                (slave PIC) 3-bit # of slave's connection to master
    outb(IO_PIC1+1, 1<<IRQ_SLAVE);

    // ICW4:    000nbmap
    //        n:    1 = special fully nested mode
    //        b:    1 = buffered mode
    //        m:    0 = slave PIC, 1 = master PIC
    //            (ignored when b is 0, as the master/slave role
    //            can be hardwired).
    //        a:    1 = Automatic EOI mode
    //        p:    0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1+1, 0x3);

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);                                    // ICW1
    outb(IO_PIC2+1, T_IRQ0 + 8);            // ICW2
    outb(IO_PIC2+1, IRQ_SLAVE);                     // ICW3
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2+1, 0x3);                                 // ICW4

    // OCW3:    0ef01prs
    //     ef:    0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //        p:    0 = no polling, 1 = polling mode
    //     rs:    0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);                         // clear specific mask
    outb(IO_PIC1, 0x0a);                         // read IRR by default

    outb(IO_PIC2, 0x68);                         // OCW3
    outb(IO_PIC2, 0x0a);                         // OCW3

    if(irqmask != 0xFFFF)
        PicSetMask(irqmask);

    return TRUE;
#endif
}

