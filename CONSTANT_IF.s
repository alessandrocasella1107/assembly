.section .rodata
fmt: 
    .asciz "%d\n"

.equ CONSTANT, 1

.macro print n
    adr x0, fmt
    mov w1, \n
    bl printf
.endm

.text
.type main, %function
.global main
main:
    stp x29, x30, [sp, #-16]!

    .ifndef CONSTANT
        print 1
    .else
        print 0
    .endif

    // return 0
    mov w0, #0
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)

/*cambiando .equ constant 1 con 10 non cambierebbe nulla
per aggiungere .equ constant 2, 1 nel main cambiamo come segue
.ifdef CONSTANT
    .ifdef constant2
        print 1
    else
        print 0
    endif
else 
     print 0
.endif
aarch64-linux-gnu-gcc -o CONSTANT_IF.s qemu-aarch64 CONSTANT */
