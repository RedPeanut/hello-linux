
a20.o:     file format elf32-i386


Disassembly of section .text:

00000000 <A20Enable>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
   d:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)
  14:	83 ec 0c             	sub    $0xc,%esp
  17:	6a 64                	push   $0x64
  19:	e8 fc ff ff ff       	call   1a <A20Enable+0x1a>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	88 45 ef             	mov    %al,-0x11(%ebp)
  24:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  28:	83 e0 02             	and    $0x2,%eax
  2b:	85 c0                	test   %eax,%eax
  2d:	75 e5                	jne    14 <A20Enable+0x14>
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 d0 00 00 00       	push   $0xd0
  37:	6a 64                	push   $0x64
  39:	e8 fc ff ff ff       	call   3a <A20Enable+0x3a>
  3e:	83 c4 10             	add    $0x10,%esp
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	6a 64                	push   $0x64
  46:	e8 fc ff ff ff       	call   47 <A20Enable+0x47>
  4b:	83 c4 10             	add    $0x10,%esp
  4e:	88 45 ef             	mov    %al,-0x11(%ebp)
  51:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  55:	83 e0 01             	and    $0x1,%eax
  58:	85 c0                	test   %eax,%eax
  5a:	74 e5                	je     41 <A20Enable+0x41>
  5c:	83 ec 0c             	sub    $0xc,%esp
  5f:	6a 60                	push   $0x60
  61:	e8 fc ff ff ff       	call   62 <A20Enable+0x62>
  66:	83 c4 10             	add    $0x10,%esp
  69:	88 45 ee             	mov    %al,-0x12(%ebp)
  6c:	80 4d ee 02          	orb    $0x2,-0x12(%ebp)
  70:	83 ec 0c             	sub    $0xc,%esp
  73:	6a 64                	push   $0x64
  75:	e8 fc ff ff ff       	call   76 <A20Enable+0x76>
  7a:	83 c4 10             	add    $0x10,%esp
  7d:	88 45 ef             	mov    %al,-0x11(%ebp)
  80:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  84:	83 e0 02             	and    $0x2,%eax
  87:	85 c0                	test   %eax,%eax
  89:	75 e5                	jne    70 <A20Enable+0x70>
  8b:	83 ec 08             	sub    $0x8,%esp
  8e:	68 d1 00 00 00       	push   $0xd1
  93:	6a 64                	push   $0x64
  95:	e8 fc ff ff ff       	call   96 <A20Enable+0x96>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	83 ec 0c             	sub    $0xc,%esp
  a0:	6a 64                	push   $0x64
  a2:	e8 fc ff ff ff       	call   a3 <A20Enable+0xa3>
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	88 45 ef             	mov    %al,-0x11(%ebp)
  ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  b1:	83 e0 02             	and    $0x2,%eax
  b4:	85 c0                	test   %eax,%eax
  b6:	75 e5                	jne    9d <A20Enable+0x9d>
  b8:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  bc:	83 ec 08             	sub    $0x8,%esp
  bf:	50                   	push   %eax
  c0:	6a 60                	push   $0x60
  c2:	e8 fc ff ff ff       	call   c3 <A20Enable+0xc3>
  c7:	83 c4 10             	add    $0x10,%esp
  ca:	83 ec 0c             	sub    $0xc,%esp
  cd:	6a 64                	push   $0x64
  cf:	e8 fc ff ff ff       	call   d0 <A20Enable+0xd0>
  d4:	83 c4 10             	add    $0x10,%esp
  d7:	88 45 ef             	mov    %al,-0x11(%ebp)
  da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  de:	83 e0 02             	and    $0x2,%eax
  e1:	85 c0                	test   %eax,%eax
  e3:	75 e5                	jne    ca <A20Enable+0xca>
  e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  e8:	8b 00                	mov    (%eax),%eax
  ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
  ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  f0:	8b 00                	mov    (%eax),%eax
  f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  f8:	c7 00 aa cc 00 ff    	movl   $0xff00ccaa,(%eax)
  fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 101:	c7 00 dd 11 cc 22    	movl   $0x22cc11dd,(%eax)
 107:	8b 45 f4             	mov    -0xc(%ebp),%eax
 10a:	8b 10                	mov    (%eax),%edx
 10c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 10f:	8b 00                	mov    (%eax),%eax
 111:	39 c2                	cmp    %eax,%edx
 113:	75 0f                	jne    124 <A20Enable+0x124>
 115:	8b 45 f4             	mov    -0xc(%ebp),%eax
 118:	8b 55 e8             	mov    -0x18(%ebp),%edx
 11b:	89 10                	mov    %edx,(%eax)
 11d:	b8 00 00 00 00       	mov    $0x0,%eax
 122:	eb 15                	jmp    139 <A20Enable+0x139>
 124:	8b 45 f4             	mov    -0xc(%ebp),%eax
 127:	8b 55 e8             	mov    -0x18(%ebp),%edx
 12a:	89 10                	mov    %edx,(%eax)
 12c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 12f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 132:	89 10                	mov    %edx,(%eax)
 134:	b8 01 00 00 00       	mov    $0x1,%eax
 139:	c9                   	leave  
 13a:	c3                   	ret    

Disassembly of section .comment:

00000000 <.comment>:
   0:	00 47 43             	add    %al,0x43(%edi)
   3:	43                   	inc    %ebx
   4:	3a 20                	cmp    (%eax),%ah
   6:	28 47 4e             	sub    %al,0x4e(%edi)
   9:	55                   	push   %ebp
   a:	29 20                	sub    %esp,(%eax)
   c:	34 2e                	xor    $0x2e,%al
   e:	35                   	.byte 0x35
   f:	2e 33 00             	xor    %cs:(%eax),%eax
