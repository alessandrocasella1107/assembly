/*ordinamento*/

.global main
.data
a: .byte 0, 1, 2
.align 1
b: .hword 15
c: .byte 'A'
.align 2
d: .word 5, 2
.align 3
e: .quad 4, 9
f: .asciz "Ciao"

/* senza align*/
e: .quad 4, 9
d: .word 5, 2
b: .hword 15
a: .byte 0, 1, 2
c: .byte "A"
f: .asciz "Ciao"
/* a, c, ordine irrilevante*/
