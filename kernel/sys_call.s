[bits 32]

;#include <linus/segment.h>

;/* DECLARATIONS */
global system_call, ret_from_sys_call
global sys_execve

global divide_error

extern printk, NR_syscalls, sys_call_table

;/* DEFINITIONS */

%define KERNEL_DS 0x18
%define USER_DS 0x23

%macro SAVE_ALL 0
	cld
	push gs
	push fs
	push es
	push ds
	push eax
	push ebp
	push edi
	push esi
	push edx
	push ecx
	push ebx
	mov edx, KERNEL_DS
	mov ds, dx
	mov es, dx
	mov edx, USER_DS
	mov fs, dx
%endmacro

%macro RESTORE_ALL 0
_1:	pop ebx
	pop ecx
	pop edx
	pop esi
	pop edi
	pop ebp
	pop eax
	pop ds
	pop es
	pop fs
	pop gs
	add esp, 4
	iret
%endmacro

segment .data
;/****************************************************************************
; *                            EXCEPTION ERROR MSG                           *
; ****************************************************************************/
msg_ECT_DivideByZero       db 'ECT_DivideByZero()'      , 20h, 0dh, 0ah, 00h
msg_ECT_DebugException     db 'ECT_DebugException()'    , 20h, 0dh, 0ah, 00h
msg_ECT_NMI                db 'ECT_NMI()'               , 20h, 0dh, 0ah, 00h
msg_ECT_Breakpoint         db 'ECT_Breakpoint()'        , 20h, 0dh, 0ah, 00h
msg_ECT_INTO               db 'ECT_INTO()'              , 20h, 0dh, 0ah, 00h
msg_ECT_BOUNDS             db 'ECT_BOUNDS()'            , 20h, 0dh, 0ah, 00h
msg_ECT_InvalidOpcode      db 'ECT_InvalidOpcode()'     , 20h, 0dh, 0ah, 00h
msg_ECT_DeviceNotAvailable db 'ECT_DeviceNotAvailable()', 20h, 0dh, 0ah, 00h
msg_ECT_DoubleFault        db 'ECT_DoubleFault()'       , 20h, 0dh, 0ah, 00h
msg_ECT_CoprocessorOverrun db 'ECT_CoprocessorOverrun'  , 20h, 0dh, 0ah, 00h
msg_ECT_InvalidTSS         db 'ECT_InvalidTSS()'        , 20h, 0dh, 0ah, 00h
msg_ECT_SegmentNotPresent  db 'ECT_SegmentNotPresent()' , 20h, 0dh, 0ah, 00h
msg_ECT_StackException     db 'ECT_StackException()'    , 20h, 0dh, 0ah, 00h
msg_ECT_GeneralProtection  db 'ECT_GeneralProtection()' , 20h, 0dh, 0ah, 00h
msg_ECT_PageFault          db 'ECT_PageFault()'         , 20h, 0dh, 0ah, 00h
msg_ECT_FloatingPointError db 'ECT_FloatingPointError()', 20h, 0dh, 0ah, 00h
msg_ECT_AlignmentCheck     db 'ECT_AlignmentCheck()'    , 20h, 0dh, 0ah, 00h
msg_ECT_MachineCheck       db 'ECT_MachineCheck()'      , 20h, 0dh, 0ah, 00h

; static variable using in exception error handler
dwESP dw 0000h

; debug msg using in exception error handler
dbg_ECT_Breakpoint         db 'bp, #1:0x%x, #2:0x%x, #3:0x%x', 20h, 0dh, 0ah, 00h ; 0x03
dbg_ECT_GeneralProtection  db 'gp, #1:0x%x, #2:0x%x, #3:0x%x', 20h, 0dh, 0ah, 00h ; 0x0d

