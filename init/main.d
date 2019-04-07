
main.o:     file format elf32-i386


Disassembly of section .text:

00000000 <fork>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 10             	sub    $0x10,%esp
   7:	b8 02 00 00 00       	mov    $0x2,%eax
   c:	89 c3                	mov    %eax,%ebx
   e:	89 d8                	mov    %ebx,%eax
  10:	cd 80                	int    $0x80
  12:	89 c3                	mov    %eax,%ebx
  14:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  17:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  1b:	78 05                	js     22 <fork+0x22>
  1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  20:	eb 0f                	jmp    31 <fork+0x31>
  22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  25:	f7 d8                	neg    %eax
  27:	a3 00 00 00 00       	mov    %eax,0x0
  2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  31:	83 c4 10             	add    $0x10,%esp
  34:	5b                   	pop    %ebx
  35:	c9                   	leave  
  36:	c3                   	ret    

00000037 <execve>:
  37:	55                   	push   %ebp
  38:	89 e5                	mov    %esp,%ebp
  3a:	56                   	push   %esi
  3b:	53                   	push   %ebx
  3c:	83 ec 10             	sub    $0x10,%esp
  3f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  42:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  45:	8b 55 10             	mov    0x10(%ebp),%edx
  48:	b8 0b 00 00 00       	mov    $0xb,%eax
  4d:	89 c6                	mov    %eax,%esi
  4f:	89 f0                	mov    %esi,%eax
  51:	cd 80                	int    $0x80
  53:	89 c6                	mov    %eax,%esi
  55:	89 75 f4             	mov    %esi,-0xc(%ebp)
  58:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  5c:	78 05                	js     63 <execve+0x2c>
  5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  61:	eb 0f                	jmp    72 <execve+0x3b>
  63:	8b 45 f4             	mov    -0xc(%ebp),%eax
  66:	f7 d8                	neg    %eax
  68:	a3 00 00 00 00       	mov    %eax,0x0
  6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  72:	83 c4 10             	add    $0x10,%esp
  75:	5b                   	pop    %ebx
  76:	5e                   	pop    %esi
  77:	c9                   	leave  
  78:	c3                   	ret    

00000079 <init>:
  79:	55                   	push   %ebp
  7a:	89 e5                	mov    %esp,%ebp
  7c:	83 ec 18             	sub    $0x18,%esp
  7f:	e8 7c ff ff ff       	call   0 <fork>
  84:	89 45 f4             	mov    %eax,-0xc(%ebp)
  87:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8b:	7e 15                	jle    a2 <init+0x29>
  8d:	90                   	nop
  8e:	83 ec 0c             	sub    $0xc,%esp
  91:	8d 45 f0             	lea    -0x10(%ebp),%eax
  94:	50                   	push   %eax
  95:	e8 fc ff ff ff       	call   96 <init+0x1d>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  a0:	75 ec                	jne    8e <init+0x15>
  a2:	e8 59 ff ff ff       	call   0 <fork>
  a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  ae:	75 1d                	jne    cd <init+0x54>
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 10 00 00 00       	push   $0x10
  b8:	68 08 00 00 00       	push   $0x8
  bd:	68 00 00 00 00       	push   $0x0
  c2:	e8 70 ff ff ff       	call   37 <execve>
  c7:	83 c4 10             	add    $0x10,%esp
  ca:	eb 01                	jmp    cd <init+0x54>
  cc:	90                   	nop
  cd:	83 ec 0c             	sub    $0xc,%esp
  d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
  d3:	50                   	push   %eax
  d4:	e8 fc ff ff ff       	call   d5 <init+0x5c>
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  df:	75 eb                	jne    cc <init+0x53>
  e1:	eb bf                	jmp    a2 <init+0x29>

000000e3 <TaskStkInit>:
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	53                   	push   %ebx
  e7:	83 ec 14             	sub    $0x14,%esp
  ea:	8b 45 14             	mov    0x14(%ebp),%eax
  ed:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  f1:	9c                   	pushf  
  f2:	58                   	pop    %eax
  f3:	89 c3                	mov    %eax,%ebx
  f5:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  f8:	8b 45 10             	mov    0x10(%ebp),%eax
  fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  fe:	8b 55 0c             	mov    0xc(%ebp),%edx
 101:	8b 45 f4             	mov    -0xc(%ebp),%eax
 104:	89 10                	mov    %edx,(%eax)
 106:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 10a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 10d:	89 c2                	mov    %eax,%edx
 10f:	80 ce 02             	or     $0x2,%dh
 112:	8b 45 f4             	mov    -0xc(%ebp),%eax
 115:	89 10                	mov    %edx,(%eax)
 117:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 11b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 11e:	c7 00 08 00 00 00    	movl   $0x8,(%eax)
 124:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 128:	8b 55 08             	mov    0x8(%ebp),%edx
 12b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 12e:	89 10                	mov    %edx,(%eax)
 130:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 134:	8b 45 f4             	mov    -0xc(%ebp),%eax
 137:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 13d:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 141:	8b 45 f4             	mov    -0xc(%ebp),%eax
 144:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 14a:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 14e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 151:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 157:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 15b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 164:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 168:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 171:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 175:	8b 45 f4             	mov    -0xc(%ebp),%eax
 178:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 17e:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 182:	8b 45 f4             	mov    -0xc(%ebp),%eax
 185:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 18b:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 18f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 192:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 198:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 19c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 1a5:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
 1a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 1b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b5:	83 c4 14             	add    $0x14,%esp
 1b8:	5b                   	pop    %ebx
 1b9:	c9                   	leave  
 1ba:	c3                   	ret    

000001bb <TaskGlobalManipulate>:
 1bb:	55                   	push   %ebp
 1bc:	89 e5                	mov    %esp,%ebp
 1be:	83 ec 0c             	sub    $0xc,%esp
 1c1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c4:	8b 55 14             	mov    0x14(%ebp),%edx
 1c7:	8b 45 1c             	mov    0x1c(%ebp),%eax
 1ca:	88 4d fc             	mov    %cl,-0x4(%ebp)
 1cd:	66 89 55 f8          	mov    %dx,-0x8(%ebp)
 1d1:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
 1d5:	9c                   	pushf  
 1d6:	fa                   	cli    
 1d7:	8b 15 00 00 00 00    	mov    0x0,%edx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	89 50 24             	mov    %edx,0x24(%eax)
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	8b 40 24             	mov    0x24(%eax),%eax
 1e9:	8b 50 20             	mov    0x20(%eax),%edx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	89 50 20             	mov    %edx,0x20(%eax)
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	a3 00 00 00 00       	mov    %eax,0x0
 1fa:	9d                   	popf   
 1fb:	b0 00                	mov    $0x0,%al
 1fd:	c9                   	leave  
 1fe:	c3                   	ret    

