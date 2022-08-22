.section .rodata
fmt_read: .asciz "Inserisci un numero: "
fmt_scan: .asciz "%d"
fmt_print: .asciz "%d\n"
.align 2

.bss
x: .word 0
y: .word 0


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

    scan fmt_read, x
    scan fmt_read, y

    ldr w0, x
    ldr w2, y
    mov w1, #0
    loop:
        add w1, w1, w0
        add w0, w0, #1
        cmp w0, w2
        ble loop

    adr x0, fmt_print
    bl printf

    mov w0, #0
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)
