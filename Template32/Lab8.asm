title  Lab8.asm

.386
.model flat, stdcall

;Named constants
 MAX_SIZE equ 100

;External procedure prototypes
 ReadInt proto
 WriteInt proto
 Crlf proto
 WriteString proto
 WaitMsg proto
 ClrScr proto
 SetTextColor proto
 ExitProcess proto, dwExitcode:dword

.stack 100h

.data
        prompt1  byte  "Enter the # of values (<=100) to store in list: ", 0
        prompt2  byte  "Enter values, one per line:", 0
        msgRev   byte  "The values in reverse order are:", 0
        numValues dword ?							;# of values to store in listA
        listA     sdword  MAX_SIZE dup (?)			;array of upto MAX_SIZE signed integers

.code
 main proc
	 ;FILL IN CODE to change the screen's textcolor to light red and the backcolor to white, 
	 ; and then to clear the screen


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
     ; Fill(listA, numValues)



     ;FILL IN CODE to pause and clear the screen



     ;Print "The values in reverse order are:"
      mov edx, offset msgRev
      call WriteString
      call Crlf

     ;FILL IN CODE to do the following procedure call
     ; PrintReverse(listA, numValues)



     ;Terminate the program
      push 0
      call ExitProcess
main endp

;FILL IN CODE for procedure Fill which fills an array with numValues
; values which come from the user.



;FILL IN CODE for procedure PrintReverse which will print the values
; stored in its array argument in reverse order 


end main


