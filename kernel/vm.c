
// There is one page table per process, plus one that's used when
// a CPU is not running any process (kpgdir). The kernel uses the
// current process's page table during system calls and interrupts;
// page protection bits prevent user code from using the kernel's
// mappings.
// 
// setupkvm() and exec() set up every page table like this:
//
//     0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                                phys memory allocated by the kernel
//     KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//     KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                                for the kernel's instructions and r/o data
//     data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP, 
//                                                                    rw data + free physical memory
//     0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).

// This table defines the kernel's mappings, which are present in
// every process's page table.