000001ff <TaskCreate>:
 1ff:	55                   	push   %ebp
 200:	89 e5                	mov    %esp,%ebp
 202:	83 ec 28             	sub    $0x28,%esp
 205:	8b 45 18             	mov    0x18(%ebp),%eax
 208:	88 45 e4             	mov    %al,-0x1c(%ebp)
 20b:	83 ec 08             	sub    $0x8,%esp
 20e:	ff 75 08             	pushl  0x8(%ebp)
 211:	68 08 00 00 00       	push   $0x8
 216:	e8 fc ff ff ff       	call   217 <TaskCreate+0x18>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	9c                   	pushf  
 21f:	fa                   	cli    
 220:	9d                   	popf   
 221:	6a 00                	push   $0x0
 223:	ff 75 14             	pushl  0x14(%ebp)
 226:	ff 75 10             	pushl  0x10(%ebp)
 229:	ff 75 0c             	pushl  0xc(%ebp)
 22c:	e8 fc ff ff ff       	call   22d <TaskCreate+0x2e>
 231:	83 c4 10             	add    $0x10,%esp
 234:	89 45 14             	mov    %eax,0x14(%ebp)
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	8b 55 14             	mov    0x14(%ebp),%edx
 23d:	89 10                	mov    %edx,(%eax)
 23f:	8b 45 08             	mov    0x8(%ebp),%eax
 242:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
 249:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
 24d:	83 ec 08             	sub    $0x8,%esp
 250:	6a 00                	push   $0x0
 252:	6a 00                	push   $0x0
 254:	6a 00                	push   $0x0
 256:	ff 75 14             	pushl  0x14(%ebp)
 259:	50                   	push   %eax
 25a:	ff 75 08             	pushl  0x8(%ebp)
 25d:	e8 fc ff ff ff       	call   25e <TaskCreate+0x5f>
 262:	83 c4 20             	add    $0x20,%esp
 265:	88 45 f7             	mov    %al,-0x9(%ebp)
 268:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
 26c:	75 0e                	jne    27c <TaskCreate+0x7d>
 26e:	9c                   	pushf  
 26f:	fa                   	cli    
 270:	a0 00 00 00 00       	mov    0x0,%al
 275:	40                   	inc    %eax
 276:	a2 00 00 00 00       	mov    %al,0x0
 27b:	9d                   	popf   
 27c:	c9                   	leave  
 27d:	c3                   	ret    

0000027e <random>:
 27e:	55                   	push   %ebp
 27f:	89 e5                	mov    %esp,%ebp
 281:	8b 15 04 00 00 00    	mov    0x4,%edx
 287:	89 d0                	mov    %edx,%eax
 289:	d1 e0                	shl    %eax
 28b:	01 d0                	add    %edx,%eax
 28d:	c1 e0 02             	shl    $0x2,%eax
 290:	01 d0                	add    %edx,%eax
 292:	c1 e0 08             	shl    $0x8,%eax
 295:	01 d0                	add    %edx,%eax
 297:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 29e:	01 c8                	add    %ecx,%eax
 2a0:	c1 e0 02             	shl    $0x2,%eax
 2a3:	01 d0                	add    %edx,%eax
 2a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2ac:	01 d0                	add    %edx,%eax
 2ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2b5:	01 d0                	add    %edx,%eax
 2b7:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
 2bc:	a3 04 00 00 00       	mov    %eax,0x4
 2c1:	a1 04 00 00 00       	mov    0x4,%eax
 2c6:	ba 00 00 00 00       	mov    $0x0,%edx
 2cb:	f7 75 08             	divl   0x8(%ebp)
 2ce:	89 d0                	mov    %edx,%eax
 2d0:	c9                   	leave  
 2d1:	c3                   	ret    

000002d2 <randomDispCharLoop>:
 2d2:	55                   	push   %ebp
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	83 ec 18             	sub    $0x18,%esp						; room 6
 2d8:	83 ec 08             	sub    $0x8,%esp						; room 2
 2db:	ff 75 08             	pushl  0x8(%ebp)
 2de:	68 15 00 00 00       	push   $0x15
 2e3:	e8 fc ff ff ff       	call   2e4 <randomDispCharLoop+0x12>	
 2e8:	83 c4 10             	add    $0x10,%esp
 2eb:	83 ec 0c             	sub    $0xc,%esp
 2ee:	6a 50                	push   $0x50
 2f0:	e8 fc ff ff ff       	call   2f1 <randomDispCharLoop+0x1f>
 2f5:	83 c4 10             	add    $0x10,%esp
 2f8:	88 45 f7             	mov    %al,-0x9(%ebp)
 2fb:	83 ec 0c             	sub    $0xc,%esp
 2fe:	6a 10                	push   $0x10
 300:	e8 fc ff ff ff       	call   301 <randomDispCharLoop+0x2f>
 305:	83 c4 10             	add    $0x10,%esp
 308:	88 45 f6             	mov    %al,-0xa(%ebp)
 30b:	eb de                	jmp    2eb <randomDispCharLoop+0x19>

