
console.o:     file format elf32-i386


Disassembly of section .text:

00000000 <ConpVirtualConsoleAlloc>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	b8 00 00 00 00       	mov    $0x0,%eax
   8:	c9                   	leave  
   9:	c3                   	ret    

0000000a <ConpOpen>:
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	83 ec 10             	sub    $0x10,%esp
  10:	ff 75 fc             	pushl  -0x4(%ebp)
  13:	e8 fc ff ff ff       	call   14 <ConpOpen+0xa>
  18:	83 c4 04             	add    $0x4,%esp
  1b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1e:	b8 00 00 00 00       	mov    $0x0,%eax
  23:	c9                   	leave  
  24:	c3                   	ret    

00000025 <ConpClose>:
  25:	55                   	push   %ebp
  26:	89 e5                	mov    %esp,%ebp
  28:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  2c:	90                   	nop
  2d:	c9                   	leave  
  2e:	c3                   	ret    

0000002f <ConpClearScreen>:
  2f:	55                   	push   %ebp
  30:	89 e5                	mov    %esp,%ebp
  32:	83 ec 18             	sub    $0x18,%esp
  35:	8b 55 08             	mov    0x8(%ebp),%edx
  38:	89 d0                	mov    %edx,%eax
  3a:	c1 e0 02             	shl    $0x2,%eax
  3d:	01 d0                	add    %edx,%eax
  3f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  46:	01 d0                	add    %edx,%eax
  48:	c1 e0 03             	shl    $0x3,%eax
  4b:	05 40 00 00 00       	add    $0x40,%eax
  50:	8b 00                	mov    (%eax),%eax
  52:	89 45 f0             	mov    %eax,-0x10(%ebp)
  55:	8b 55 08             	mov    0x8(%ebp),%edx
  58:	89 d0                	mov    %edx,%eax
  5a:	c1 e0 02             	shl    $0x2,%eax
  5d:	01 d0                	add    %edx,%eax
  5f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  66:	01 d0                	add    %edx,%eax
  68:	c1 e0 03             	shl    $0x3,%eax
  6b:	05 00 00 00 00       	add    $0x0,%eax
  70:	8b 48 04             	mov    0x4(%eax),%ecx
  73:	8b 55 08             	mov    0x8(%ebp),%edx
  76:	89 d0                	mov    %edx,%eax
  78:	c1 e0 02             	shl    $0x2,%eax
  7b:	01 d0                	add    %edx,%eax
  7d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  84:	01 d0                	add    %edx,%eax
  86:	c1 e0 03             	shl    $0x3,%eax
  89:	05 00 00 00 00       	add    $0x0,%eax
  8e:	8b 40 08             	mov    0x8(%eax),%eax
  91:	0f af c1             	imul   %ecx,%eax
  94:	89 45 ec             	mov    %eax,-0x14(%ebp)
  97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  9e:	eb 34                	jmp    d4 <ConpClearScreen+0xa5>
  a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  a3:	c6 00 20             	movb   $0x20,(%eax)
  a6:	ff 45 f0             	incl   -0x10(%ebp)
  a9:	8b 55 08             	mov    0x8(%ebp),%edx
  ac:	89 d0                	mov    %edx,%eax
  ae:	c1 e0 02             	shl    $0x2,%eax
  b1:	01 d0                	add    %edx,%eax
  b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  ba:	01 d0                	add    %edx,%eax
  bc:	c1 e0 03             	shl    $0x3,%eax
  bf:	05 10 00 00 00       	add    $0x10,%eax
  c4:	8a 40 0d             	mov    0xd(%eax),%al
  c7:	88 c2                	mov    %al,%dl
  c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  cc:	88 10                	mov    %dl,(%eax)
  ce:	ff 45 f0             	incl   -0x10(%ebp)
  d1:	ff 45 f4             	incl   -0xc(%ebp)
  d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  da:	7c c4                	jl     a0 <ConpClearScreen+0x71>
  dc:	83 ec 0c             	sub    $0xc,%esp
  df:	ff 75 08             	pushl  0x8(%ebp)
  e2:	e8 e3 03 00 00       	call   4ca <ConpUpdateCursorPos>
  e7:	83 c4 10             	add    $0x10,%esp
  ea:	c9                   	leave  
  eb:	c3                   	ret    

000000ec <ConpScrollUp>:
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	53                   	push   %ebx
  f0:	83 ec 10             	sub    $0x10,%esp
  f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  f9:	0f 83 c8 01 00 00    	jae    2c7 <ConpScrollUp+0x1db>
  ff:	8b 55 08             	mov    0x8(%ebp),%edx
 102:	89 d0                	mov    %edx,%eax
 104:	c1 e0 02             	shl    $0x2,%eax
 107:	01 d0                	add    %edx,%eax
 109:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 110:	01 d0                	add    %edx,%eax
 112:	c1 e0 03             	shl    $0x3,%eax
 115:	05 40 00 00 00       	add    $0x40,%eax
 11a:	8b 08                	mov    (%eax),%ecx
 11c:	8b 55 08             	mov    0x8(%ebp),%edx
 11f:	89 d0                	mov    %edx,%eax
 121:	c1 e0 02             	shl    $0x2,%eax
 124:	01 d0                	add    %edx,%eax
 126:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 12d:	01 d0                	add    %edx,%eax
 12f:	c1 e0 03             	shl    $0x3,%eax
 132:	05 00 00 00 00       	add    $0x0,%eax
 137:	8b 40 0c             	mov    0xc(%eax),%eax
 13a:	0f af 45 0c          	imul   0xc(%ebp),%eax
 13e:	8d 04 01             	lea    (%ecx,%eax,1),%eax
 141:	89 45 f4             	mov    %eax,-0xc(%ebp)
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	89 d0                	mov    %edx,%eax
 149:	c1 e0 02             	shl    $0x2,%eax
 14c:	01 d0                	add    %edx,%eax
 14e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 155:	01 d0                	add    %edx,%eax
 157:	c1 e0 03             	shl    $0x3,%eax
 15a:	05 40 00 00 00       	add    $0x40,%eax
 15f:	8b 08                	mov    (%eax),%ecx
 161:	8b 55 08             	mov    0x8(%ebp),%edx
 164:	89 d0                	mov    %edx,%eax
 166:	c1 e0 02             	shl    $0x2,%eax
 169:	01 d0                	add    %edx,%eax
 16b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 172:	01 d0                	add    %edx,%eax
 174:	c1 e0 03             	shl    $0x3,%eax
 177:	05 00 00 00 00       	add    $0x0,%eax
 17c:	8b 40 0c             	mov    0xc(%eax),%eax
 17f:	8b 55 0c             	mov    0xc(%ebp),%edx
 182:	42                   	inc    %edx
 183:	0f af c2             	imul   %edx,%eax
 186:	8d 04 01             	lea    (%ecx,%eax,1),%eax
 189:	89 45 f8             	mov    %eax,-0x8(%ebp)
 18c:	8b 45 0c             	mov    0xc(%ebp),%eax
 18f:	8b 55 10             	mov    0x10(%ebp),%edx
 192:	89 d1                	mov    %edx,%ecx
 194:	29 c1                	sub    %eax,%ecx
 196:	89 c8                	mov    %ecx,%eax
 198:	8d 48 ff             	lea    -0x1(%eax),%ecx
 19b:	8b 55 08             	mov    0x8(%ebp),%edx
 19e:	89 d0                	mov    %edx,%eax
 1a0:	c1 e0 02             	shl    $0x2,%eax
 1a3:	01 d0                	add    %edx,%eax
 1a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1ac:	01 d0                	add    %edx,%eax
 1ae:	c1 e0 03             	shl    $0x3,%eax
 1b1:	05 00 00 00 00       	add    $0x0,%eax
 1b6:	8b 40 04             	mov    0x4(%eax),%eax
 1b9:	0f af c1             	imul   %ecx,%eax
 1bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1bf:	eb 20                	jmp    1e1 <ConpScrollUp+0xf5>
 1c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 1c4:	8a 10                	mov    (%eax),%dl
 1c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c9:	88 10                	mov    %dl,(%eax)
 1cb:	ff 45 f4             	incl   -0xc(%ebp)
 1ce:	ff 45 f8             	incl   -0x8(%ebp)
 1d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 1d4:	8a 10                	mov    (%eax),%dl
 1d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d9:	88 10                	mov    %dl,(%eax)
 1db:	ff 45 f4             	incl   -0xc(%ebp)
 1de:	ff 45 f8             	incl   -0x8(%ebp)
 1e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
 1e7:	72 d8                	jb     1c1 <ConpScrollUp+0xd5>
 1e9:	8b 55 08             	mov    0x8(%ebp),%edx
 1ec:	89 d0                	mov    %edx,%eax
 1ee:	c1 e0 02             	shl    $0x2,%eax
 1f1:	01 d0                	add    %edx,%eax
 1f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1fa:	01 d0                	add    %edx,%eax
 1fc:	c1 e0 03             	shl    $0x3,%eax
 1ff:	05 40 00 00 00       	add    $0x40,%eax
 204:	8b 08                	mov    (%eax),%ecx
 206:	8b 45 0c             	mov    0xc(%ebp),%eax
 209:	8b 55 10             	mov    0x10(%ebp),%edx
 20c:	89 d3                	mov    %edx,%ebx
 20e:	29 c3                	sub    %eax,%ebx
 210:	89 d8                	mov    %ebx,%eax
 212:	8d 58 ff             	lea    -0x1(%eax),%ebx
 215:	8b 55 08             	mov    0x8(%ebp),%edx
 218:	89 d0                	mov    %edx,%eax
 21a:	c1 e0 02             	shl    $0x2,%eax
 21d:	01 d0                	add    %edx,%eax
 21f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 226:	01 d0                	add    %edx,%eax
 228:	c1 e0 03             	shl    $0x3,%eax
 22b:	05 00 00 00 00       	add    $0x0,%eax
 230:	8b 40 0c             	mov    0xc(%eax),%eax
 233:	0f af c3             	imul   %ebx,%eax
 236:	8d 04 01             	lea    (%ecx,%eax,1),%eax
 239:	89 45 f4             	mov    %eax,-0xc(%ebp)
 23c:	8b 55 08             	mov    0x8(%ebp),%edx
 23f:	89 d0                	mov    %edx,%eax
 241:	c1 e0 02             	shl    $0x2,%eax
 244:	01 d0                	add    %edx,%eax
 246:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 24d:	01 d0                	add    %edx,%eax
 24f:	c1 e0 03             	shl    $0x3,%eax
 252:	05 40 00 00 00       	add    $0x40,%eax
 257:	8b 08                	mov    (%eax),%ecx
 259:	8b 45 0c             	mov    0xc(%ebp),%eax
 25c:	8b 55 10             	mov    0x10(%ebp),%edx
 25f:	89 d3                	mov    %edx,%ebx
 261:	29 c3                	sub    %eax,%ebx
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	89 d0                	mov    %edx,%eax
 268:	c1 e0 02             	shl    $0x2,%eax
 26b:	01 d0                	add    %edx,%eax
 26d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 274:	01 d0                	add    %edx,%eax
 276:	c1 e0 03             	shl    $0x3,%eax
 279:	05 00 00 00 00       	add    $0x0,%eax
 27e:	8b 40 0c             	mov    0xc(%eax),%eax
 281:	0f af c3             	imul   %ebx,%eax
 284:	8d 04 01             	lea    (%ecx,%eax,1),%eax
 287:	89 45 f0             	mov    %eax,-0x10(%ebp)
 28a:	eb 31                	jmp    2bd <ConpScrollUp+0x1d1>
 28c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28f:	c6 00 20             	movb   $0x20,(%eax)
 292:	ff 45 f4             	incl   -0xc(%ebp)
 295:	8b 55 08             	mov    0x8(%ebp),%edx
 298:	89 d0                	mov    %edx,%eax
 29a:	c1 e0 02             	shl    $0x2,%eax
 29d:	01 d0                	add    %edx,%eax
 29f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2a6:	01 d0                	add    %edx,%eax
 2a8:	c1 e0 03             	shl    $0x3,%eax
 2ab:	05 10 00 00 00       	add    $0x10,%eax
 2b0:	8a 40 0d             	mov    0xd(%eax),%al
 2b3:	88 c2                	mov    %al,%dl
 2b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b8:	88 10                	mov    %dl,(%eax)
 2ba:	ff 45 f4             	incl   -0xc(%ebp)
 2bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
 2c3:	72 c7                	jb     28c <ConpScrollUp+0x1a0>
 2c5:	eb 01                	jmp    2c8 <ConpScrollUp+0x1dc>
 2c7:	90                   	nop
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	5b                   	pop    %ebx
 2cc:	c9                   	leave  
 2cd:	c3                   	ret    

