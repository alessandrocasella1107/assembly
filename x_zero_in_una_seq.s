.section .rodata
fmt_read_x: .asciz "Inserisci X: "
fmt_read: .asciz "Inserisci un numero positivo: "
fmt_scan: .asciz "%d"
fmt: .asciz "%d\n"
fmt_no: .asciz "NO\n"
fmt_si: .asciz "SI\n"
.align 2

.bss
x: .word 0
n: .word 0

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
    str x19, [sp, #-8]!
    
    scan fmt_read_x, x

    mov w19, #0
    loop:
        scan fmt_read, n
        ldr w2, n
        cmp w2, #0
        cinc w19, w19, eq
        bge loop

    ldr w2, x
    cmp w19, w2
    blt else
        adr x0, fmt_si
        bl printf
        b endif
    else:
        adr x0, fmt_no
        bl printf
    endif:

    mov w0, #0
    ldr x19, [sp], #8
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)