0000030d <TaskStartDispInit>:
 30d:	55                   	push   %ebp
 30e:	89 e5                	mov    %esp,%ebp
 310:	83 ec 08             	sub    $0x8,%esp
 313:	6a 4f                	push   $0x4f
 315:	68 24 00 00 00       	push   $0x24
 31a:	6a 00                	push   $0x0
 31c:	6a 00                	push   $0x0
 31e:	e8 fc ff ff ff       	call   31f <TaskStartDispInit+0x12>
 323:	83 c4 10             	add    $0x10,%esp
 326:	6a 70                	push   $0x70
 328:	68 78 00 00 00       	push   $0x78
 32d:	6a 01                	push   $0x1
 32f:	6a 00                	push   $0x0
 331:	e8 fc ff ff ff       	call   332 <TaskStartDispInit+0x25>
 336:	83 c4 10             	add    $0x10,%esp
 339:	6a 70                	push   $0x70
 33b:	68 cc 00 00 00       	push   $0xcc
 340:	6a 02                	push   $0x2
 342:	6a 00                	push   $0x0
 344:	e8 fc ff ff ff       	call   345 <TaskStartDispInit+0x38>
 349:	83 c4 10             	add    $0x10,%esp
 34c:	6a 70                	push   $0x70
 34e:	68 20 01 00 00       	push   $0x120
 353:	6a 03                	push   $0x3
 355:	6a 00                	push   $0x0
 357:	e8 fc ff ff ff       	call   358 <TaskStartDispInit+0x4b>
 35c:	83 c4 10             	add    $0x10,%esp
 35f:	6a 70                	push   $0x70
 361:	68 cc 00 00 00       	push   $0xcc
 366:	6a 04                	push   $0x4
 368:	6a 00                	push   $0x0
 36a:	e8 fc ff ff ff       	call   36b <TaskStartDispInit+0x5e>
 36f:	83 c4 10             	add    $0x10,%esp
 372:	6a 70                	push   $0x70
 374:	68 cc 00 00 00       	push   $0xcc
 379:	6a 05                	push   $0x5
 37b:	6a 00                	push   $0x0
 37d:	e8 fc ff ff ff       	call   37e <TaskStartDispInit+0x71>
 382:	83 c4 10             	add    $0x10,%esp
 385:	6a 70                	push   $0x70
 387:	68 cc 00 00 00       	push   $0xcc
 38c:	6a 06                	push   $0x6
 38e:	6a 00                	push   $0x0
 390:	e8 fc ff ff ff       	call   391 <TaskStartDispInit+0x84>
 395:	83 c4 10             	add    $0x10,%esp
 398:	6a 70                	push   $0x70
 39a:	68 cc 00 00 00       	push   $0xcc
 39f:	6a 07                	push   $0x7
 3a1:	6a 00                	push   $0x0
 3a3:	e8 fc ff ff ff       	call   3a4 <TaskStartDispInit+0x97>
 3a8:	83 c4 10             	add    $0x10,%esp
 3ab:	6a 70                	push   $0x70
 3ad:	68 cc 00 00 00       	push   $0xcc
 3b2:	6a 08                	push   $0x8
 3b4:	6a 00                	push   $0x0
 3b6:	e8 fc ff ff ff       	call   3b7 <TaskStartDispInit+0xaa>
 3bb:	83 c4 10             	add    $0x10,%esp
 3be:	6a 70                	push   $0x70
 3c0:	68 cc 00 00 00       	push   $0xcc
 3c5:	6a 09                	push   $0x9
 3c7:	6a 00                	push   $0x0
 3c9:	e8 fc ff ff ff       	call   3ca <TaskStartDispInit+0xbd>
 3ce:	83 c4 10             	add    $0x10,%esp
 3d1:	6a 70                	push   $0x70
 3d3:	68 cc 00 00 00       	push   $0xcc
 3d8:	6a 0a                	push   $0xa
 3da:	6a 00                	push   $0x0
 3dc:	e8 fc ff ff ff       	call   3dd <TaskStartDispInit+0xd0>
 3e1:	83 c4 10             	add    $0x10,%esp
 3e4:	6a 70                	push   $0x70
 3e6:	68 cc 00 00 00       	push   $0xcc
 3eb:	6a 0b                	push   $0xb
 3ed:	6a 00                	push   $0x0
 3ef:	e8 fc ff ff ff       	call   3f0 <TaskStartDispInit+0xe3>
 3f4:	83 c4 10             	add    $0x10,%esp
 3f7:	6a 70                	push   $0x70
 3f9:	68 cc 00 00 00       	push   $0xcc
 3fe:	6a 0c                	push   $0xc
 400:	6a 00                	push   $0x0
 402:	e8 fc ff ff ff       	call   403 <TaskStartDispInit+0xf6>
 407:	83 c4 10             	add    $0x10,%esp
 40a:	6a 70                	push   $0x70
 40c:	68 cc 00 00 00       	push   $0xcc
 411:	6a 0d                	push   $0xd
 413:	6a 00                	push   $0x0
 415:	e8 fc ff ff ff       	call   416 <TaskStartDispInit+0x109>
 41a:	83 c4 10             	add    $0x10,%esp
 41d:	6a 70                	push   $0x70
 41f:	68 cc 00 00 00       	push   $0xcc
 424:	6a 0e                	push   $0xe
 426:	6a 00                	push   $0x0
 428:	e8 fc ff ff ff       	call   429 <TaskStartDispInit+0x11c>
 42d:	83 c4 10             	add    $0x10,%esp
 430:	6a 70                	push   $0x70
 432:	68 cc 00 00 00       	push   $0xcc
 437:	6a 0f                	push   $0xf
 439:	6a 00                	push   $0x0
 43b:	e8 fc ff ff ff       	call   43c <TaskStartDispInit+0x12f>
 440:	83 c4 10             	add    $0x10,%esp
 443:	6a 70                	push   $0x70
 445:	68 cc 00 00 00       	push   $0xcc
 44a:	6a 10                	push   $0x10
 44c:	6a 00                	push   $0x0
 44e:	e8 fc ff ff ff       	call   44f <TaskStartDispInit+0x142>
 453:	83 c4 10             	add    $0x10,%esp
 456:	6a 70                	push   $0x70
 458:	68 cc 00 00 00       	push   $0xcc
 45d:	6a 11                	push   $0x11
 45f:	6a 00                	push   $0x0
 461:	e8 fc ff ff ff       	call   462 <TaskStartDispInit+0x155>
 466:	83 c4 10             	add    $0x10,%esp
 469:	6a 70                	push   $0x70
 46b:	68 cc 00 00 00       	push   $0xcc
 470:	6a 12                	push   $0x12
 472:	6a 00                	push   $0x0
 474:	e8 fc ff ff ff       	call   475 <TaskStartDispInit+0x168>
 479:	83 c4 10             	add    $0x10,%esp
 47c:	6a 70                	push   $0x70
 47e:	68 cc 00 00 00       	push   $0xcc
 483:	6a 13                	push   $0x13
 485:	6a 00                	push   $0x0
 487:	e8 fc ff ff ff       	call   488 <TaskStartDispInit+0x17b>
 48c:	83 c4 10             	add    $0x10,%esp
 48f:	6a 70                	push   $0x70
 491:	68 cc 00 00 00       	push   $0xcc
 496:	6a 14                	push   $0x14
 498:	6a 00                	push   $0x0
 49a:	e8 fc ff ff ff       	call   49b <TaskStartDispInit+0x18e>
 49f:	83 c4 10             	add    $0x10,%esp
 4a2:	6a 70                	push   $0x70
 4a4:	68 cc 00 00 00       	push   $0xcc
 4a9:	6a 15                	push   $0x15
 4ab:	6a 00                	push   $0x0
 4ad:	e8 fc ff ff ff       	call   4ae <TaskStartDispInit+0x1a1>
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	6a 70                	push   $0x70
 4b7:	68 74 01 00 00       	push   $0x174
 4bc:	6a 16                	push   $0x16
 4be:	6a 00                	push   $0x0
 4c0:	e8 fc ff ff ff       	call   4c1 <TaskStartDispInit+0x1b4>
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	6a 70                	push   $0x70
 4ca:	68 c8 01 00 00       	push   $0x1c8
 4cf:	6a 17                	push   $0x17
 4d1:	6a 00                	push   $0x0
 4d3:	e8 fc ff ff ff       	call   4d4 <TaskStartDispInit+0x1c7>
 4d8:	83 c4 10             	add    $0x10,%esp
 4db:	6a 1f                	push   $0x1f
 4dd:	68 cc 00 00 00       	push   $0xcc
 4e2:	6a 18                	push   $0x18
 4e4:	6a 00                	push   $0x0
 4e6:	e8 fc ff ff ff       	call   4e7 <TaskStartDispInit+0x1da>
 4eb:	83 c4 10             	add    $0x10,%esp
 4ee:	c9                   	leave  
 4ef:	c3                   	ret    

000004f0 <idleLoop>:
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	83 ec 08             	sub    $0x8,%esp
 4f6:	83 ec 0c             	sub    $0xc,%esp
 4f9:	68 19 02 00 00       	push   $0x219
 4fe:	e8 fc ff ff ff       	call   4ff <idleLoop+0xf>
 503:	83 c4 10             	add    $0x10,%esp
 506:	a1 00 00 00 00       	mov    0x0,%eax
 50b:	40                   	inc    %eax
 50c:	a3 00 00 00 00       	mov    %eax,0x0
 511:	eb f3                	jmp    506 <idleLoop+0x16>

