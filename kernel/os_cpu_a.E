# 1 "os_cpu_a.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "os_cpu_a.S"
.section .text

.global OSStartHighRdy
.global OSIntCtxSw

.extern OSRunning

.extern TaskCurrent
.extern TaskNext

.code32
OSStartHighRdy:
    #call OSTaskSwHook
    movb $1, OSRunning
    movl TaskNext, %ebx
    movl (%ebx), %esp
    #popl %eax # pop pdata
    popa # acdb sp bp si di
    addl $8, %esp # vector, errcode
    iret

OSIntCtxSw:
    movl TaskNext, %eax
    movl %eax, TaskCurrent
    
    movl TaskNext, %ebx
    movl (%ebx), %esp
    
    #popl %eax # pop pdata
    popa
    
    addl $8, %esp # skip vector and errcode
    iret

#.data
#    DBG_STR db 'TaskNext = %08x'
