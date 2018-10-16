.data
outformat: .asciz "%s"
flush: .asciz "\n"
pattern: .asciz "%s"
lengthread: .asciz "%d"
FirstOutput: .asciz "input a string:\n"
isPalin: .asciz "It is a palindrome\n"
notPalin: .asciz "It is not a palindrome\n"
lengthOut: .asciz "Your length is: %d\n"
debugPlz: .asciz "Your character is: %d\n"
sendHelp: .asciz "send help\n"
.equ cr, 0x00
lr_bu: .space 8
lr_bu2: .space 8
string: .space 64


.section .text
.global main



//////////////////////



length:

ldrb w2, [x1]
cmp w2, cr
beq getout

add x0, x0, #1
add x1, x1, #1


b length

ret




//////////////////////



findPalin:
//x0 has length-1
//x1 has string
//x2 has front of string

mov x21, x2
str x30, [SP, #-16]!

ldrb w4, [x1, x2] //w4 should have first letter of string
ldrb w5, [x1, x0] //w5 should have last letter of string
stp w4, w5, [SP, #-16]!


cmp x2, x0
beq getout

add x21, x21, #1
cmp x21, x0
beq getout

add x2, x2, #1 //move front of string up
sub x0, x0, #1 //move end of string down

bl findPalin

ldp w4, w5, [SP], #16
ldr x30, [SP], #16

mov x6, #999

cmp w4, w5
bne false
br x30


false:
mov x6, #0
bl done


getout:
br x30

/////////////////

main:

ldr x0, =FirstOutput
bl printf

ldr x0, =pattern
ldr x1, =string
bl scanf

ldr x8, =string //x8 now has string
ldr x1, =string
mov x0, #0
bl length

mov x20, x0 //x20 should have length of string
ldr x0, =lengthOut
mov x1, x20
bl printf


mov x0, x20 //0 also has the length again
sub x0, x0, #1 //convert length to length-1
ldr x1, =string //1 should have the string to check

lsr x20, x20, #1 //divides length by 2
mov x7, x20
mov x2, #0
mov x4, #0
mov x5, #0
bl findPalin
mov x21, x6

ldr x0, =debugPlz
mov x1, x6
bl printf

bl printYes

//exit the program
mov x8, #93
mov x0, #42
svc #0
ret



done:
b printNo


///////////////
printYes:
ldr x0, =isPalin
bl printf
mov x8, #93
mov x0, #42
svc #0
ret


///////////////
printNo:
ldr x0, =notPalin
bl printf
mov x8, #93
mov x0, #42
svc #0
ret