00000513 <schedule>:
 513:	55                   	push   %ebp
 514:	89 e5                	mov    %esp,%ebp
 516:	83 ec 18             	sub    $0x18,%esp
 519:	83 ec 0c             	sub    $0xc,%esp
 51c:	68 32 02 00 00       	push   $0x232
 521:	e8 fc ff ff ff       	call   522 <schedule+0xf>
 526:	83 c4 10             	add    $0x10,%esp
 529:	fb                   	sti    
 52a:	a1 00 00 00 00       	mov    0x0,%eax
 52f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 532:	8b 45 f4             	mov    -0xc(%ebp),%eax
 535:	8b 40 08             	mov    0x8(%eax),%eax
 538:	83 f8 01             	cmp    $0x1,%eax
 53b:	75 27                	jne    564 <schedule+0x51>
 53d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 540:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)
 547:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54a:	8b 50 18             	mov    0x18(%eax),%edx
 54d:	a1 00 00 00 00       	mov    0x0,%eax
 552:	8b 40 18             	mov    0x18(%eax),%eax
 555:	83 ec 08             	sub    $0x8,%esp
 558:	52                   	push   %edx
 559:	50                   	push   %eax
 55a:	e8 fc ff ff ff       	call   55b <schedule+0x48>
 55f:	83 c4 10             	add    $0x10,%esp
 562:	eb 01                	jmp    565 <schedule+0x52>
 564:	90                   	nop
 565:	8b 45 f4             	mov    -0xc(%ebp),%eax
 568:	8b 40 24             	mov    0x24(%eax),%eax
 56b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 56e:	eb c2                	jmp    532 <schedule+0x1f>

00000570 <OSStart>:
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	83 ec 08             	sub    $0x8,%esp
 576:	a1 00 00 00 00       	mov    0x0,%eax
 57b:	a3 00 00 00 00       	mov    %eax,0x0
 580:	fb                   	sti    
 581:	e8 fc ff ff ff       	call   582 <OSStart+0x12>
 586:	c9                   	leave  
 587:	c3                   	ret    

00000588 <StartKernel>:
 588:	55                   	push   %ebp
 589:	89 e5                	mov    %esp,%ebp
 58b:	53                   	push   %ebx
 58c:	83 ec 14             	sub    $0x14,%esp
 58f:	e8 fc ff ff ff       	call   590 <StartKernel+0x8>
 594:	85 c0                	test   %eax,%eax
 596:	74 20                	je     5b8 <StartKernel+0x30>
 598:	83 ec 0c             	sub    $0xc,%esp
 59b:	68 48 02 00 00       	push   $0x248
 5a0:	e8 fc ff ff ff       	call   5a1 <StartKernel+0x19>
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	83 ec 0c             	sub    $0xc,%esp
 5ab:	68 50 02 00 00       	push   $0x250
 5b0:	e8 fc ff ff ff       	call   5b1 <StartKernel+0x29>
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	e8 fc ff ff ff       	call   5b9 <StartKernel+0x31>
 5bd:	85 c0                	test   %eax,%eax
 5bf:	74 10                	je     5d1 <StartKernel+0x49>
 5c1:	83 ec 0c             	sub    $0xc,%esp
 5c4:	68 78 02 00 00       	push   $0x278
 5c9:	e8 fc ff ff ff       	call   5ca <StartKernel+0x42>
 5ce:	83 c4 10             	add    $0x10,%esp
 5d1:	e8 fc ff ff ff       	call   5d2 <StartKernel+0x4a>
 5d6:	85 c0                	test   %eax,%eax
 5d8:	74 10                	je     5ea <StartKernel+0x62>
 5da:	83 ec 0c             	sub    $0xc,%esp
 5dd:	68 98 02 00 00       	push   $0x298
 5e2:	e8 fc ff ff ff       	call   5e3 <StartKernel+0x5b>
 5e7:	83 c4 10             	add    $0x10,%esp
 5ea:	e8 fc ff ff ff       	call   5eb <StartKernel+0x63>
 5ef:	85 c0                	test   %eax,%eax
 5f1:	74 10                	je     603 <StartKernel+0x7b>
 5f3:	83 ec 0c             	sub    $0xc,%esp
 5f6:	68 bc 02 00 00       	push   $0x2bc
 5fb:	e8 fc ff ff ff       	call   5fc <StartKernel+0x74>
 600:	83 c4 10             	add    $0x10,%esp
 603:	83 ec 0c             	sub    $0xc,%esp
 606:	6a 64                	push   $0x64
 608:	e8 fc ff ff ff       	call   609 <StartKernel+0x81>
 60d:	83 c4 10             	add    $0x10,%esp
 610:	85 c0                	test   %eax,%eax
 612:	74 10                	je     624 <StartKernel+0x9c>
 614:	83 ec 0c             	sub    $0xc,%esp
 617:	68 e0 02 00 00       	push   $0x2e0
 61c:	e8 fc ff ff ff       	call   61d <StartKernel+0x95>
 621:	83 c4 10             	add    $0x10,%esp
 624:	83 ec 08             	sub    $0x8,%esp
 627:	68 00 08 00 00       	push   $0x800
 62c:	68 00 00 00 00       	push   $0x0
 631:	e8 fc ff ff ff       	call   632 <StartKernel+0xaa>
 636:	83 c4 10             	add    $0x10,%esp
 639:	83 ec 0c             	sub    $0xc,%esp
 63c:	68 08 03 00 00       	push   $0x308
 641:	e8 fc ff ff ff       	call   642 <StartKernel+0xba>
 646:	83 c4 10             	add    $0x10,%esp
 649:	9c                   	pushf  
 64a:	fa                   	cli    
 64b:	9d                   	popf   
 64c:	a1 00 00 00 00       	mov    0x0,%eax
 651:	83 ec 0c             	sub    $0xc,%esp
 654:	6a 00                	push   $0x0
 656:	68 5c 04 00 00       	push   $0x45c
 65b:	50                   	push   %eax
 65c:	68 00 00 00 00       	push   $0x0
 661:	68 20 00 00 00       	push   $0x20
 666:	e8 fc ff ff ff       	call   667 <StartKernel+0xdf>
 66b:	83 c4 20             	add    $0x20,%esp
 66e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 675:	eb 7a                	jmp    6f1 <StartKernel+0x169>
 677:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67a:	83 c0 30             	add    $0x30,%eax
 67d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 680:	81 c2 60 04 00 00    	add    $0x460,%edx
 686:	88 02                	mov    %al,(%edx)
 688:	8b 45 f4             	mov    -0xc(%ebp),%eax
 68b:	05 60 04 00 00       	add    $0x460,%eax
 690:	83 ec 04             	sub    $0x4,%esp
 693:	50                   	push   %eax
 694:	ff 75 f4             	pushl  -0xc(%ebp)
 697:	68 2d 03 00 00       	push   $0x32d
 69c:	e8 fc ff ff ff       	call   69d <StartKernel+0x115>
 6a1:	83 c4 10             	add    $0x10,%esp
 6a4:	b8 80 04 00 00       	mov    $0x480,%eax
 6a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6ac:	c1 e2 0a             	shl    $0xa,%edx
 6af:	81 c2 fc 03 00 00    	add    $0x3fc,%edx
 6b5:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
 6b8:	ba 60 04 00 00       	mov    $0x460,%edx
 6bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
 6c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 6c6:	89 d0                	mov    %edx,%eax
 6c8:	c1 e0 02             	shl    $0x2,%eax
 6cb:	01 d0                	add    %edx,%eax
 6cd:	d1 e0                	shl    %eax
 6cf:	01 d0                	add    %edx,%eax
 6d1:	c1 e0 02             	shl    $0x2,%eax
 6d4:	05 80 0c 00 00       	add    $0xc80,%eax
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	6a 00                	push   $0x0
 6de:	53                   	push   %ebx
 6df:	51                   	push   %ecx
 6e0:	68 00 00 00 00       	push   $0x0
 6e5:	50                   	push   %eax
 6e6:	e8 fc ff ff ff       	call   6e7 <StartKernel+0x15f>
 6eb:	83 c4 20             	add    $0x20,%esp
 6ee:	ff 45 f4             	incl   -0xc(%ebp)
 6f1:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
 6f5:	7e 80                	jle    677 <StartKernel+0xef>
 6f7:	9c                   	pushf  
 6f8:	fa                   	cli    
 6f9:	c7 05 00 00 00 00 20 	movl   $0x20,0x0
 700:	00 00 00 
 703:	9d                   	popf   
 704:	e8 fc ff ff ff       	call   705 <StartKernel+0x17d>
 709:	83 ec 0c             	sub    $0xc,%esp
 70c:	68 44 03 00 00       	push   $0x344
 711:	e8 fc ff ff ff       	call   712 <StartKernel+0x18a>
 716:	83 c4 10             	add    $0x10,%esp
 719:	eb fe                	jmp    719 <StartKernel+0x191>