;/*
; * IRQ INTERRUPT MSG *
; */
msg_IRQ_Keyboard           db 'IRQ_Keyboard()'          , 20h, 0dh, 0ah, 00h ; not use
msg_IRQ_ReqFromSlave8259   db 'IRQ_ReqFromSlave8259()'  , 20h, 0dh, 0ah, 00h
msg_IRQ_COM2               db 'IRQ_COM2()'              , 20h, 0dh, 0ah, 00h
msg_IRQ_COM1               db 'IRQ_COM1()'              , 20h, 0dh, 0ah, 00h
msg_IRQ_LPT2               db 'IRQ_LPT2()'              , 20h, 0dh, 0ah, 00h
msg_IRQ_FloppyDisk         db 'IRQ_FloppyDisk()'        , 20h, 0dh, 0ah, 00h ; not use
msg_IRQ_LPT1               db 'IRQ_LPT1()'              , 20h, 0dh, 0ah, 00h
msg_IRQ_CMOSClock          db 'IRQ_CMOSClock()'         , 20h, 0dh, 0ah, 00h
msg_IRQ_VGA                db 'IRQ_VGA()'               , 20h, 0dh, 0ah, 00h
msg_IRQ_Mouse              db 'IRQ_Mouse()'             , 20h, 0dh, 0ah, 00h
msg_IRQ_MathCoprocessor    db 'IRQ_MathCoprocessor()'   , 20h, 0dh, 0ah, 00h
msg_IRQ_HardDrive          db 'IRQ_HardDrive()'         , 20h, 0dh, 0ah, 00h

segment .text

; *	40(%esp) - %oldss

; *	3C(%esp) - %oldesp
; *	38(%esp) - %eflags
; *	34(%esp) - %cs
; *	30(%esp) - %eip

; *	2C(%esp) - orig_eax
; *	28(%esp) - %gs
; *      24(%esp) - %fs
; *	20(%esp) - %es

; *	1C(%esp) - %ds
; *	18(%esp) - %eax
; *	14(%esp) - %ebp
; *	10(%esp) - %edi

; *       C(%esp) - %esi
; *	 8(%esp) - %edx
; *	 4(%esp) - %ecx
; *	 0(%esp) - %ebx

;%define OLDSS		= 0x40 ; auto
;
;%define OLDESP		= 0x3C ; auto
;%define EFLAGS		= 0x38 ; auto
;%define CS		= 0x34 ; auto
;%define EIP		= 0x30 ; auto
;
;; below from here = manual
;%define ORIG_EAX	= 0x2C
;%define GS		= 0x28
;%define FS		= 0x24
;%define ES		= 0x20
;
;%define DS		= 0x1C
;%define EAX		= 0x18 ; 8888=44444444=0000 0000 0000 0000 0000 0000 0000 0000 
;%define EBP		= 0x14
;%define EDI		= 0x10
;
;%define ESI		= 0x0C
;%define EDX		= 0x08
;%define ECX		= 0x04
;%define EBX		= 0x00

%define EAX = 0x00
%define EBX = 0x04
%define ECX = 0x08
%define EDX = 0x0c
%define FS = 0x10
%define ES = 0x14
%define DS = 0x18
%define EIP = 0x1c
%define CS = 0x20
%define EFLAGS = 0x24
%define OLDESP = 0x28
%define OLDSS = 0x2c

system_call:
	push eax ; save origial eax
	; SAVE_ALL
	; abcd/efg/ip/eflags/ss/sp
	cld
	push sp
	push ss
	pushfd
	;push ip
	push gs
	push fs
	push es
	push edx
	push ecx
	push ebx
	push eax
	mov edx, KERNEL_DS
	mov ds, dx
	mov es, dx
	mov edx, USER_DS
	mov fs, dx

	cmp eax, NR_syscalls
	jmp ret_from_sys_call

	add eax, 4
	lea eax, [sys_call_table+eax*4]
	call eax

ret_from_sys_call:	
	;RESTORE_ALL
	pop eax
	pop ebx
	pop ecx
	pop edx
	pop es
	pop fs
	pop gs
	;pop ip
	popfd
	pop ss
	pop sp
	add esp, 4
	iret
	
divide_error:
	pushad

	push msg_ECT_DivideByZero
	call printk
	add esp, 4

	popad
	iretd

sys_execve:
	lea eax, [esp+0x30]
