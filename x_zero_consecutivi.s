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
    stp x19, x20, [sp, #-16]!
    
    scan fmt_read_x, x

    mov w19, #0
    mov w20, #0
    loop:
        ldr w20, n
        
        scan fmt_read, n
        ldr w2, n
        cmp w2, #0
        blt endloop

        ldr w3, x
        cmp w19, w3
        bge loop

        ldr w2, n
        cmp w2, #0
        mov w2, #0
        csinc w19, w2, w19, ne
        b loop
    endloop:

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
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)
