; Context switch
;
; void context_switch(struct context *old, struct context *new);
; 
; Save current register context in old
; and then load register context from new.

global context_switch

; VOID context_switch(struct __CONTEXT *, struct __CONTEXT *);
context_switch:
	mov eax, [esp+4]
	mov edx, [esp+8]

	; Save old callee-save registers
	push ebp
	push ebx
	push esi
	push edi

	; Switch stacks
	mov [eax], esp
	mov esp, edx

	; Load new callee-save registers
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret

