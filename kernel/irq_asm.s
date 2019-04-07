[bits 32]

global IRQ0_interrupt, IRQ1_interrupt, IRQ2_interrupt, IRQ3_interrupt
global IRQ4_interrupt, IRQ5_interrupt, IRQ6_interrupt, IRQ7_interrupt
global IRQ8_interrupt, IRQ9_interrupt, IRQ10_interrupt, IRQ11_interrupt
global IRQ12_interrupt, IRQ13_interrupt, IRQ14_interrupt, IRQ15_interrupt

global fast_IRQ0_interrupt, fast_IRQ1_interrupt, fast_IRQ2_interrupt, fast_IRQ3_interrupt
global fast_IRQ4_interrupt, fast_IRQ5_interrupt, fast_IRQ6_interrupt, fast_IRQ7_interrupt
global fast_IRQ8_interrupt, fast_IRQ9_interrupt, fast_IRQ10_interrupt, fast_IRQ11_interrupt
global fast_IRQ12_interrupt, fast_IRQ13_interrupt, fast_IRQ14_interrupt, fast_IRQ15_interrupt

global bad_IRQ0_interrupt, bad_IRQ1_interrupt, bad_IRQ2_interrupt, bad_IRQ3_interrupt
global bad_IRQ4_interrupt, bad_IRQ5_interrupt, bad_IRQ6_interrupt, bad_IRQ7_interrupt
global bad_IRQ8_interrupt, bad_IRQ9_interrupt, bad_IRQ10_interrupt, bad_IRQ11_interrupt
global bad_IRQ12_interrupt, bad_IRQ13_interrupt, bad_IRQ14_interrupt, bad_IRQ15_interrupt

extern ret_from_sys_call
extern IRQDo, IRQDoFast

%define KERNEL_DS 0x18
%define USER_DS 0x2B

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
	mov edx, 0
%endmacro
	
%macro SAVE_MOST 0
	cld
	push es
	push ds
	push eax
	push edx
	push ecx
	mov edx, KERNEL_DS
	mov ds, dx
	mov es, dx
%endmacro

%macro RESTORE_MOST 0
	pop ecx
	pop edx
	pop eax
	pop ds
	pop es
	iret
%endmacro

;void bad_IRQ0_interrupt(void);
;void bad_IRQ1_interrupt(void);
;void bad_IRQ2_interrupt(void);
;void bad_IRQ3_interrupt(void);
;void bad_IRQ4_interrupt(void);
;void bad_IRQ5_interrupt(void);
;void bad_IRQ6_interrupt(void);
;void bad_IRQ7_interrupt(void);
;void bad_IRQ8_interrupt(void);
;void bad_IRQ9_interrupt(void);
;void bad_IRQ10_interrupt(void);
;void bad_IRQ11_interrupt(void);
;void bad_IRQ12_interrupt(void);
;void bad_IRQ13_interrupt(void);
;void bad_IRQ14_interrupt(void);
;void bad_IRQ15_interrupt(void);

IRQ0_interrupt:
IRQ1_interrupt:
IRQ2_interrupt:
IRQ3_interrupt:
IRQ4_interrupt:
IRQ5_interrupt:
IRQ6_interrupt:
IRQ7_interrupt:
IRQ8_interrupt:
IRQ9_interrupt:
IRQ10_interrupt:
IRQ11_interrupt:
IRQ12_interrupt:
IRQ13_interrupt:
IRQ14_interrupt:
IRQ15_interrupt:
	SAVE_ALL
	call IRQDo
	jmp ret_from_sys_call

fast_IRQ0_interrupt:
fast_IRQ1_interrupt:
fast_IRQ2_interrupt:
fast_IRQ3_interrupt:
fast_IRQ4_interrupt:
fast_IRQ5_interrupt:
fast_IRQ6_interrupt:
fast_IRQ7_interrupt:
fast_IRQ8_interrupt:
fast_IRQ9_interrupt:
fast_IRQ10_interrupt:
fast_IRQ11_interrupt:
fast_IRQ12_interrupt:
fast_IRQ13_interrupt:
fast_IRQ14_interrupt:
fast_IRQ15_interrupt:
	SAVE_MOST
	call IRQDoFast
	RESTORE_MOST
	
bad_IRQ0_interrupt:
bad_IRQ1_interrupt:
bad_IRQ2_interrupt:
bad_IRQ3_interrupt:
bad_IRQ4_interrupt:
bad_IRQ5_interrupt:
bad_IRQ6_interrupt:
bad_IRQ7_interrupt:
bad_IRQ8_interrupt:
bad_IRQ9_interrupt:
bad_IRQ10_interrupt:
bad_IRQ11_interrupt:
bad_IRQ12_interrupt:
bad_IRQ13_interrupt:
bad_IRQ14_interrupt:
bad_IRQ15_interrupt:
	SAVE_MOST
	RESTORE_MOST
