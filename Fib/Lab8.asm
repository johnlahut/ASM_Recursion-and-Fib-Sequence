;@Author: John Lahut
;@Project: Lab8
;@Filename: Lab8.asm


title  Lab8.asm

.386
.model flat, stdcall

;Named constants
 MAX_SIZE			equ		100
 TEXT_COLOR			equ		12
 BACKGROUND_COLOR	equ		(15*16)		

;External procedure prototypes
 ReadInt proto
 WriteInt proto
 Crlf proto
 WriteString proto
 WaitMsg proto
 Clrscr proto
 SetTextColor proto
 ExitProcess proto, dwExitcode:dword
 WriteHex proto

.stack 100h

.data
        prompt1  byte  "Enter the # of values (0<#<=100) to store in list: ", 0
        prompt2  byte  "Enter values, one per line:", 0
        msgRev   byte  "The values in reverse order are:", 0
        numValues dword ?							;# of values to store in listA
        listA     sdword  MAX_SIZE dup (?)			;array of upto MAX_SIZE signed integers

.code
 main proc
	 ;FILL IN CODE to change the screen's textcolor to light red and the backcolor to white, 
	 ; and then to clear the screen
	 mov eax, TEXT_COLOR + BACKGROUND_COLOR
	 call SetTextColor
	 call Clrscr


     ;Print "Enter the # of values to store in the list: "
      mov edx, offset prompt1
      call WriteString

     ;Read numValues
      call ReadInt
      mov numValues, eax

     ;Print "Enter values, one per line:"
      mov edx, offset prompt2
      call WriteString
      call Crlf

     ;FILL IN CODE to do the following procedure call
	 ;Fill(listA, numValues)
	 ;esi will contain the memory address of the next open location upon return of control
	 push numValues
	 push offset listA
	 call Fill
     



     ;FILL IN CODE to pause and clear the screen
	 call WaitMsg
	 call Clrscr


     ;Print "The values in reverse order are:"
      mov edx, offset msgRev
      call WriteString
      call Crlf

     ;FILL IN CODE to do the following procedure call
     ; PrintReverse(listA, numValues)
	 push numValues
	 push offset listA
	 call PrintReverse



     ;Terminate the program
      push 0
      call ExitProcess
main endp

;FILL IN CODE for procedure Fill which fills an array with numValues
; values which come from the user.
;Pre:	&listA is pushed onto s.stack
;	:	numValues is pushed onto s.stack
;Post:	all regs are preserved
;	:	the array is filled

OFFSET_LISTA		equ			[ebp+20]				;base address of array at ebp+16
NUM_VALUES			equ			[ebp+24]				;numValues base address located at ebp+20
Fill proc

;preserving registers
push esi
push ecx					;lcv reg
push eax					;math ops
push ebp					;base stack ptr

;setting up registers for use
mov ebp, esp				;ebp <--> esp
mov esi, OFFSET_LISTA		;esi now contains the base address of the array
mov ecx, NUM_VALUES			;loop counter now contains value of numValues


;loop for # of elements to be added to the array
DO1:

call ReadInt							;user inputs integer
mov [esi], eax							;current array ptr will always point to the next open spot
add esi, TYPE listA								;increment array ptr to next open mem loc. 

loop DO1								;upon termination of the loop, esi will point to the memory location directly
										;above the last element added

;restore regs
pop ebp
pop eax
pop ecx
pop esi

;return control
ret
Fill endp



;FILL IN CODE for procedure PrintReverse which will print the values
; stored in its array argument in reverse order 
;Pre: array is filled
:post: array is output to the screen in reverse order
OFFSET_LISTA		equ			[ebp+20]				;base address of array at ebp+16
NUM_VALUES			equ			[ebp+24]				;numValues base address located at ebp+24
PrintReverse proc

;preserving registers
push esi
push ecx
push eax
push ebp

mov ebp, esp										;align stack ptrs
mov ecx, NUM_VALUES									;lcv --> numValues
mov esi, OFFSET_LISTA								;esi contains the base address of the array

;push array onto stack
L2:

push [esi]
add esi, type listA

loop L2

mov ecx, NUM_VALUES									;reset LCV


L3:

;pop 'em --> write 'em
pop eax
call WriteInt
call Crlf

loop L3

;restore registers
pop ebp
pop eax
pop ecx
pop esi

ret
PrintReverse endp


end main


