title    Lab7a.asm   ;John Lahut

.386
.model flat, stdcall


;FILL IN CODE for external procedure prototypes
Crlf proto
ReadInt proto
WriteInt proto
WriteString proto
ExitProcess proto :DWORD

.stack 100h

.data
        prompt  byte    "Enter a positive number: ", 0
        msg1    byte    "The sum of the numbers from 1 to ", 0
        msg2    byte    " is ", 0
        number  dword   ?
        result  dword   ?

.code

main proc
       ;FILL IN CODE to Print "Enter a positive number: "
	   mov edx, OFFSET prompt
	   call WriteString


       ;FILL IN CODE to Read in a value and store it in number
	   call ReadInt
	   mov number, eax			;number = eax


       ;FILL IN CODE to call value returning function SumOf
       ; Use the stack to send SumOf number's value
       ; Your code should store the sum of 1 + 2 + ... + number
       ; in result upon return from function SumOf
	   push number				;push the function argument onto the stack
	   call sumOf				;SumOf(number)

       ;FILL IN CODE to Print:
       ;   "The sum of the numbers from 1 to " number " is " result
       mov edx, offset msg1
	   call WriteString

	   mov eax, number
	   call WriteInt

	   mov edx, offset msg2
	   call WriteString

	   mov eax, result
	   call WriteInt
	   call Crlf

       ;FILL IN CODE to Print "Enter a positive number: "
	   mov edx, offset prompt
	   call WriteString


       ;FILL IN CODE to read a value and store it in number
	   call ReadInt
	   mov number, eax			;number = eax


       ;FILL IN CODE to call procedure CalcSum(number, result)
       ; where number is sent into a value parameter and result
       ; is sent to a reference parameter

	   push number						;add number to stack
	   push offset result				;add address of result onto stack
	   call calcSum



       ;FILL IN CODE to Print:
       ;   "The sum of the numbers from 1 to " number " is " result
       mov edx, offset msg1
	   call WriteString

	   mov eax, number
	   call WriteInt

	   mov edx, offset msg2
	   call WriteString

	   mov eax, result
	   call WriteInt
	   call Crlf



       ;FILL IN CODE to terminate the program
	   call ExitProcess
	
	   
	   


main endp


;FILL IN CODE for value returning function SumOf.  SumOf should leave 
;  its parameter on the stack and use indirection through ebp to access
;  it.  Be sure to save all used registers (except eax) and to restore
;  them before returning.

NUM_PARAM				equ				[ebp+12]
sumOf proc

push ebp					;preserve registers
push ecx

mov ebp, esp				;align stack pointers
mov eax, 0					;clear EAX


mov ecx, NUM_PARAM			;get function parameter and put it in loop counter reg

sum:						;eax will contain result 
	add eax, ecx			;loop through until the LCV is zero
	loop sum

mov result, eax				;result = eax


pop ecx						;restore resisters (in reverse order)
pop ebp

ret
sumOf endp


;FILL IN CODE for void function CalcSum(dword numb, dword& res)
; Leave the argument values on the stack and use indirection through
; ebp to access them.  Be sure to save all used registers and restore
; them before returning.

NUM_PARAM					equ					[ebp+20]
OFFSET_RESULT				equ					[ebp+16]
calcSum proc

;preserve registers

push ebp					;base stack ptr
push ecx					;lcv reg
push ebx					;used for accessing ref param

mov ebp, esp				;align stack pointers
mov eax, 0					;clear eax


mov ecx, NUM_PARAM			;get function param and put it into loop counter reg

sum:
	add eax, ecx			;eax will contain result
	loop sum				;loop through until LCV is zero


;want to store whats in the eax to the ref param result whose memory address is located at [ebp+12]

mov ebx, OFFSET_RESULT			;ebx = &result
mov [ebx], eax				;result = eax



;restore regs
pop ebx							
pop ecx						
pop ebp

ret
calcSum endp


end main
