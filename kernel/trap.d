
trap.o:     file format elf32-i386


Disassembly of section .text:

00000000 <TrapInitialize>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
   6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
   d:	e9 b8 00 00 00       	jmp    ca <TrapInitialize+0xca>
  12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  15:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
  1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1f:	66 89 04 d5 00 00 00 	mov    %ax,0x0(,%edx,8)
  26:	00 
  27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  2a:	66 c7 04 c5 02 00 00 	movw   $0x8,0x2(,%eax,8)
  31:	00 08 00 
  34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  37:	8a 14 c5 04 00 00 00 	mov    0x4(,%eax,8),%dl
  3e:	83 e2 e0             	and    $0xffffffe0,%edx
  41:	88 14 c5 04 00 00 00 	mov    %dl,0x4(,%eax,8)
  48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  4b:	8a 14 c5 04 00 00 00 	mov    0x4(,%eax,8),%dl
  52:	83 e2 1f             	and    $0x1f,%edx
  55:	88 14 c5 04 00 00 00 	mov    %dl,0x4(,%eax,8)
  5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  5f:	8a 14 c5 05 00 00 00 	mov    0x5(,%eax,8),%dl
  66:	83 e2 f0             	and    $0xfffffff0,%edx
  69:	83 ca 0e             	or     $0xe,%edx
  6c:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  76:	8a 14 c5 05 00 00 00 	mov    0x5(,%eax,8),%dl
  7d:	83 e2 ef             	and    $0xffffffef,%edx
  80:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8a:	8a 14 c5 05 00 00 00 	mov    0x5(,%eax,8),%dl
  91:	83 e2 9f             	and    $0xffffff9f,%edx
  94:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  9e:	8a 14 c5 05 00 00 00 	mov    0x5(,%eax,8),%dl
  a5:	83 ca 80             	or     $0xffffff80,%edx
  a8:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  b2:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
  b9:	c1 e8 10             	shr    $0x10,%eax
  bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  bf:	66 89 04 d5 06 00 00 	mov    %ax,0x6(,%edx,8)
  c6:	00 
  c7:	ff 45 fc             	incl   -0x4(%ebp)
  ca:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  d1:	0f 8e 3b ff ff ff    	jle    12 <TrapInitialize+0x12>
  d7:	a1 00 01 00 00       	mov    0x100,%eax
  dc:	66 a3 00 02 00 00    	mov    %ax,0x200
  e2:	66 c7 05 02 02 00 00 	movw   $0x8,0x202
  e9:	08 00 
  eb:	a0 04 02 00 00       	mov    0x204,%al
  f0:	83 e0 e0             	and    $0xffffffe0,%eax
  f3:	a2 04 02 00 00       	mov    %al,0x204
  f8:	a0 04 02 00 00       	mov    0x204,%al
  fd:	83 e0 1f             	and    $0x1f,%eax
 100:	a2 04 02 00 00       	mov    %al,0x204
 105:	a0 05 02 00 00       	mov    0x205,%al
 10a:	83 c8 0f             	or     $0xf,%eax
 10d:	a2 05 02 00 00       	mov    %al,0x205
 112:	a0 05 02 00 00       	mov    0x205,%al
 117:	83 e0 ef             	and    $0xffffffef,%eax
 11a:	a2 05 02 00 00       	mov    %al,0x205
 11f:	a0 05 02 00 00       	mov    0x205,%al
 124:	83 c8 60             	or     $0x60,%eax
 127:	a2 05 02 00 00       	mov    %al,0x205
 12c:	a0 05 02 00 00       	mov    0x205,%al
 131:	83 c8 80             	or     $0xffffff80,%eax
 134:	a2 05 02 00 00       	mov    %al,0x205
 139:	a1 00 01 00 00       	mov    0x100,%eax
 13e:	c1 e8 10             	shr    $0x10,%eax
 141:	66 a3 06 02 00 00    	mov    %ax,0x206
 147:	b8 01 00 00 00       	mov    $0x1,%eax
 14c:	c9                   	leave  
 14d:	c3                   	ret    