000002ce <ConpKeyLF>:
 2ce:	55                   	push   %ebp
 2cf:	89 e5                	mov    %esp,%ebp
 2d1:	8b 55 08             	mov    0x8(%ebp),%edx
 2d4:	89 d0                	mov    %edx,%eax
 2d6:	c1 e0 02             	shl    $0x2,%eax
 2d9:	01 d0                	add    %edx,%eax
 2db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2e2:	01 d0                	add    %edx,%eax
 2e4:	c1 e0 03             	shl    $0x3,%eax
 2e7:	05 30 00 00 00       	add    $0x30,%eax
 2ec:	8b 00                	mov    (%eax),%eax
 2ee:	8d 48 01             	lea    0x1(%eax),%ecx
 2f1:	8b 55 08             	mov    0x8(%ebp),%edx
 2f4:	89 d0                	mov    %edx,%eax
 2f6:	c1 e0 02             	shl    $0x2,%eax
 2f9:	01 d0                	add    %edx,%eax
 2fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 302:	01 d0                	add    %edx,%eax
 304:	c1 e0 03             	shl    $0x3,%eax
 307:	05 30 00 00 00       	add    $0x30,%eax
 30c:	8b 40 08             	mov    0x8(%eax),%eax
 30f:	39 c1                	cmp    %eax,%ecx
 311:	0f 83 9b 00 00 00    	jae    3b2 <ConpKeyLF+0xe4>
 317:	8b 55 08             	mov    0x8(%ebp),%edx
 31a:	89 d0                	mov    %edx,%eax
 31c:	c1 e0 02             	shl    $0x2,%eax
 31f:	01 d0                	add    %edx,%eax
 321:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 328:	01 d0                	add    %edx,%eax
 32a:	c1 e0 03             	shl    $0x3,%eax
 32d:	05 30 00 00 00       	add    $0x30,%eax
 332:	8b 00                	mov    (%eax),%eax
 334:	8d 48 01             	lea    0x1(%eax),%ecx
 337:	8b 55 08             	mov    0x8(%ebp),%edx
 33a:	89 d0                	mov    %edx,%eax
 33c:	c1 e0 02             	shl    $0x2,%eax
 33f:	01 d0                	add    %edx,%eax
 341:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 348:	01 d0                	add    %edx,%eax
 34a:	c1 e0 03             	shl    $0x3,%eax
 34d:	05 30 00 00 00       	add    $0x30,%eax
 352:	89 08                	mov    %ecx,(%eax)
 354:	8b 55 08             	mov    0x8(%ebp),%edx
 357:	89 d0                	mov    %edx,%eax
 359:	c1 e0 02             	shl    $0x2,%eax
 35c:	01 d0                	add    %edx,%eax
 35e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 365:	01 d0                	add    %edx,%eax
 367:	c1 e0 03             	shl    $0x3,%eax
 36a:	05 40 00 00 00       	add    $0x40,%eax
 36f:	8b 48 0c             	mov    0xc(%eax),%ecx
 372:	8b 55 08             	mov    0x8(%ebp),%edx
 375:	89 d0                	mov    %edx,%eax
 377:	c1 e0 02             	shl    $0x2,%eax
 37a:	01 d0                	add    %edx,%eax
 37c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 383:	01 d0                	add    %edx,%eax
 385:	c1 e0 03             	shl    $0x3,%eax
 388:	05 00 00 00 00       	add    $0x0,%eax
 38d:	8b 40 0c             	mov    0xc(%eax),%eax
 390:	01 c1                	add    %eax,%ecx
 392:	8b 55 08             	mov    0x8(%ebp),%edx
 395:	89 d0                	mov    %edx,%eax
 397:	c1 e0 02             	shl    $0x2,%eax
 39a:	01 d0                	add    %edx,%eax
 39c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 3a3:	01 d0                	add    %edx,%eax
 3a5:	c1 e0 03             	shl    $0x3,%eax
 3a8:	05 40 00 00 00       	add    $0x40,%eax
 3ad:	89 48 0c             	mov    %ecx,0xc(%eax)
 3b0:	eb 6d                	jmp    41f <ConpKeyLF+0x151>
 3b2:	8b 55 08             	mov    0x8(%ebp),%edx
 3b5:	89 d0                	mov    %edx,%eax
 3b7:	c1 e0 02             	shl    $0x2,%eax
 3ba:	01 d0                	add    %edx,%eax
 3bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 3c3:	01 d0                	add    %edx,%eax
 3c5:	c1 e0 03             	shl    $0x3,%eax
 3c8:	05 30 00 00 00       	add    $0x30,%eax
 3cd:	8b 50 08             	mov    0x8(%eax),%edx
 3d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3d3:	89 c8                	mov    %ecx,%eax
 3d5:	c1 e0 02             	shl    $0x2,%eax
 3d8:	01 c8                	add    %ecx,%eax
 3da:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 3e1:	01 c8                	add    %ecx,%eax
 3e3:	c1 e0 03             	shl    $0x3,%eax
 3e6:	05 30 00 00 00       	add    $0x30,%eax
 3eb:	8b 40 04             	mov    0x4(%eax),%eax
 3ee:	52                   	push   %edx
 3ef:	50                   	push   %eax
 3f0:	ff 75 08             	pushl  0x8(%ebp)
 3f3:	e8 f4 fc ff ff       	call   ec <ConpScrollUp>
 3f8:	83 c4 0c             	add    $0xc,%esp
 3fb:	8b 55 08             	mov    0x8(%ebp),%edx
 3fe:	89 d0                	mov    %edx,%eax
 400:	c1 e0 02             	shl    $0x2,%eax
 403:	01 d0                	add    %edx,%eax
 405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 40c:	01 d0                	add    %edx,%eax
 40e:	c1 e0 03             	shl    $0x3,%eax
 411:	05 50 00 00 00       	add    $0x50,%eax
 416:	8a 50 0a             	mov    0xa(%eax),%dl
 419:	83 e2 df             	and    $0xffffffdf,%edx
 41c:	88 50 0a             	mov    %dl,0xa(%eax)
 41f:	c9                   	leave  
 420:	c3                   	ret    

