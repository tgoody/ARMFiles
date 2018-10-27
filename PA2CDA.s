.data
FirstOutput: .asciz "input an integer:\n"
outFormat: .asciz "%c"
numFormat: .asciz "%d"
strFormat: .asciz "%s"
flush: .asciz "\n"
debugger: .asciz "your character is: %c\n"
debugger2: .asciz "your string is: %s\n"
strBuffer: .space 64
numBuffer: .space 8

.section .text
.global main



//////////////////////

main:

ldr x0, =FirstOutput
bl printf

mov x0, #0
ldr x0, =numFormat
ldr x1, =numBuffer
bl scanf

mov x16, #1 //the constant value to be modding
ldr x0, =numBuffer //x0 has the value input
ldr x0, [x0, #0]
ldr x2, =strBuffer
mov x3, #0
b loop

loop: // 48 = 0, 49 = 1
cbz x0, continue
add x3, x3, #1
mov x16, #1
and x1, x0, x16 // x1 has the value of num%2
add x1, x1, #48
lsr x0, x0, #1


str x1, [sp, #-16]!
b loop

continue:
cbz x3, leave //if x3 over, return
sub x3, x3, #1 //sub
mov x24, x3 //temp

ldr x0, =outFormat
ldrb w1, [sp], #16 //ldrb w1 with character from stack
bl printf
mov x3, x24
b continue


leave:

ldr x0, =flush
bl printf
mov x8, #93
mov x0, #42
svc #0
