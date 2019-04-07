[bits 32]

global READ_PORT_UCHAR, WRITE_PORT_UCHAR
global HalEnableInterrupt

segment .text
READ_PORT_UCHAR:
	push ebp
	mov ebp, esp
	push edx

	mov edx, [ebp+8]
	in al, dx

	pop edx
	pop ebp
	ret

WRITE_PORT_UCHAR:
	push ebp
	mov ebp, esp
	push edx
	push eax

	mov edx, [ebp+8]
	mov al, [ebp+12]
	out dx, al

	pop eax
	pop edx
	pop ebp
	ret

;HalEnableInterrupt:
;	push ebp
;	mov ebp, esp
;	push eax
;
;	mov eax, [ebp+8]
;	lidt fword ptr [eax]
;
;	pop eax
;	pop ebp
;	ret