00000421 <ConpKeyCR>:
 421:	55                   	push   %ebp
 422:	89 e5                	mov    %esp,%ebp
 424:	8b 55 08             	mov    0x8(%ebp),%edx
 427:	89 d0                	mov    %edx,%eax
 429:	c1 e0 02             	shl    $0x2,%eax
 42c:	01 d0                	add    %edx,%eax
 42e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 435:	01 d0                	add    %edx,%eax
 437:	c1 e0 03             	shl    $0x3,%eax
 43a:	05 40 00 00 00       	add    $0x40,%eax
 43f:	8b 48 0c             	mov    0xc(%eax),%ecx
 442:	8b 55 08             	mov    0x8(%ebp),%edx
 445:	89 d0                	mov    %edx,%eax
 447:	c1 e0 02             	shl    $0x2,%eax
 44a:	01 d0                	add    %edx,%eax
 44c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 453:	01 d0                	add    %edx,%eax
 455:	c1 e0 03             	shl    $0x3,%eax
 458:	05 20 00 00 00       	add    $0x20,%eax
 45d:	8b 40 0c             	mov    0xc(%eax),%eax
 460:	d1 e0                	shl    %eax
 462:	29 c1                	sub    %eax,%ecx
 464:	8b 55 08             	mov    0x8(%ebp),%edx
 467:	89 d0                	mov    %edx,%eax
 469:	c1 e0 02             	shl    $0x2,%eax
 46c:	01 d0                	add    %edx,%eax
 46e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 475:	01 d0                	add    %edx,%eax
 477:	c1 e0 03             	shl    $0x3,%eax
 47a:	05 40 00 00 00       	add    $0x40,%eax
 47f:	89 48 0c             	mov    %ecx,0xc(%eax)
 482:	8b 55 08             	mov    0x8(%ebp),%edx
 485:	89 d0                	mov    %edx,%eax
 487:	c1 e0 02             	shl    $0x2,%eax
 48a:	01 d0                	add    %edx,%eax
 48c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 493:	01 d0                	add    %edx,%eax
 495:	c1 e0 03             	shl    $0x3,%eax
 498:	05 20 00 00 00       	add    $0x20,%eax
 49d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
 4a4:	8b 55 08             	mov    0x8(%ebp),%edx
 4a7:	89 d0                	mov    %edx,%eax
 4a9:	c1 e0 02             	shl    $0x2,%eax
 4ac:	01 d0                	add    %edx,%eax
 4ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 4b5:	01 d0                	add    %edx,%eax
 4b7:	c1 e0 03             	shl    $0x3,%eax
 4ba:	05 50 00 00 00       	add    $0x50,%eax
 4bf:	8a 50 0a             	mov    0xa(%eax),%dl
 4c2:	83 e2 df             	and    $0xffffffdf,%edx
 4c5:	88 50 0a             	mov    %dl,0xa(%eax)
 4c8:	c9                   	leave  
 4c9:	c3                   	ret    

000004ca <ConpUpdateCursorPos>:
 4ca:	55                   	push   %ebp
 4cb:	89 e5                	mov    %esp,%ebp
 4cd:	53                   	push   %ebx
 4ce:	83 ec 14             	sub    $0x14,%esp
 4d1:	8b 55 08             	mov    0x8(%ebp),%edx
 4d4:	89 d0                	mov    %edx,%eax
 4d6:	c1 e0 02             	shl    $0x2,%eax
 4d9:	01 d0                	add    %edx,%eax
 4db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 4e2:	01 d0                	add    %edx,%eax
 4e4:	c1 e0 03             	shl    $0x3,%eax
 4e7:	05 20 00 00 00       	add    $0x20,%eax
 4ec:	8b 48 0c             	mov    0xc(%eax),%ecx
 4ef:	8b 55 08             	mov    0x8(%ebp),%edx
 4f2:	89 d0                	mov    %edx,%eax
 4f4:	c1 e0 02             	shl    $0x2,%eax
 4f7:	01 d0                	add    %edx,%eax
 4f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 500:	01 d0                	add    %edx,%eax
 502:	c1 e0 03             	shl    $0x3,%eax
 505:	05 30 00 00 00       	add    $0x30,%eax
 50a:	8b 18                	mov    (%eax),%ebx
 50c:	8b 55 08             	mov    0x8(%ebp),%edx
 50f:	89 d0                	mov    %edx,%eax
 511:	c1 e0 02             	shl    $0x2,%eax
 514:	01 d0                	add    %edx,%eax
 516:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 51d:	01 d0                	add    %edx,%eax
 51f:	c1 e0 03             	shl    $0x3,%eax
 522:	05 00 00 00 00       	add    $0x0,%eax
 527:	8b 40 0c             	mov    0xc(%eax),%eax
 52a:	0f af c3             	imul   %ebx,%eax
 52d:	8d 04 01             	lea    (%ecx,%eax,1),%eax
 530:	c1 e8 08             	shr    $0x8,%eax
 533:	88 45 f7             	mov    %al,-0x9(%ebp)
 536:	83 ec 08             	sub    $0x8,%esp
 539:	6a 0e                	push   $0xe
 53b:	68 d4 03 00 00       	push   $0x3d4
 540:	e8 fc ff ff ff       	call   541 <ConpUpdateCursorPos+0x77>
 545:	83 c4 10             	add    $0x10,%esp
 548:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
 54c:	83 ec 08             	sub    $0x8,%esp
 54f:	50                   	push   %eax
 550:	68 d5 03 00 00       	push   $0x3d5
 555:	e8 fc ff ff ff       	call   556 <ConpUpdateCursorPos+0x8c>
 55a:	83 c4 10             	add    $0x10,%esp
 55d:	8b 55 08             	mov    0x8(%ebp),%edx
 560:	89 d0                	mov    %edx,%eax
 562:	c1 e0 02             	shl    $0x2,%eax
 565:	01 d0                	add    %edx,%eax
 567:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 56e:	01 d0                	add    %edx,%eax
 570:	c1 e0 03             	shl    $0x3,%eax
 573:	05 20 00 00 00       	add    $0x20,%eax
 578:	8b 40 0c             	mov    0xc(%eax),%eax
 57b:	88 c1                	mov    %al,%cl
 57d:	8b 55 08             	mov    0x8(%ebp),%edx
 580:	89 d0                	mov    %edx,%eax
 582:	c1 e0 02             	shl    $0x2,%eax
 585:	01 d0                	add    %edx,%eax
 587:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 58e:	01 d0                	add    %edx,%eax
 590:	c1 e0 03             	shl    $0x3,%eax
 593:	05 30 00 00 00       	add    $0x30,%eax
 598:	8b 00                	mov    (%eax),%eax
 59a:	88 c3                	mov    %al,%bl
 59c:	8b 55 08             	mov    0x8(%ebp),%edx
 59f:	89 d0                	mov    %edx,%eax
 5a1:	c1 e0 02             	shl    $0x2,%eax
 5a4:	01 d0                	add    %edx,%eax
 5a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 5ad:	01 d0                	add    %edx,%eax
 5af:	c1 e0 03             	shl    $0x3,%eax
 5b2:	05 00 00 00 00       	add    $0x0,%eax
 5b7:	8b 40 0c             	mov    0xc(%eax),%eax
 5ba:	88 c2                	mov    %al,%dl
 5bc:	88 d8                	mov    %bl,%al
 5be:	f6 e2                	mul    %dl
 5c0:	8d 04 01             	lea    (%ecx,%eax,1),%eax
 5c3:	88 45 f7             	mov    %al,-0x9(%ebp)
 5c6:	83 ec 08             	sub    $0x8,%esp
 5c9:	6a 0f                	push   $0xf
 5cb:	68 d4 03 00 00       	push   $0x3d4
 5d0:	e8 fc ff ff ff       	call   5d1 <ConpUpdateCursorPos+0x107>
 5d5:	83 c4 10             	add    $0x10,%esp
 5d8:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
 5dc:	83 ec 08             	sub    $0x8,%esp
 5df:	50                   	push   %eax
 5e0:	68 d5 03 00 00       	push   $0x3d5
 5e5:	e8 fc ff ff ff       	call   5e6 <ConpUpdateCursorPos+0x11c>
 5ea:	83 c4 10             	add    $0x10,%esp
 5ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5f0:	c9                   	leave  
 5f1:	c3                   	ret    

