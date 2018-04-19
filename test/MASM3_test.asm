; Author: 		Eric Le
; Assignment:	MASM3
; Class:		CS3B
; Date:			April 19, 2018
; Description:
	
	; External libraries and macros
	include ..\Irvine\Irvine32.inc
	
	extern String_indexOf_2@0:proc
	String_indexOf_2 equ String_indexOf_2@0
	extern String_indexOf_1@0:proc
	String_indexOf_1 equ String_indexOf_1@0
	extern String_indexOf_3@0:proc
	String_indexOf_3 equ String_indexOf_3@0
	extern String_lastIndexOf_1@0:proc
	String_lastIndexOf_1 equ String_lastIndexOf_1@0
	extern String_lastIndexOf_2@0:proc
	String_lastIndexOf_2 equ String_lastIndexOf_2@0
	
	.data
	string1 byte "hello world",0
	subString byte "world",0
	.code
main proc

	push offset string1	
	push 'h'
	push 6
	call String_lastIndexOf_2
	call WriteInt
	add esp, 12
	
	exit
main endp

;== String_length ==================================
; Return the number of characters in a string
;===================================================
String_length proc 
	ptrString equ [ebp + 8]
	push ebp
	mov ebp, esp
	push esi
	mov eax, 0
	mov esi, ptrString
beginWhile:
	cmp byte ptr [esi], 0
	je endWhile
	inc esi
	inc eax
	jmp beginWhile
endWhile:
	pop esi
	pop ebp
	ret
String_length endp

end main





