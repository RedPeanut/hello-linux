
boot/head.o:     file format elf32-i386


Disassembly of section .text:

00000000 <startup_32>:
       0:	fc                   	cld    
       1:	b8 10 00 00 00       	mov    $0x10,%eax
       6:	8e d8                	mov    %eax,%ds
       8:	8e c0                	mov    %eax,%es
       a:	8e e0                	mov    %eax,%fs
       c:	8e e8                	mov    %eax,%gs
       e:	e8 05 00 00 00       	call   18 <setup_paging>
      13:	e8 fc ff ff ff       	call   14 <startup_32+0x14>

00000018 <setup_paging>:
      18:	b9 00 08 00 00       	mov    $0x800,%ecx
      1d:	31 c0                	xor    %eax,%eax
      1f:	bf 00 00 00 00       	mov    $0x0,%edi
      24:	fc                   	cld    
      25:	f3 ab                	rep stos %eax,%es:(%edi)
      27:	c7 05 00 00 00 00 07 	movl   $0x7,0x0
      2e:	00 00 00 
      31:	c7 05 00 03 00 00 07 	movl   $0x7,0x300
      38:	00 00 00 
      3b:	bf fc 0f 00 00       	mov    $0xffc,%edi
      40:	b8 07 f0 3f 00       	mov    $0x3ff007,%eax
      45:	fd                   	std    
      46:	ab                   	stos   %eax,%es:(%edi)
      47:	2d 00 10 00 00       	sub    $0x1000,%eax
      4c:	7d f8                	jge    46 <setup_paging+0x2e>
      4e:	fc                   	cld    
      4f:	b8 00 00 00 00       	mov    $0x0,%eax
      54:	0f 22 d8             	mov    %eax,%cr3
      57:	0f 20 c0             	mov    %cr0,%eax
      5a:	0d 00 00 00 80       	or     $0x80000000,%eax
      5f:	0f 22 c0             	mov    %eax,%cr0
      62:	c3                   	ret    
	...

00001000 <swapper_pg_dir>:
	...

00002000 <pg0>:
	...

00003000 <empty_bad_page>:
	...

00004000 <empty_bad_page_table>:
	...

00005000 <empty_zero_page>:
	...