000005f2 <ConpConsolePrint>: 1839e-5f2=17dac, 18554-1839e+5f2, 5f2+13=605
 5f2:	55                   	push   %ebp
 5f3:	89 e5                	mov    %esp,%ebp
 5f5:	83 ec 18             	sub    $0x18,%esp
 5f8:	a1 00 00 00 00       	mov    0x0,%eax
 5fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 600:	e9 a3 01 00 00       	jmp    7a8 <ConpConsolePrint+0x1b6>
 605:	80 7d f3 0a          	cmpb   $0xa,-0xd(%ebp)
 609:	74 2e                	je     639 <ConpConsolePrint+0x47>
 60b:	80 7d f3 0d          	cmpb   $0xd,-0xd(%ebp)
 60f:	74 28                	je     639 <ConpConsolePrint+0x47>
 611:	8b 55 f4             	mov    -0xc(%ebp),%edx
 614:	89 d0                	mov    %edx,%eax
 616:	c1 e0 02             	shl    $0x2,%eax
 619:	01 d0                	add    %edx,%eax
 61b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 622:	01 d0                	add    %edx,%eax
 624:	c1 e0 03             	shl    $0x3,%eax
 627:	05 50 00 00 00       	add    $0x50,%eax
 62c:	8a 40 0a             	mov    0xa(%eax),%al
 62f:	c0 e8 05             	shr    $0x5,%al
 632:	83 e0 01             	and    $0x1,%eax
 635:	84 c0                	test   %al,%al
 637:	74 30                	je     669 <ConpConsolePrint+0x77>
 639:	80 7d f3 0d          	cmpb   $0xd,-0xd(%ebp)
 63d:	74 0b                	je     64a <ConpConsolePrint+0x58>
 63f:	ff 75 f4             	pushl  -0xc(%ebp)
 642:	e8 87 fc ff ff       	call   2ce <ConpKeyLF>
 647:	83 c4 04             	add    $0x4,%esp
 64a:	ff 75 f4             	pushl  -0xc(%ebp)
 64d:	e8 cf fd ff ff       	call   421 <ConpKeyCR>
 652:	83 c4 04             	add    $0x4,%esp
 655:	80 7d f3 0a          	cmpb   $0xa,-0xd(%ebp)
 659:	0f 84 45 01 00 00    	je     7a4 <ConpConsolePrint+0x1b2>
 65f:	80 7d f3 0d          	cmpb   $0xd,-0xd(%ebp)
 663:	0f 84 3e 01 00 00    	je     7a7 <ConpConsolePrint+0x1b5>
 669:	8b 55 f4             	mov    -0xc(%ebp),%edx
 66c:	89 d0                	mov    %edx,%eax
 66e:	c1 e0 02             	shl    $0x2,%eax
 671:	01 d0                	add    %edx,%eax
 673:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 67a:	01 d0                	add    %edx,%eax
 67c:	c1 e0 03             	shl    $0x3,%eax
 67f:	05 40 00 00 00       	add    $0x40,%eax
 684:	8b 40 0c             	mov    0xc(%eax),%eax
 687:	89 c1                	mov    %eax,%ecx
 689:	8b 55 f4             	mov    -0xc(%ebp),%edx
 68c:	89 d0                	mov    %edx,%eax
 68e:	c1 e0 02             	shl    $0x2,%eax
 691:	01 d0                	add    %edx,%eax
 693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 69a:	01 d0                	add    %edx,%eax
 69c:	c1 e0 03             	shl    $0x3,%eax
 69f:	05 10 00 00 00       	add    $0x10,%eax
 6a4:	8a 40 0c             	mov    0xc(%eax),%al
 6a7:	0f b6 c0             	movzbl %al,%eax
 6aa:	89 c2                	mov    %eax,%edx
 6ac:	c1 e2 08             	shl    $0x8,%edx
 6af:	66 0f be 45 f3       	movsbw -0xd(%ebp),%ax
 6b4:	8d 04 02             	lea    (%edx,%eax,1),%eax
 6b7:	66 89 01             	mov    %ax,(%ecx)
 6ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6bd:	89 d0                	mov    %edx,%eax
 6bf:	c1 e0 02             	shl    $0x2,%eax
 6c2:	01 d0                	add    %edx,%eax
 6c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 6cb:	01 d0                	add    %edx,%eax
 6cd:	c1 e0 03             	shl    $0x3,%eax
 6d0:	05 20 00 00 00       	add    $0x20,%eax
 6d5:	8b 48 0c             	mov    0xc(%eax),%ecx
 6d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6db:	89 d0                	mov    %edx,%eax
 6dd:	c1 e0 02             	shl    $0x2,%eax
 6e0:	01 d0                	add    %edx,%eax
 6e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 6e9:	01 d0                	add    %edx,%eax
 6eb:	c1 e0 03             	shl    $0x3,%eax
 6ee:	05 00 00 00 00       	add    $0x0,%eax
 6f3:	8b 40 04             	mov    0x4(%eax),%eax
 6f6:	48                   	dec    %eax
 6f7:	39 c1                	cmp    %eax,%ecx
 6f9:	75 29                	jne    724 <ConpConsolePrint+0x132>
 6fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6fe:	89 d0                	mov    %edx,%eax
 700:	c1 e0 02             	shl    $0x2,%eax
 703:	01 d0                	add    %edx,%eax
 705:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 70c:	01 d0                	add    %edx,%eax
 70e:	c1 e0 03             	shl    $0x3,%eax
 711:	05 50 00 00 00       	add    $0x50,%eax
 716:	8a 50 0a             	mov    0xa(%eax),%dl
 719:	83 ca 20             	or     $0x20,%edx
 71c:	88 50 0a             	mov    %dl,0xa(%eax)
 71f:	e9 84 00 00 00       	jmp    7a8 <ConpConsolePrint+0x1b6>
 724:	8b 55 f4             	mov    -0xc(%ebp),%edx
 727:	89 d0                	mov    %edx,%eax
 729:	c1 e0 02             	shl    $0x2,%eax
 72c:	01 d0                	add    %edx,%eax
 72e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 735:	01 d0                	add    %edx,%eax
 737:	c1 e0 03             	shl    $0x3,%eax
 73a:	05 20 00 00 00       	add    $0x20,%eax
 73f:	8b 40 0c             	mov    0xc(%eax),%eax
 742:	8d 48 01             	lea    0x1(%eax),%ecx
 745:	8b 55 f4             	mov    -0xc(%ebp),%edx
 748:	89 d0                	mov    %edx,%eax
 74a:	c1 e0 02             	shl    $0x2,%eax
 74d:	01 d0                	add    %edx,%eax
 74f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 756:	01 d0                	add    %edx,%eax
 758:	c1 e0 03             	shl    $0x3,%eax
 75b:	05 20 00 00 00       	add    $0x20,%eax
 760:	89 48 0c             	mov    %ecx,0xc(%eax)
 763:	8b 55 f4             	mov    -0xc(%ebp),%edx
 766:	89 d0                	mov    %edx,%eax
 768:	c1 e0 02             	shl    $0x2,%eax
 76b:	01 d0                	add    %edx,%eax
 76d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 774:	01 d0                	add    %edx,%eax
 776:	c1 e0 03             	shl    $0x3,%eax
 779:	05 40 00 00 00       	add    $0x40,%eax
 77e:	8b 40 0c             	mov    0xc(%eax),%eax
 781:	8d 48 02             	lea    0x2(%eax),%ecx
 784:	8b 55 f4             	mov    -0xc(%ebp),%edx
 787:	89 d0                	mov    %edx,%eax
 789:	c1 e0 02             	shl    $0x2,%eax
 78c:	01 d0                	add    %edx,%eax
 78e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 795:	01 d0                	add    %edx,%eax
 797:	c1 e0 03             	shl    $0x3,%eax
 79a:	05 40 00 00 00       	add    $0x40,%eax
 79f:	89 48 0c             	mov    %ecx,0xc(%eax)
 7a2:	eb 04                	jmp    7a8 <ConpConsolePrint+0x1b6>
 7a4:	90                   	nop
 7a5:	eb 01                	jmp    7a8 <ConpConsolePrint+0x1b6>
 7a7:	90                   	nop
 7a8:	8b 45 08             	mov    0x8(%ebp),%eax ; 18554
 7ab:	8a 00                	mov    (%eax),%al
 7ad:	88 45 f3             	mov    %al,-0xd(%ebp)
 7b0:	80 7d f3 00          	cmpb   $0x0,-0xd(%ebp)
 7b4:	0f 95 c0             	setne  %al
 7b7:	ff 45 08             	incl   0x8(%ebp)
 7ba:	84 c0                	test   %al,%al
 7bc:	0f 85 43 fe ff ff    	jne    605 <ConpConsolePrint+0x13> ; 1839e-183b1+5f2
 7c2:	83 ec 0c             	sub    $0xc,%esp
 7c5:	ff 75 f4             	pushl  -0xc(%ebp)
 7c8:	e8 fd fc ff ff       	call   4ca <ConpUpdateCursorPos>
 7cd:	83 c4 10             	add    $0x10,%esp
 7d0:	c9                   	leave  
 7d1:	c3                   	ret    

