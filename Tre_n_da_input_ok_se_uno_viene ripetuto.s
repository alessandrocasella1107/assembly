.section .rodata
fmt_read: .asciz "Inserisci un numero: "
fmt_scan: .asciz "%d"
fmt_print: .asciz "%d\n"
fmt_ok: .asciz "OK\n"

.align 2

.bss
a: .word 0
b: .word 0
c: .word 0

.macro print fmt
    adr x0, \fmt
    bl printf
.endm

.macro print_value fmt
    adr x0, \fmt
    bl printf
.endm

.macro scan fmt var
    adr x0, \fmt
    bl printf

    adr x0, fmt_scan
    ldr x1, =\var
    bl scanf
.endm

.text
.type main, %function
.global main
main:
    stp x29, x30, [sp, #-16]!

    scan fmt_read, a
    scan fmt_read, b
    scan fmt_read, c

    ldr w0, a
    ldr w2, b
    ldr w3, c

    cmp w0, w2
    mov w1, w0
    beq else
    
    cmp w0, w3
    mov w1, w0
    beq else
    
    cmp w2, w3
    mov w1, w2
    beq else
    
        print fmt_ok
        b endif        
    else:
        print_value fmt_print
    endif:

    mov w0, #0
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)
