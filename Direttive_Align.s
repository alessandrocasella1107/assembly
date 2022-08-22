.global main 

.data
list: .word 0, 1, 2, 3
bool: .byte 0
.align 2
n: .word 123

/*oppure con quad
.global main
.data 
list: .word 0, 1, 2, 3
bool: .byte 0
.align 3
n: .quad 123 */