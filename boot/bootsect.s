;===============================================================================
; bootsect.asm - for FAT12 disk filesystem.
;
; First written = Aug 5th, 2003.
; Writer = Yeori (alphamcu@hanmail.net, http://www.zap.pe.kr)
; Modifier = jkkim
;===============================================================================

[bits 16]
[org 00h]

%include "asm/c16.mac"
;===============================================================================
; boot records (FAT12 compatible)
;===============================================================================
	db	0ebh, 3ch	; jmp entry
	db	90h	; nop - for assembler independence
	
	db	'jkkim   '	; 8 bytes
	dw	512	; bytes per sector
	db	1	; sectors per cluster
	dw	1	; reserved sectors
	db	2	; numbers of FAT
	dw	224	; entries of root directory
	dw	2880	; total sectors
	db	0f0h
	dw	9	; sectors per FAT
	dw	18	; sectors per track
	dw	2	; heads
	dw	0	; numbers of hidden sectors
	dw	0
	dd	0
	db	0	; disk driver number (A:0, C:2)
	db	0
	db	029h
	dd	0
	db	'OS      IMG'
	db	'FAT12   '

;===============================================================================
; main
;
; * description - read carefully - *
; Only "conventional memory" area(00000h~9ffffh) is available freely. First 1k
; memory(from 000h~3ffh) is set aside for the "interrupt vector table". The area
; from 400h to 4ffh(a total of 256 bytes) is set aside for the "BIOS data" area.
; Memory from 500h to 5ffh(256 bytes) is set aside to be used for "DOS" parameters.
; Locations 700h to 9ffffh are available to "ANY OS".
;
; the area from 1000h to 11ffh(512bytes) is used for a copy of "bootsect.asm".
; the area from 1200h to 23ffh(4.5kbytes) is used for a copy of FAT2.
; the area from 2400h to 39ffh(7kbytes) is used for a copy of Dir entry table.
; the area from 10000h to 1ffffh (64kbytes) is used for the "stack" area.
; the area from 20000h to 9ffffh (512kbytes) is used for a copy of "kernel32.bin".
;===============================================================================

;%define DEFSYSSIZE 7f00h
;%define SYSSIZE DEFSYSSIZE

%define BOOTSEG	07c0h	; 7c00h

%define INITSEG	0100h	; 1000h = copy of entry block
%define INITADDR	1000h
%define INITSS	1000h	; 10000h
%define INITSP	0ffffh	; ffff = 
						; hmm... 'arbitary value bigger than 512' wrote in linux-0.11 bootsect.s

%define FATSEG	0120h	; 1200h = INITADDR + 512, copy of FAT info
						; size of FAT = 1200h = 512 * 9 = 9 sector = 4608 bytes
%define FATADDR	1200h

; FAT size is increased by disk size?

%define DIRSEG	0240h	; 2400h = copy of DIR info
%define DIRADDR	2400h

%define LDRSEG	02000h	; 20000h(128k)
%define LDRADDR	20000h	; 

entry:
	cli
	mov	ax, INITSS
	mov	ss, ax
	mov	sp, INITSP
	sti
	
	; re-load
	cld
	mov	ax, INITSEG
	mov	es, ax
	xor	di, di
	mov	ax, BOOTSEG
	mov	ds, ax
	xor	si, si
	mov	cx, 100h	; 256 * 2bytes(movsw) = 512 bytes
	repz	movsw
	
	jmp	INITSEG:main

;===============================================================================
; main procedure
;===============================================================================
main:
	mov	ax, INITSEG
	mov	ds, ax

	; init video
	mov	ax, 0600h
	mov	bh, 07h
	xor	cx, cx
	mov	dx, 1850h	; row:24, column:80
	int	10h	; reset window
	mov	ah, 02h
	xor	bh, bh
	xor	dx, dx
	int	10h	; set cursor position onto the top-left

	; loading msg
	push	msg_loading
	call	msgout
	add	sp, 2
	
	; reset disk system
	xor	ah, ah
	mov	dl, 00h	; a:
	int	13h

	; read FAT & Directory table
	mov	cx, 9+14	; sizeof FAT sectors & Directory table
	mov	bx, 0000h	; start address of buffer in FATSEG
	mov	dx, 0ah	; start address of FAT2

.read_fat_dir:	
	push	bx
	push	FATSEG
	push	dx
	call	read_sector	; read sector one by one
	add	sp, 6
	or	ax, ax
	jnz	.read_next_fat_dir	; check whether or not an error occured
	call	sys_halt

.read_next_fat_dir:
	inc	dx
	add	bx, 512
	loop	.read_fat_dir	; read next sector
	
	; find kernel32.bin file from directory table
	mov	cx, 224
	mov	bx, DIRADDR-INITADDR	; dir addr from current ds addr

.find_kernel:
	push	8
	push	bx
	push	str_kernel
	call	is_equal
	add	sp, 6
	or	ax, ax
	jnz	.kernel_found
	add	bx, 32
	loop	.find_kernel
	call	sys_halt	; no file found

.kernel_found:
	mov	dx, word [bx+1ah]	; get cluster number
				; HERE: can we control how many sectors we want to read?
	mov	bx, LDRSEG	; initial segment value
	
.read_cluster:	; using bx, dx(cluster)
	cmp	dx, 0ff8h
	jae	.load_complete
	
	push	msg_dot	; print progress
	call	msgout
	add	sp, 2

	add	dx, 01fh ; offset to real data area --> 1fh는 디스크의 제일 처음부터 cluster 데이타의 처음 시작부분까지의 섹터 수 ^^;
	push	00h
	push	bx
	push	dx
	call	read_sector
	add	sp, 6
	or	ax, ax
	jnz	.increase_ldr_addr
	call	sys_halt
	
.increase_ldr_addr:
	sub	dx, 01fh	; decrease 31bytes, what means 31bytes: first cluster data sector number from head of disk
			; cause we add before, here reset
	add	bx, 20h	; increase 512bytes
	
.get_next_cluster:
	push	bx
	push	dx
	mov	bx, 3	;
	
	mov	ax, dx	;
	clc
	rcr	ax, 1
	jc	.odd_number
	
	; even number
	mul	bx
	mov	bx, ax
	mov	ax, word [bx+200h]	; 200h = FAT's offset from curr ds(INITSEG)
	and	ax, 0fffh
	pop	dx
	pop	bx
	mov	dx, ax
	jmp	.read_cluster
	
.odd_number:
	mul	bx
	mov	bx, ax
	inc	bx
	mov	ax, word [bx+200h]
	shr	ax, 4
	pop	dx
	pop	bx
	mov	dx, ax
	jmp	.read_cluster

.load_complete:

	mov	ax, LDRSEG
	mov	ds, ax
	jmp	LDRSEG:0000h	; jump to entry

;===============================================================================
; sys_halt
;===============================================================================
proc	sys_halt
	push	msg_error
	call	msgout
	add	sp, 2
	
.infinate:
	jmp	.infinate
endproc

;===============================================================================
; is_equal
;
; type : int is_equal(int first_str, int second_str, int count);
; desc : if two strings are not euqal, return zero value
;===============================================================================
proc	is_equal
	mov	ax, 1
	pusha
	
	; init
	mov	si, word [bp+4]
	mov	di, word [bp+6]
	mov	cx, word [bp+8]
	
	; proceed
.loop:
	lodsb
	cmp	al, byte [di]
	jne	.different
	inc	di
	loop	.loop
	
	popa
	jmp	.out

.different:
	popa
	xor	ax, ax
.out:
endproc

;===============================================================================
; read_sector
;
; type : int read_sector(int sector_number, int es_value, int bx_value);
; desc : sector_number - initial number is zero not one!
;        if an error occurred, return zero value
;===============================================================================

%define SECTORS_PER_TRACK		18
%define SECTORS_OF_TWO_TRACKS	SECTORS_PER_TRACK*2

proc	read_sector
	mov	ax, 1	; no error
	pusha
	
	; init variables.
.init:
	mov	ax, word [bp+4]
	
	; get "track" number.
	mov	bl, SECTORS_OF_TWO_TRACKS
	div	bl
	mov	ch, al	; track
	shr	ax, 8

	; get "head" number.
	mov	bl, SECTORS_PER_TRACK
	div	bl
	mov	dh, al	; head
	mov	cl, ah
	inc	cl	; add 1 to sector number.

	; read sector
	mov	ax, 0201h
	mov	dl, 00h	; floppy drive number
	mov	es, word [bp+6]
	mov	bx, word [bp+8]	; es:bx
	int	13h
	
	popa
	
	jnc	.out
	xor	ax, ax	; error occurred
.out:
endproc

;===============================================================================
; msgout
;
; type : void msgout(word ptMsg);  // ptMsg is an word-size address.
;===============================================================================
proc	msgout
	pusha
	
	mov	si, WORD [bp+4]
.print:
	lodsb
	or	al, al
	jz	.out
	mov	ah, 0eh	; teletype output function
	mov	bx, 08h	; back/fore ground color
	int	10h
	jmp	.print
	
.out:
	popa
endproc

;===============================================================================
; datas used by boot procedure
;===============================================================================
msg_loading	db	'Loading', 00h
msg_dot	db	'.', 00h
msg_error	db	'Err!', 00h
str_kernel	db	'KERNEL  BIN'

times	500-($-$$)	db	00h
syssize db 00h, 00h
swap_dev db 00h, 00h
ram_size db 00h, 00h
vid_mode db 00h, 00h
root_dev db 00h, 00h

;===============================================================================
; boot signature
;===============================================================================
times	1feh-($-$$)	db	00h
	dw	0aa55h