Disassembly of section .data:

00000000 <idleTaskName.1034>:
   0:	7b 03                	jnp    5 <seed.986+0x1>
	...

00000004 <seed.986>:
   4:	01 00                	add    %eax,(%eax)
	...

00000008 <argv.938>:
   8:	84 03                	test   %al,(%ebx)
   a:	00 00                	add    %al,(%eax)
   c:	00 00                	add    %al,(%eax)
	...

00000010 <envp.939>:
  10:	8d 03                	lea    (%ebx),%eax
  12:	00 00                	add    %al,(%eax)
  14:	00 00                	add    %al,(%eax)
	...

Disassembly of section .bss:

00000000 <TaskCurrent>:
   0:	00 00                	add    %al,(%eax)
	...

00000004 <TaskNext>:
   4:	00 00                	add    %al,(%eax)
	...

00000008 <TaskListHeadPtr>:
   8:	00 00                	add    %al,(%eax)
	...

0000000c <TaskNum>:
	...

00000020 <idleTask.1032>:
	...

00000060 <idleTaskStack.1033>:
	...

00000460 <TaskData.1037>:
	...

00000480 <TaskStack.1036>:
	...

00000c80 <Task.1035>:
	...

00000cd8 <memory_end.1029>:
 cd8:	00 00                	add    %al,(%eax)
	...

00000cdc <memory_start.1028>:
 cdc:	00 00                	add    %al,(%eax)
	...

Disassembly of section .rodata:

00000000 <.rodata>:
   0:	2f                   	das    
   1:	62 69 6e             	bound  %ebp,0x6e(%ecx)
   4:	2f                   	das    
   5:	73 68                	jae    6f <.rodata+0x6f>
   7:	00 70 74             	add    %dh,0x74(%eax)
   a:	73 20                	jae    2c <.rodata+0x2c>
   c:	3d 20 25 30 38       	cmp    $0x38302520,%eax
  11:	78 0d                	js     20 <.rodata+0x20>
  13:	0a 00                	or     (%eax),%al
  15:	70 64                	jo     7b <.rodata+0x7b>
  17:	61                   	popa   
  18:	74 61                	je     7b <.rodata+0x7b>
  1a:	20 3d 20 25 30 38    	and    %bh,0x38302520
  20:	78 0d                	js     2f <.rodata+0x2f>
  22:	0a 00                	or     (%eax),%al
  24:	20 20                	and    %ah,(%eax)
  26:	20 20                	and    %ah,(%eax)
  28:	20 20                	and    %ah,(%eax)
  2a:	20 20                	and    %ah,(%eax)
  2c:	20 20                	and    %ah,(%eax)
  2e:	20 20                	and    %ah,(%eax)
  30:	20 20                	and    %ah,(%eax)
  32:	20 20                	and    %ah,(%eax)
  34:	20 20                	and    %ah,(%eax)
  36:	20 20                	and    %ah,(%eax)
  38:	20 20                	and    %ah,(%eax)
  3a:	20 20                	and    %ah,(%eax)
  3c:	20 20                	and    %ah,(%eax)
  3e:	20 20                	and    %ah,(%eax)
  40:	4c                   	dec    %esp
  41:	69 6e 75 73 2c 20 46 	imul   $0x46202c73,0x75(%esi),%ebp
  48:	6f                   	outsl  %ds:(%esi),(%dx)
  49:	72 20                	jb     6b <.rodata+0x6b>
  4b:	52                   	push   %edx
  4c:	65                   	gs
  4d:	61                   	popa   
  4e:	6c                   	insb   (%dx),%es:(%edi)
  4f:	2d 54 69 6d 65       	sub    $0x656d6954,%eax
  54:	20 4b 65             	and    %cl,0x65(%ebx)
  57:	72 6e                	jb     c7 <.rodata+0xc7>
  59:	65                   	gs
  5a:	6c                   	insb   (%dx),%es:(%edi)
  5b:	20 20                	and    %ah,(%eax)
  5d:	20 20                	and    %ah,(%eax)
  5f:	20 20                	and    %ah,(%eax)
  61:	20 20                	and    %ah,(%eax)
  63:	20 20                	and    %ah,(%eax)
  65:	20 20                	and    %ah,(%eax)
  67:	20 20                	and    %ah,(%eax)
  69:	20 20                	and    %ah,(%eax)
  6b:	20 20                	and    %ah,(%eax)
  6d:	20 20                	and    %ah,(%eax)
  6f:	20 20                	and    %ah,(%eax)
  71:	20 20                	and    %ah,(%eax)
  73:	20 00                	and    %al,(%eax)
  75:	00 00                	add    %al,(%eax)
  77:	00 20                	add    %ah,(%eax)
  79:	20 20                	and    %ah,(%eax)
  7b:	20 20                	and    %ah,(%eax)
  7d:	20 20                	and    %ah,(%eax)
  7f:	20 20                	and    %ah,(%eax)
  81:	20 20                	and    %ah,(%eax)
  83:	20 20                	and    %ah,(%eax)
  85:	20 20                	and    %ah,(%eax)
  87:	20 20                	and    %ah,(%eax)
  89:	20 20                	and    %ah,(%eax)
  8b:	20 20                	and    %ah,(%eax)
  8d:	20 20                	and    %ah,(%eax)
  8f:	20 20                	and    %ah,(%eax)
  91:	20 20                	and    %ah,(%eax)
  93:	20 20                	and    %ah,(%eax)
  95:	20 20                	and    %ah,(%eax)
  97:	20 20                	and    %ah,(%eax)
  99:	20 4a 69             	and    %cl,0x69(%edx)
  9c:	6e                   	outsb  %ds:(%esi),(%dx)
  9d:	6b 79 75 2e          	imul   $0x2e,0x75(%ecx),%edi
  a1:	20 4b 69             	and    %cl,0x69(%ebx)
  a4:	6d                   	insl   (%dx),%es:(%edi)
  a5:	20 20                	and    %ah,(%eax)
  a7:	20 20                	and    %ah,(%eax)
  a9:	20 20                	and    %ah,(%eax)
  ab:	20 20                	and    %ah,(%eax)
  ad:	20 20                	and    %ah,(%eax)
  af:	20 20                	and    %ah,(%eax)
  b1:	20 20                	and    %ah,(%eax)
  b3:	20 20                	and    %ah,(%eax)
  b5:	20 20                	and    %ah,(%eax)
  b7:	20 20                	and    %ah,(%eax)
  b9:	20 20                	and    %ah,(%eax)
  bb:	20 20                	and    %ah,(%eax)
  bd:	20 20                	and    %ah,(%eax)
  bf:	20 20                	and    %ah,(%eax)
  c1:	20 20                	and    %ah,(%eax)
  c3:	20 20                	and    %ah,(%eax)
  c5:	20 20                	and    %ah,(%eax)
  c7:	20 00                	and    %al,(%eax)
  c9:	00 00                	add    %al,(%eax)
  cb:	00 20                	add    %ah,(%eax)
  cd:	20 20                	and    %ah,(%eax)
  cf:	20 20                	and    %ah,(%eax)
  d1:	20 20                	and    %ah,(%eax)
  d3:	20 20                	and    %ah,(%eax)
  d5:	20 20                	and    %ah,(%eax)
  d7:	20 20                	and    %ah,(%eax)
  d9:	20 20                	and    %ah,(%eax)
  db:	20 20                	and    %ah,(%eax)
  dd:	20 20                	and    %ah,(%eax)
  df:	20 20                	and    %ah,(%eax)
  e1:	20 20                	and    %ah,(%eax)
  e3:	20 20                	and    %ah,(%eax)
  e5:	20 20                	and    %ah,(%eax)
  e7:	20 20                	and    %ah,(%eax)
  e9:	20 20                	and    %ah,(%eax)
  eb:	20 20                	and    %ah,(%eax)
  ed:	20 20                	and    %ah,(%eax)
  ef:	20 20                	and    %ah,(%eax)
  f1:	20 20                	and    %ah,(%eax)
  f3:	20 20                	and    %ah,(%eax)
  f5:	20 20                	and    %ah,(%eax)
  f7:	20 20                	and    %ah,(%eax)
  f9:	20 20                	and    %ah,(%eax)
  fb:	20 20                	and    %ah,(%eax)
  fd:	20 20                	and    %ah,(%eax)
  ff:	20 20                	and    %ah,(%eax)
 101:	20 20                	and    %ah,(%eax)
 103:	20 20                	and    %ah,(%eax)
 105:	20 20                	and    %ah,(%eax)
 107:	20 20                	and    %ah,(%eax)
 109:	20 20                	and    %ah,(%eax)
 10b:	20 20                	and    %ah,(%eax)
 10d:	20 20                	and    %ah,(%eax)
 10f:	20 20                	and    %ah,(%eax)
 111:	20 20                	and    %ah,(%eax)
 113:	20 20                	and    %ah,(%eax)
 115:	20 20                	and    %ah,(%eax)
 117:	20 20                	and    %ah,(%eax)
 119:	20 20                	and    %ah,(%eax)
 11b:	20 00                	and    %al,(%eax)
 11d:	00 00                	add    %al,(%eax)
 11f:	00 20                	add    %ah,(%eax)
 121:	20 20                	and    %ah,(%eax)
 123:	20 20                	and    %ah,(%eax)
 125:	20 20                	and    %ah,(%eax)
 127:	20 20                	and    %ah,(%eax)
 129:	20 20                	and    %ah,(%eax)
 12b:	20 20                	and    %ah,(%eax)
 12d:	20 20                	and    %ah,(%eax)
 12f:	20 20                	and    %ah,(%eax)
 131:	20 20                	and    %ah,(%eax)
 133:	20 20                	and    %ah,(%eax)
 135:	20 20                	and    %ah,(%eax)
 137:	20 20                	and    %ah,(%eax)
 139:	20 20                	and    %ah,(%eax)
 13b:	20 20                	and    %ah,(%eax)
 13d:	20 20                	and    %ah,(%eax)
 13f:	20 20                	and    %ah,(%eax)
 141:	20 20                	and    %ah,(%eax)
 143:	20 45 58             	and    %al,0x58(%ebp)
 146:	41                   	inc    %ecx
 147:	4d                   	dec    %ebp
 148:	50                   	push   %eax
 149:	4c                   	dec    %esp
 14a:	45                   	inc    %ebp
 14b:	20 20                	and    %ah,(%eax)
 14d:	20 20                	and    %ah,(%eax)
 14f:	20 20                	and    %ah,(%eax)
 151:	20 20                	and    %ah,(%eax)
 153:	20 20                	and    %ah,(%eax)
 155:	20 20                	and    %ah,(%eax)
 157:	20 20                	and    %ah,(%eax)
 159:	20 20                	and    %ah,(%eax)
 15b:	20 20                	and    %ah,(%eax)
 15d:	20 20                	and    %ah,(%eax)
 15f:	20 20                	and    %ah,(%eax)
 161:	20 20                	and    %ah,(%eax)
 163:	20 20                	and    %ah,(%eax)
 165:	20 20                	and    %ah,(%eax)
 167:	20 20                	and    %ah,(%eax)
 169:	20 20                	and    %ah,(%eax)
 16b:	20 20                	and    %ah,(%eax)
 16d:	20 20                	and    %ah,(%eax)
 16f:	20 00                	and    %al,(%eax)
 171:	00 00                	add    %al,(%eax)
 173:	00 23                	add    %ah,(%ebx)
 175:	54                   	push   %esp
 176:	61                   	popa   
 177:	73 6b                	jae    1e4 <.rodata+0x1e4>
 179:	73 20                	jae    19b <.rodata+0x19b>
 17b:	20 20                	and    %ah,(%eax)
 17d:	20 20                	and    %ah,(%eax)
 17f:	20 20                	and    %ah,(%eax)
 181:	20 20                	and    %ah,(%eax)
 183:	20 3a                	and    %bh,(%edx)
 185:	20 20                	and    %ah,(%eax)
 187:	20 20                	and    %ah,(%eax)
 189:	20 20                	and    %ah,(%eax)
 18b:	20 20                	and    %ah,(%eax)
 18d:	43                   	inc    %ebx
 18e:	50                   	push   %eax
 18f:	55                   	push   %ebp
 190:	20 55 73             	and    %dl,0x73(%ebp)
 193:	61                   	popa   
 194:	67 65 3a 20          	cmp    %gs:(%bx,%si),%ah
 198:	20 20                	and    %ah,(%eax)
 19a:	20 20                	and    %ah,(%eax)
 19c:	25 20 20 20 20       	and    $0x20202020,%eax
 1a1:	20 20                	and    %ah,(%eax)
 1a3:	20 20                	and    %ah,(%eax)
 1a5:	20 20                	and    %ah,(%eax)
 1a7:	20 20                	and    %ah,(%eax)
 1a9:	20 20                	and    %ah,(%eax)
 1ab:	20 20                	and    %ah,(%eax)
 1ad:	20 20                	and    %ah,(%eax)
 1af:	20 20                	and    %ah,(%eax)
 1b1:	20 20                	and    %ah,(%eax)
 1b3:	20 20                	and    %ah,(%eax)
 1b5:	20 20                	and    %ah,(%eax)
 1b7:	20 20                	and    %ah,(%eax)
 1b9:	20 20                	and    %ah,(%eax)
 1bb:	20 20                	and    %ah,(%eax)
 1bd:	20 20                	and    %ah,(%eax)
 1bf:	20 20                	and    %ah,(%eax)
 1c1:	20 20                	and    %ah,(%eax)
 1c3:	20 00                	and    %al,(%eax)
 1c5:	00 00                	add    %al,(%eax)
 1c7:	00 23                	add    %ah,(%ebx)
 1c9:	54                   	push   %esp
 1ca:	61                   	popa   
 1cb:	73 6b                	jae    238 <.rodata+0x238>
 1cd:	20 73 77             	and    %dh,0x77(%ebx)
 1d0:	69 74 63 68 2f 73 65 	imul   $0x6365732f,0x68(%ebx,%eiz,2),%esi
 1d7:	63 
 1d8:	3a 20                	cmp    (%eax),%ah
 1da:	20 20                	and    %ah,(%eax)
 1dc:	20 20                	and    %ah,(%eax)
 1de:	20 20                	and    %ah,(%eax)
 1e0:	20 20                	and    %ah,(%eax)
 1e2:	20 20                	and    %ah,(%eax)
 1e4:	20 20                	and    %ah,(%eax)
 1e6:	20 20                	and    %ah,(%eax)
 1e8:	20 20                	and    %ah,(%eax)
 1ea:	20 20                	and    %ah,(%eax)
 1ec:	20 20                	and    %ah,(%eax)
 1ee:	20 20                	and    %ah,(%eax)
 1f0:	20 20                	and    %ah,(%eax)
 1f2:	20 20                	and    %ah,(%eax)
 1f4:	20 20                	and    %ah,(%eax)
 1f6:	20 20                	and    %ah,(%eax)
 1f8:	20 20                	and    %ah,(%eax)
 1fa:	20 20                	and    %ah,(%eax)
 1fc:	20 20                	and    %ah,(%eax)
 1fe:	20 20                	and    %ah,(%eax)
 200:	20 20                	and    %ah,(%eax)
 202:	20 20                	and    %ah,(%eax)
 204:	20 20                	and    %ah,(%eax)
 206:	20 20                	and    %ah,(%eax)
 208:	20 20                	and    %ah,(%eax)
 20a:	20 20                	and    %ah,(%eax)
 20c:	20 20                	and    %ah,(%eax)
 20e:	20 20                	and    %ah,(%eax)
 210:	20 20                	and    %ah,(%eax)
 212:	20 20                	and    %ah,(%eax)
 214:	20 20                	and    %ah,(%eax)
 216:	20 20                	and    %ah,(%eax)
 218:	00 45 6e             	add    %al,0x6e(%ebp)
 21b:	74 65                	je     282 <.rodata+0x282>
 21d:	72 69                	jb     288 <.rodata+0x288>
 21f:	6e                   	outsb  %ds:(%esi),(%dx)
 220:	67 20 69 64          	and    %ch,0x64(%bx,%di)
 224:	6c                   	insb   (%dx),%es:(%edi)
 225:	65                   	gs
 226:	4c                   	dec    %esp
 227:	6f                   	outsl  %ds:(%esi),(%dx)
 228:	6f                   	outsl  %ds:(%esi),(%dx)
 229:	70 28                	jo     253 <.rodata+0x253>
 22b:	29 2e                	sub    %ebp,(%esi)
 22d:	2e                   	cs
 22e:	2e                   	cs
 22f:	0d 0a 00 45 6e       	or     $0x6e45000a,%eax
 234:	74 65                	je     29b <.rodata+0x29b>
 236:	72 69                	jb     2a1 <.rodata+0x2a1>
 238:	6e                   	outsb  %ds:(%esi),(%dx)
 239:	67 20 73 63          	and    %dh,0x63(%bp,%di)
 23d:	68 65 64 75 6c       	push   $0x6c756465
 242:	65 28 29             	sub    %ch,%gs:(%ecx)
 245:	0d 0a 00 0d 0a       	or     $0xa0d000a,%eax
 24a:	0d 0a 00 00 00       	or     $0xa,%eax
 24f:	00 43 6f             	add    %al,0x6f(%ebx)
 252:	6e                   	outsb  %ds:(%esi),(%dx)
 253:	73 6f                	jae    2c4 <.rodata+0x2c4>
 255:	6c                   	insb   (%dx),%es:(%edi)
 256:	65 20 49 6e          	and    %cl,%gs:0x6e(%ecx)
 25a:	69 74 69 61 6c 69 7a 	imul   $0x657a696c,0x61(%ecx,%ebp,2),%esi
 261:	65 
 262:	20 53 75             	and    %dl,0x75(%ebx)
 265:	63 63 65             	arpl   %sp,0x65(%ebx)
 268:	73 73                	jae    2dd <.rodata+0x2dd>
 26a:	66                   	data16
 26b:	75 6c                	jne    2d9 <.rodata+0x2d9>
 26d:	6c                   	insb   (%dx),%es:(%edi)
 26e:	79 21                	jns    291 <.rodata+0x291>
 270:	21 21                	and    %esp,(%ecx)
 272:	0d 0a 00 00 00       	or     $0xa,%eax
 277:	00 45 6e             	add    %al,0x6e(%ebp)
 27a:	61                   	popa   
 27b:	62 6c 69 6e          	bound  %ebp,0x6e(%ecx,%ebp,2)
 27f:	67 20 41 32          	and    %al,0x32(%bx,%di)
 283:	30 20                	xor    %ah,(%eax)
 285:	73 75                	jae    2fc <.rodata+0x2fc>
 287:	63 63 65             	arpl   %sp,0x65(%ebx)
 28a:	73 73                	jae    2ff <.rodata+0x2ff>
 28c:	66                   	data16
 28d:	75 6c                	jne    2fb <.rodata+0x2fb>
 28f:	6c                   	insb   (%dx),%es:(%edi)
 290:	79 21                	jns    2b3 <.rodata+0x2b3>
 292:	21 21                	and    %esp,(%ecx)
 294:	0d 0a 00 00 49       	or     $0x4900000a,%eax
 299:	6e                   	outsb  %ds:(%esi),(%dx)
 29a:	69 74 69 61 6c 69 7a 	imul   $0x697a696c,0x61(%ecx,%ebp,2),%esi
 2a1:	69 
 2a2:	6e                   	outsb  %ds:(%esi),(%dx)
 2a3:	67 20 50 49          	and    %dl,0x49(%bx,%si)
 2a7:	43                   	inc    %ebx
 2a8:	20 73 75             	and    %dh,0x75(%ebx)
 2ab:	63 63 65             	arpl   %sp,0x65(%ebx)
 2ae:	73 73                	jae    323 <.rodata+0x323>
 2b0:	66                   	data16
 2b1:	75 6c                	jne    31f <.rodata+0x31f>
 2b3:	6c                   	insb   (%dx),%es:(%edi)
 2b4:	79 21                	jns    2d7 <.rodata+0x2d7>
 2b6:	21 21                	and    %esp,(%ecx)
 2b8:	0d 0a 00 00 49       	or     $0x4900000a,%eax
 2bd:	6e                   	outsb  %ds:(%esi),(%dx)
 2be:	69 74 69 61 6c 69 7a 	imul   $0x697a696c,0x61(%ecx,%ebp,2),%esi
 2c5:	69 
 2c6:	6e                   	outsb  %ds:(%esi),(%dx)
 2c7:	67 20 54 72          	and    %dl,0x72(%si)
 2cb:	61                   	popa   
 2cc:	70 20                	jo     2ee <.rodata+0x2ee>
 2ce:	73 75                	jae    345 <.rodata+0x345>
 2d0:	63 63 65             	arpl   %sp,0x65(%ebx)
 2d3:	73 73                	jae    348 <.rodata+0x348>
 2d5:	66                   	data16
 2d6:	75 6c                	jne    344 <.rodata+0x344>
 2d8:	6c                   	insb   (%dx),%es:(%edi)
 2d9:	79 21                	jns    2fc <.rodata+0x2fc>
 2db:	21 21                	and    %esp,(%ecx)
 2dd:	0d 0a 00 49 6e       	or     $0x6e49000a,%eax
 2e2:	69 74 69 61 6c 69 7a 	imul   $0x697a696c,0x61(%ecx,%ebp,2),%esi
 2e9:	69 
 2ea:	6e                   	outsb  %ds:(%esi),(%dx)
 2eb:	67 20 54 69          	and    %dl,0x69(%si)
 2ef:	6d                   	insl   (%dx),%es:(%edi)
 2f0:	65                   	gs
 2f1:	72 20                	jb     313 <.rodata+0x313>
 2f3:	73 75                	jae    36a <.rodata+0x36a>
 2f5:	63 63 65             	arpl   %sp,0x65(%ebx)
 2f8:	73 73                	jae    36d <.rodata+0x36d>
 2fa:	66                   	data16
 2fb:	75 6c                	jne    369 <.rodata+0x369>
 2fd:	6c                   	insb   (%dx),%es:(%edi)
 2fe:	79 21                	jns    321 <.rodata+0x321>
 300:	21 21                	and    %esp,(%ecx)
 302:	0d 0a 00 00 00       	or     $0xa,%eax
 307:	00 73 74             	add    %dh,0x74(%ebx)
 30a:	65                   	gs
 30b:	70 20                	jo     32d <.rodata+0x32d>
 30d:	32 2e                	xor    (%esi),%ch
 30f:	20 70 72             	and    %dh,0x72(%eax)
 312:	65                   	gs
 313:	70 61                	jo     376 <.rodata+0x376>
 315:	72 65                	jb     37c <.rodata+0x37c>
 317:	20 69 6e             	and    %ch,0x6e(%ecx)
 31a:	69 74 20 61 6e 64 20 	imul   $0x7320646e,0x61(%eax,%eiz,1),%esi
 321:	73 
 322:	6f                   	outsl  %ds:(%esi),(%dx)
 323:	6d                   	insl   (%dx),%es:(%edi)
 324:	65 20 74 61 73       	and    %dh,%gs:0x73(%ecx,%eiz,2)
 329:	6b 0d 0a 00 26 54 61 	imul   $0x61,0x5426000a,%ecx
 330:	73 6b                	jae    39d <TaskStartDispInit+0x90>
 332:	44                   	inc    %esp
 333:	61                   	popa   
 334:	74 61                	je     397 <.rodata+0x397>
 336:	5b                   	pop    %ebx
 337:	25 64 5d 20 3d       	and    $0x3d205d64,%eax
 33c:	20 25 30 38 78 0d    	and    %ah,0xd783830
 342:	0a 00                	or     (%eax),%al
 344:	6c                   	insb   (%dx),%es:(%edi)
 345:	6f                   	outsl  %ds:(%esi),(%dx)
 346:	6e                   	outsb  %ds:(%esi),(%dx)
 347:	67 20 74 69          	and    %dh,0x69(%si)
 34b:	6d                   	insl   (%dx),%es:(%edi)
 34c:	65 20 6c 61 74       	and    %ch,%gs:0x74(%ecx,%eiz,2)
 351:	65                   	gs
 352:	72 2c                	jb     380 <.rodata+0x380>
 354:	20 74 68 69          	and    %dh,0x69(%eax,%ebp,2)
 358:	73 20                	jae    37a <.rodata+0x37a>
 35a:	63 6f 64             	arpl   %bp,0x64(%edi)
 35d:	65 20 77 69          	and    %dh,%gs:0x69(%edi)
 361:	6c                   	insb   (%dx),%es:(%edi)
 362:	6c                   	insb   (%dx),%es:(%edi)
 363:	20 6e 6f             	and    %ch,0x6f(%esi)
 366:	74 20                	je     388 <.rodata+0x388>
 368:	62 65 20             	bound  %esp,0x20(%ebp)
 36b:	65                   	gs
 36c:	78 65                	js     3d3 <TaskStartDispInit+0xc6>
 36e:	63 75 74             	arpl   %si,0x74(%ebp)
 371:	65 64 21 20          	gs and %esp,%fs:%gs:(%eax)
 375:	3a 29                	cmp    (%ecx),%ch
 377:	20 0d 0a 00 69 64    	and    %cl,0x6469000a
 37d:	6c                   	insb   (%dx),%es:(%edi)
 37e:	65                   	gs
 37f:	54                   	push   %esp
 380:	61                   	popa   
 381:	73 6b                	jae    3ee <TaskStartDispInit+0xe1>
 383:	00 2d 2f 62 69 6e    	add    %ch,0x6e69622f
 389:	2f                   	das    
 38a:	73 68                	jae    3f4 <TaskStartDispInit+0xe7>
 38c:	00 48 4f             	add    %cl,0x4f(%eax)
 38f:	4d                   	dec    %ebp
 390:	45                   	inc    %ebp
 391:	3d 2f 75 73 72       	cmp    $0x7273752f,%eax
 396:	2f                   	das    
 397:	72 6f                	jb     408 <TaskStartDispInit+0xfb>
 399:	6f                   	outsl  %ds:(%esi),(%dx)
 39a:	74 00                	je     39c <TaskStartDispInit+0x8f>

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
