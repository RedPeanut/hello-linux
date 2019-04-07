
trapasm.o:     file format elf32-i386


Disassembly of section .text:

00000000 <alltraps>:
   0:	1e                   	push   %ds
   1:	06                   	push   %es
   2:	0f a0                	push   %fs
   4:	0f a8                	push   %gs
   6:	60                   	pusha  
   7:	66 b8 10 00          	mov    $0x10,%ax
   b:	8e d8                	mov    %eax,%ds
   d:	8e c0                	mov    %eax,%es
   f:	8e e0                	mov    %eax,%fs
  11:	8e e8                	mov    %eax,%gs
  13:	54                   	push   %esp
  14:	e8 fc ff ff ff       	call   15 <alltraps+0x15>
  19:	83 c4 04             	add    $0x4,%esp

0000001c <trapret>:
  1c:	61                   	popa   
  1d:	0f a9                	pop    %gs
  1f:	0f a1                	pop    %fs
  21:	07                   	pop    %es
  22:	1f                   	pop    %ds
  23:	83 c4 08             	add    $0x8,%esp
  26:	cf                   	iret   
