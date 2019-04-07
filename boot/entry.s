[bits 16]
[org 20000h]

;===============================================================================
; DECLARE MACROs
;===============================================================================
%macro LGDT16 1				; load from ds segment area
		db	3eh
		db	67h
		db	0fh
		db	01h
		db	15h
		dd	%1 ; addr
%endmacro

%macro FJMP16 2
		db	66h
		db	0eah
		dd	%2 ; offset
		dw	%1 ; selector
%endmacro

;===============================================================================
; DECLARE DEFs
;===============================================================================
%define LDRSEG	02000h
%define LDRADDR	20000h

;===============================================================================
; EntryPoint called by bootsect.
;===============================================================================
EntryPoint16:
		LGDT16	_m_GdtrDesc-20000h
		cli
		mov		eax, cr0
		or		ax, 1
		mov		cr0, eax
		jmp		$+2
		nop
		nop
		
		FJMP16	08h, EntryPoint32

[bits 32]
;===============================================================================
; 32bit routine
;===============================================================================
EntryPoint32:
		mov		ax, 10h
 		mov		ds, ax
 		mov		es, ax
 		mov		fs, ax
 		mov		gs, ax
 		mov		ss, ax
 		mov		esp, 1ffffh		; top of stack

		jmp		dword 08h:20200h ; call	 startup_32

infinate:
		hlt
		jmp	infinate
		
;===============================================================================
; GDT table descriptor
;===============================================================================

_m_GdtrDesc:
		dw		GDT_SIZE-1
		dd		_m_GdtTable

;===============================================================================
; GDT table
;===============================================================================

_m_GdtTable:
;----------------------------------
; GDT TABLE INDEX #0
; INDEX      : NULL SELECTOR
;----------------------------------
nullDescriptor  equ 0x00
		dd		0
		dd		0

;----------------------------------
; GDT TABLE INDEX #1
; INDEX      : 0x0008h
; TYPE       : CODE SEGMENT
; RING LEVEL : 0
; ATTRIBUTES : Excute/Read, Nonconforming, 4GB
;----------------------------------
codeDescriptor  equ 0x08
				dw		0ffffh			; segment limit 15:00
				dw		0000h			; base address 15:00
				db		00h				; base address 23:16
				db		10011010b		; P | DPL | S | TYPE
				db		11001111b		; G | D/B | 0 | AVL | segment limit 19:16
				db		00h				; base address 31:24
				
;----------------------------------
; GDT TABLE INDEX #2
; INDEX      : 0x0010h
; TYPE       : DATA SEGMENT
; RING LEVEL : 0
; ATTRIBUTES : Read/Write, 4GB
;----------------------------------
dataDescriptor  equ 0x10
				dw		0ffffh
				dw		0000h
				db		00h
				db		10010010b
				db		11001111b
				db		00h
				
;----------------------------------
; GDT TABLE INDEX #3
; INDEX      : 0x001Bh
; TYPE       : CODE SEGMENT
; RING LEVEL : 3
; ATTRIBUTES : Excute/Read, Nonconforming, second 1mega area
;----------------------------------
				dw		000ffh			; segment limit 15:00
				dw		0000h			; base address 15:00
				db		10h				; base address 23:16
				db		11111010b		; P | DPL | S | TYPE
				db		11001111b		; G | D/B | 0 | AVL | segment limit 19:16
				db		00h				; base address 31:24
				
;----------------------------------
; GDT TABLE INDEX #4
; INDEX      : 0x0023h
; TYPE       : DATA SEGMENT
; RING LEVEL : 3
; ATTRIBUTES : Read/Write, second 1mega area
;----------------------------------
				dw		000ffh
				dw		0000h
				db		10h
				db		11110010b
				db		11001111b
				db		00h
				
;----------------------------------
; GDT TABLE INDEX #5
; INDEX      : 0x0028h
; TYPE       : 32-Bit TSS
; RING LEVEL : 0
; DESC       : used by tmr_task_gate
;----------------------------------
				dw		0067h				; segment limit 15:00
				dw		0000h				; base address 15:00
				db		00h					; base address 23:16
				db		10001001b			; P | DPL | 0 | TYPE
				db		00000000b			; G | 0 | 0 | AVL | limit 19:16
				db		00h					; base address 31:24

;----------------------------------
; GDT TABLE INDEX #6
; INDEX      : 0x0030h
; TYPE       : 32-Bit TSS
; RING LEVEL : 0
; DESC       : used during system initialization
;----------------------------------
				dw		0067h				; segment limit 15:00
				dw		0000h				; base address 15:00
				db		00h					; base address 23:16
				db		10001001b			; P | DPL | 0 | TYPE
				db		00000000b			; G | 0 | 0 | AVL | limit 19:16
				db		00h					; base address 31:24
				
;----------------------------------
; GDT TABLE INDEX #7
; INDEX      : 0x0038h
; TYPE       : 32-Bit TSS
; RING LEVEL : 0
; DESC       : called whenever the system timer generates an interrupt
;----------------------------------
				dw		0067h				; segment limit 15:00
				dw		0000h				; base address 15:00
				db		00h					; base address 23:16
				db		10001001b			; P | DPL | 0 | TYPE
				db		00000000b			; G | 0 | 0 | AVL | limit 19:16
				db		00h					; base address 31:24
				
;----------------------------------
; GDT TABLE INDEX #8
; INDEX      : 0x0040h
; TYPE       : 32-Bit TSS
; RING LEVEL : 0
; DESC       : soft-task-switch. when any thread wants to task-swithing, call this.
;----------------------------------
				dw		0067h				; segment limit 15:00
				dw		0000h				; base address 15:00
				db		00h					; base address 23:16
				db		10001001b			; P | DPL | 0 | TYPE
				db		00000000b			; G | 0 | 0 | AVL | limit 19:16
				db		00h					; base address 31:24
				
;----------------------------------
; GDT TABLE INDEX #9
; INDEX      : 0x0048h
; TYPE       : 32-Bit TSS
; RING LEVEL : 0
; DESC       : call-gate for syscall
;----------------------------------
				dw		0000h				; offset 15:00
				dw		0000h				; selector
				db		01h					; dword count = 1 (4bytes)
				db		11101100b			; P, DPL=3, S=0, TYPE=1100
				dw		0000h				; offset 31:16

GDT_SIZE	equ	$ - _m_GdtTable		; Size, in bytes

times	512-($-$$)	db	00h
