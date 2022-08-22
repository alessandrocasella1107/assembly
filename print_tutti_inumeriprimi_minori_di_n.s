.section .rodata
fmt_read: .asciz "Inserisci un numero positivo: "
fmt_scan: .asciz "%d"
fmt: .asciz "%d\n"
.align 2

.data
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

    scan fmt_read, n

    mov w19, #1
    ldr w20, n

    loop:
        add w19, w19, #1
        cmp w19, w20
        bgt end 
        mov w0, w19
        bl primo
        cmp w0, #0
        beq loop
        adr x0, fmt
        mov w1, w19
        bl printf
        b loop
    end:

    mov w0, #0
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    .size main, (. - main)

.type primo, %function
primo:
    stp x29, x30, [sp, #-16]!
    str x19, [sp, #-8]!

    mov w19, #1
    cmp w0, w19
    ble numero_non_primo

    loop_primo_function:
        add w19, w19, #1
        cmp w19, w0
        bge numero_primo
        udiv w1, w0, w19
        msub w2, w1, w19, w0
        cmp w2, #0
        beq numero_non_primo
        b loop_primo_function

    numero_non_primo:  
        mov w0, #0
        b end_primo_function
    
    numero_primo: 
        mov w0, #1
    
    end_primo_function:

    ldr x19, [sp], #8
    ldp x29, x30, [sp], #16
    ret
    .size primo, (. - primo)   
