;@Author:		John Lahut

;Purpose: Recursuion and fib sequence in assembly

title    fib.asm

.386
.model flat, stdcall	;Protected Mode

;Declare named constants
 LF equ 0Ah
 CR equ 0Dh

;External prototypes from the Irvine Library

ReadInt proto
WriteInt proto
WriteChar proto
WriteString proto
ExitProcess proto, :dword


.stack 100h

.data

prompt	byte	"Enter the number of Fibonacci numbers to generate (greater than 1): ", 0
msg1	byte	"The first ", 0
msg2	byte	" Fibonacci numbers are: ", LF, CR, 0
space	byte	" ", 0
comma	byte	",", 0

prev	dword	1d					;(n-2)
current	dword	1d					;(n-1)

number dword ?						;input
		
.code
main proc
	
	;Prompt user for integer
	mov edx, offset prompt
	call WriteString


	;Store input
	call ReadInt
	mov number, eax


	;Echo the input
	mov edx, offset msg1
	call WriteString

	call WriteInt

	mov edx, offset msg2
	call WriteString

	mov eax, prev
	call WriteInt

	mov al, comma
	call WriteChar

	mov eax, current
	call WriteInt

	mov al, comma
	call WriteChar


	;starting values
	mov ebx, 1						;ebx(prev) = 1
	mov eax, 1						;eax(current) = 1


	sub number, 3
	mov ecx, number				;we only will be finding new fib seq. # if the user wants
								;more than the first two numbers (would loop while lcv >3 in HLL)

	cmp ecx, 0					;check if counter is zero (will loop if counter is zero, resetting ecx to FFFFFFF)
	je lbl1						;if zero user entered 3
	jl lbl2						;if less than zero user entered 2

	
	

	L1:
		mov eax, current			;eax = current
		mov ebx, prev				;ebx = prev

		xchg ebx, eax				;swap regs
		add eax, ebx				;update eax (current)

		call WriteInt				;print the new # in sequence
				
		mov current, eax			;store updated sequence
		mov prev, ebx				

		mov al, comma				;output comma
		call WriteChar

	loop l1

	lbl1:
	
	mov eax, current				;for proper formatting we need to
	mov ebx, prev					;calculate the last value in sequence 
									;outside of loop
	xchg ebx, eax
	add eax, ebx


	call WriteInt	

	lbl2:

	mov al, lf
	call WriteChar
	mov al, cr
	call WriteChar


main endp



push 0
Call ExitProcess



end main