0000014e <trap>:
 14e:	55                   	push   %ebp
 14f:	89 e5                	mov    %esp,%ebp
 151:	83 ec 18             	sub    $0x18,%esp
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 40 20             	mov    0x20(%eax),%eax
 15a:	83 f8 40             	cmp    $0x40,%eax
 15d:	0f 84 e2 00 00 00    	je     245 <trap+0xf7>
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	8b 40 20             	mov    0x20(%eax),%eax
 169:	83 f8 20             	cmp    $0x20,%eax
 16c:	75 6d                	jne    1db <trap+0x8d>
 16e:	a1 00 00 00 00       	mov    0x0,%eax
 173:	83 f8 64             	cmp    $0x64,%eax
 176:	0f 9f c2             	setg   %dl
 179:	40                   	inc    %eax
 17a:	a3 00 00 00 00       	mov    %eax,0x0
 17f:	84 d2                	test   %dl,%dl
 181:	74 3c                	je     1bf <trap+0x71>
 183:	a1 04 00 00 00       	mov    0x4,%eax
 188:	40                   	inc    %eax
 189:	a3 04 00 00 00       	mov    %eax,0x4
 18e:	a1 04 00 00 00       	mov    0x4,%eax
 193:	83 f8 07             	cmp    $0x7,%eax
 196:	7e 0a                	jle    1a2 <trap+0x54>
 198:	c7 05 04 00 00 00 00 	movl   $0x0,0x4
 19f:	00 00 00 
 1a2:	c7 05 00 00 00 00 00 	movl   $0x0,0x0
 1a9:	00 00 00 
 1ac:	a1 00 00 00 00       	mov    0x0,%eax
 1b1:	8b 15 04 00 00 00    	mov    0x4,%edx
 1b7:	8a 92 04 00 00 00    	mov    0x4(%edx),%dl
 1bd:	88 10                	mov    %dl,(%eax)
 1bf:	a1 00 00 00 00       	mov    0x0,%eax
 1c4:	40                   	inc    %eax
 1c5:	a3 00 00 00 00       	mov    %eax,0x0
 1ca:	83 ec 08             	sub    $0x8,%esp
 1cd:	6a 20                	push   $0x20
 1cf:	6a 20                	push   $0x20
 1d1:	e8 fc ff ff ff       	call   1d2 <trap+0x84>
 1d6:	83 c4 10             	add    $0x10,%esp
 1d9:	eb 01                	jmp    1dc <trap+0x8e>
 1db:	90                   	nop
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
 1df:	8b 40 20             	mov    0x20(%eax),%eax
 1e2:	83 f8 20             	cmp    $0x20,%eax
 1e5:	75 5f                	jne    246 <trap+0xf8>
 1e7:	9c                   	pushf  
 1e8:	fa                   	cli    
 1e9:	a1 00 00 00 00       	mov    0x0,%eax
 1ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
 1f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f4:	8b 40 24             	mov    0x24(%eax),%eax
 1f7:	85 c0                	test   %eax,%eax
 1f9:	75 0c                	jne    207 <trap+0xb9>
 1fb:	a1 00 00 00 00       	mov    0x0,%eax
 200:	a3 00 00 00 00       	mov    %eax,0x0
 205:	eb 0b                	jmp    212 <trap+0xc4>
 207:	8b 45 f4             	mov    -0xc(%ebp),%eax
 20a:	8b 40 24             	mov    0x24(%eax),%eax
 20d:	a3 00 00 00 00       	mov    %eax,0x0
 212:	a1 08 00 00 00       	mov    0x8,%eax
 217:	83 f8 01             	cmp    $0x1,%eax
 21a:	7f 21                	jg     23d <trap+0xef>
 21c:	a1 00 00 00 00       	mov    0x0,%eax
 221:	83 ec 08             	sub    $0x8,%esp
 224:	50                   	push   %eax
 225:	68 00 00 00 00       	push   $0x0
 22a:	e8 fc ff ff ff       	call   22b <trap+0xdd>
 22f:	83 c4 10             	add    $0x10,%esp
 232:	a1 08 00 00 00       	mov    0x8,%eax
 237:	40                   	inc    %eax
 238:	a3 08 00 00 00       	mov    %eax,0x8
 23d:	e8 fc ff ff ff       	call   23e <trap+0xf0>	// <0x27415>
 242:	9d                   	popf   
 243:	eb 01                	jmp    246 <trap+0xf8>
 245:	90                   	nop
 246:	c9                   	leave  
 247:	c3                   	ret    

Disassembly of section .data:

00000000 <addr.974>:
   0:	9e                   	sahf   
   1:	80 0b 00             	orb    $0x0,(%ebx)

00000004 <status.973>:
   4:	2d 5c 7c 2f 2d       	sub    $0x2d2f7c5c,%eax
   9:	5c                   	pop    %esp
   a:	7c 2f                	jl     3b <local_counter.975+0x33>

Disassembly of section .bss:

00000000 <cnt.971>:
   0:	00 00                	add    %al,(%eax)
	...

00000004 <pos.972>:
   4:	00 00                	add    %al,(%eax)
	...

00000008 <local_counter.975>:
   8:	00 00                	add    %al,(%eax)
	...

Disassembly of section .rodata:

00000000 <.rodata>:
   0:	54                   	push   %esp
   1:	61                   	popa   
   2:	73 6b                	jae    6f <local_counter.975+0x67>
   4:	4e                   	dec    %esi
   5:	65                   	gs
   6:	78 74                	js     7c <local_counter.975+0x74>
   8:	20 3d 20 25 30 38    	and    %bh,0x38302520
   e:	78 0d                	js     1d <local_counter.975+0x15>
  10:	0a 00                	or     (%eax),%al

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