000007d2 <ConInitialize>:
 7d2:	55                   	push   %ebp
 7d3:	89 e5                	mov    %esp,%ebp
 7d5:	83 ec 18             	sub    $0x18,%esp
 7d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 7df:	c7 05 00 00 00 00 00 	movl   $0x0,0x0
 7e6:	00 00 00 
 7e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 7f0:	e9 77 02 00 00       	jmp    a6c <ConInitialize+0x29a>
 7f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 7f8:	89 d0                	mov    %edx,%eax
 7fa:	c1 e0 02             	shl    $0x2,%eax
 7fd:	01 d0                	add    %edx,%eax
 7ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 806:	01 d0                	add    %edx,%eax
 808:	c1 e0 03             	shl    $0x3,%eax
 80b:	05 00 00 00 00       	add    $0x0,%eax
 810:	83 ec 04             	sub    $0x4,%esp
 813:	68 c8 00 00 00       	push   $0xc8
 818:	6a 00                	push   $0x0
 81a:	50                   	push   %eax
 81b:	e8 fc ff ff ff       	call   81c <ConInitialize+0x4a>
 820:	83 c4 10             	add    $0x10,%esp
 823:	8b 55 f4             	mov    -0xc(%ebp),%edx
 826:	89 d0                	mov    %edx,%eax
 828:	c1 e0 02             	shl    $0x2,%eax
 82b:	01 d0                	add    %edx,%eax
 82d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 834:	01 d0                	add    %edx,%eax
 836:	c1 e0 03             	shl    $0x3,%eax
 839:	05 10 00 00 00       	add    $0x10,%eax
 83e:	c7 40 04 00 00 10 00 	movl   $0x100000,0x4(%eax)
 845:	8b 55 f4             	mov    -0xc(%ebp),%edx
 848:	89 d0                	mov    %edx,%eax
 84a:	c1 e0 02             	shl    $0x2,%eax
 84d:	01 d0                	add    %edx,%eax
 84f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 856:	01 d0                	add    %edx,%eax
 858:	c1 e0 03             	shl    $0x3,%eax
 85b:	05 40 00 00 00       	add    $0x40,%eax
 860:	c7 00 00 80 0b 00    	movl   $0xb8000,(%eax)
 866:	8b 55 f4             	mov    -0xc(%ebp),%edx
 869:	89 d0                	mov    %edx,%eax
 86b:	c1 e0 02             	shl    $0x2,%eax
 86e:	01 d0                	add    %edx,%eax
 870:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 877:	01 d0                	add    %edx,%eax
 879:	c1 e0 03             	shl    $0x3,%eax
 87c:	05 40 00 00 00       	add    $0x40,%eax
 881:	8b 10                	mov    (%eax),%edx
 883:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 886:	89 c8                	mov    %ecx,%eax
 888:	c1 e0 02             	shl    $0x2,%eax
 88b:	01 c8                	add    %ecx,%eax
 88d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 894:	01 c8                	add    %ecx,%eax
 896:	c1 e0 03             	shl    $0x3,%eax
 899:	05 40 00 00 00       	add    $0x40,%eax
 89e:	89 50 0c             	mov    %edx,0xc(%eax)
 8a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8a4:	89 d0                	mov    %edx,%eax
 8a6:	c1 e0 02             	shl    $0x2,%eax
 8a9:	01 d0                	add    %edx,%eax
 8ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 8b2:	01 d0                	add    %edx,%eax
 8b4:	c1 e0 03             	shl    $0x3,%eax
 8b7:	05 00 00 00 00       	add    $0x0,%eax
 8bc:	c7 40 04 50 00 00 00 	movl   $0x50,0x4(%eax)
 8c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8c6:	89 d0                	mov    %edx,%eax
 8c8:	c1 e0 02             	shl    $0x2,%eax
 8cb:	01 d0                	add    %edx,%eax
 8cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 8d4:	01 d0                	add    %edx,%eax
 8d6:	c1 e0 03             	shl    $0x3,%eax
 8d9:	05 00 00 00 00       	add    $0x0,%eax
 8de:	8b 40 04             	mov    0x4(%eax),%eax
 8e1:	8d 0c 00             	lea    (%eax,%eax,1),%ecx
 8e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8e7:	89 d0                	mov    %edx,%eax
 8e9:	c1 e0 02             	shl    $0x2,%eax
 8ec:	01 d0                	add    %edx,%eax
 8ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 8f5:	01 d0                	add    %edx,%eax
 8f7:	c1 e0 03             	shl    $0x3,%eax
 8fa:	05 00 00 00 00       	add    $0x0,%eax
 8ff:	89 48 0c             	mov    %ecx,0xc(%eax)
 902:	8b 55 f4             	mov    -0xc(%ebp),%edx
 905:	89 d0                	mov    %edx,%eax
 907:	c1 e0 02             	shl    $0x2,%eax
 90a:	01 d0                	add    %edx,%eax
 90c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 913:	01 d0                	add    %edx,%eax
 915:	c1 e0 03             	shl    $0x3,%eax
 918:	05 00 00 00 00       	add    $0x0,%eax
 91d:	c7 40 08 19 00 00 00 	movl   $0x19,0x8(%eax)
 924:	8b 55 f4             	mov    -0xc(%ebp),%edx
 927:	89 d0                	mov    %edx,%eax
 929:	c1 e0 02             	shl    $0x2,%eax
 92c:	01 d0                	add    %edx,%eax
 92e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 935:	01 d0                	add    %edx,%eax
 937:	c1 e0 03             	shl    $0x3,%eax
 93a:	05 10 00 00 00       	add    $0x10,%eax
 93f:	c6 40 0d 07          	movb   $0x7,0xd(%eax)
 943:	8b 55 f4             	mov    -0xc(%ebp),%edx
 946:	89 d0                	mov    %edx,%eax
 948:	c1 e0 02             	shl    $0x2,%eax
 94b:	01 d0                	add    %edx,%eax
 94d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 954:	01 d0                	add    %edx,%eax
 956:	c1 e0 03             	shl    $0x3,%eax
 959:	05 30 00 00 00       	add    $0x30,%eax
 95e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 964:	8b 55 f4             	mov    -0xc(%ebp),%edx
 967:	89 d0                	mov    %edx,%eax
 969:	c1 e0 02             	shl    $0x2,%eax
 96c:	01 d0                	add    %edx,%eax
 96e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 975:	01 d0                	add    %edx,%eax
 977:	c1 e0 03             	shl    $0x3,%eax
 97a:	05 30 00 00 00       	add    $0x30,%eax
 97f:	8b 10                	mov    (%eax),%edx
 981:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 984:	89 c8                	mov    %ecx,%eax
 986:	c1 e0 02             	shl    $0x2,%eax
 989:	01 c8                	add    %ecx,%eax
 98b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 992:	01 c8                	add    %ecx,%eax
 994:	c1 e0 03             	shl    $0x3,%eax
 997:	05 20 00 00 00       	add    $0x20,%eax
 99c:	89 50 0c             	mov    %edx,0xc(%eax)
 99f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9a2:	89 d0                	mov    %edx,%eax
 9a4:	c1 e0 02             	shl    $0x2,%eax
 9a7:	01 d0                	add    %edx,%eax
 9a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 9b0:	01 d0                	add    %edx,%eax
 9b2:	c1 e0 03             	shl    $0x3,%eax
 9b5:	05 30 00 00 00       	add    $0x30,%eax
 9ba:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
 9c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9c4:	89 d0                	mov    %edx,%eax
 9c6:	c1 e0 02             	shl    $0x2,%eax
 9c9:	01 d0                	add    %edx,%eax
 9cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 9d2:	01 d0                	add    %edx,%eax
 9d4:	c1 e0 03             	shl    $0x3,%eax
 9d7:	05 30 00 00 00       	add    $0x30,%eax
 9dc:	c7 40 08 19 00 00 00 	movl   $0x19,0x8(%eax)
 9e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9e6:	89 d0                	mov    %edx,%eax
 9e8:	c1 e0 02             	shl    $0x2,%eax
 9eb:	01 d0                	add    %edx,%eax
 9ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 9f4:	01 d0                	add    %edx,%eax
 9f6:	c1 e0 03             	shl    $0x3,%eax
 9f9:	05 10 00 00 00       	add    $0x10,%eax
 9fe:	8a 50 0d             	mov    0xd(%eax),%dl
 a01:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 a04:	89 c8                	mov    %ecx,%eax
 a06:	c1 e0 02             	shl    $0x2,%eax
 a09:	01 c8                	add    %ecx,%eax
 a0b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 a12:	01 c8                	add    %ecx,%eax
 a14:	c1 e0 03             	shl    $0x3,%eax
 a17:	05 10 00 00 00       	add    $0x10,%eax
 a1c:	88 50 0e             	mov    %dl,0xe(%eax)
 a1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a22:	89 d0                	mov    %edx,%eax
 a24:	c1 e0 02             	shl    $0x2,%eax
 a27:	01 d0                	add    %edx,%eax
 a29:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 a30:	01 d0                	add    %edx,%eax
 a32:	c1 e0 03             	shl    $0x3,%eax
 a35:	05 10 00 00 00       	add    $0x10,%eax
 a3a:	8a 50 0e             	mov    0xe(%eax),%dl
 a3d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 a40:	89 c8                	mov    %ecx,%eax
 a42:	c1 e0 02             	shl    $0x2,%eax
 a45:	01 c8                	add    %ecx,%eax
 a47:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 a4e:	01 c8                	add    %ecx,%eax
 a50:	c1 e0 03             	shl    $0x3,%eax
 a53:	05 10 00 00 00       	add    $0x10,%eax
 a58:	88 50 0c             	mov    %dl,0xc(%eax)
 a5b:	83 ec 0c             	sub    $0xc,%esp
 a5e:	ff 75 f4             	pushl  -0xc(%ebp)
 a61:	e8 c9 f5 ff ff       	call   2f <ConpClearScreen>
 a66:	83 c4 10             	add    $0x10,%esp
 a69:	ff 45 f4             	incl   -0xc(%ebp)
 a6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a70:	0f 8e 7f fd ff ff    	jle    7f5 <ConInitialize+0x23>
 a76:	83 ec 0c             	sub    $0xc,%esp
 a79:	68 f2 05 00 00       	push   $0x5f2
 a7e:	e8 fc ff ff ff       	call   a7f <ConInitialize+0x2ad>
 a83:	83 c4 10             	add    $0x10,%esp
 a86:	b8 01 00 00 00       	mov    $0x1,%eax
 a8b:	c9                   	leave  
 a8c:	c3                   	ret    

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
