.section .rodata.
fmt_read: .asciz "inserisci un numero positivo:"
fmt_scan: .asciz "%d"
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
    stp x20, x21, [sp, #-16]!

    mov w20, #0
    mov w21, #0
    loop:
        ldr w20, n
        scan fmt_read, n
        
        ldr w2, n
        cmp w2, #0
        blt endloop

        cmp w2, w20
        mov w0, #1
        csel w21, w0, w21, le
        b loop
    endloop:

    cmp w21, #1
    beq non_crescente

    adr x0, fmt_si
    bl printf
    b endif

    non_crescente:
        adr x0, fmt_no
        bl printf
        b endif
    endif:

    mov w0, #0
    ldp x20, x21, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)
