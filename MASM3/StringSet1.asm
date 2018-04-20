;=====================================================================================
; Author: 		Eric Le
; Assignment:	StringSet1 (MASM3)
; Class:		CS3B
; Date:			April 19, 2018
; Description:	
;	This file contains the original implementaions of the first assigned
;	set of string functions
;=====================================================================================
	include ..\Irvine\Irvine32.inc
	memoryallocBailey proto near32 stdcall, dsize:dword
	
	extern String_length@0:proc
	String_length equ String_length@0
	
	.data
	
	.code
;== String_equals ==================================
; Compare 2 strings and return a 1 in eax if true 
; 	and 0 in eax if false
;===================================================
String_equals proc 				
	ptrString1 equ [ebp + 12]	;get address of string1
	ptrString2 equ [ebp + 8]	;get address of string2
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used 
	push ebx
	push edx				
	push esi
	push edi 

	; Initialize to true ans mov string pointers
	mov eax, 1
	mov esi, ptrString1	
	mov edi, ptrString2	
	
	; Segment checks for end of string by looking for null
nextChar:
	mov bl, [esi]
	mov dl, [edi]
	cmp bl, 0
	jne compare	
	cmp dl, 0			
	jne compare
	jmp endProc
	
	; Segment to compare two chars and loop back
compare:
	inc esi	
	inc edi	
	cmp bl, dl
	je nextChar	
	mov eax, 0

	; Pop all used registers and return
endProc:
	pop edi	
	pop esi	
	pop edx	
	pop ebx	
	
	pop ebp	
	ret	
String_equals endp

;== String_equalsIgnoreCase ========================
; Compare 2 strings and return a 1 in eax if true 
; 	and 0 in eax if false, but ignores casing
;===================================================
String_equalsIgnoreCase proc
	ptrString1 equ [ebp + 12]	;get address of string1
	ptrString2 equ [ebp + 8]	;get address of string2
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push ebx
	push edx
	push esi
	push edi

	; Initialize to true ans mov string pointers
	mov eax, 1
	mov esi, ptrString1	
	mov edi, ptrString2	
	
	; Segment to check for end of string
nextChar:
	mov bl, [esi]
	mov dl, [edi]
	cmp bl, 0
	jne compare	
	cmp dl, 0
	jne compare	
	jmp endProc	

	; Segment to check for casing and make uppercase
compare:
	inc esi
	inc edi	
	cmp bl, 'a'	;makes sure the char is within range of alphabet
	jb cont	
	cmp bl, 'z'	;makes sure the char is within range of alphabet
	ja cont	
	sub bl, 32	

	; Segment that deos the same but for other char
cont:				
	cmp dl, 'a'	;makes sure the char is within range of alphabet
	jb cont2		
	cmp dl, 'z'	;makes sure the char is within range of alphabet
	ja cont2	
	sub dl, 32
	
	; Segment to check if chars are equal
cont2:			
	cmp bl, dl				
	je nextChar					
	mov eax, 0	

	; Pop all used registers and return
endProc:		
	pop edi	
	pop esi	
	pop edx	
	pop ebx	
	
	pop ebp						
	ret	
String_equalsIgnoreCase endp

;== String_copy ====================================
; Allocates new memory for a string and copies the
;	source sting contents into the newly created
;	string
;===================================================
String_copy proc
	ptrString equ [ebp + 8]		;get address of the string
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push esi
	push edi
	push ebx
	
	; Copy ptrString into esi
	mov esi, ptrString
	
	; Allocate new memory for the new string
	invoke memoryallocBailey, 1000
	mov edi, eax	;new strings value is now in edi and eax
	
	; Segment to check for end of string for source
nextChar:
	mov bh, [esi]
	mov bl, [edi]
	cmp bh, 0
	jne copy
	jmp endProc

	; Segment to copy contents into the new string and move
	;  to the next char
copy:
	mov [edi], bh
	inc esi
	inc edi
	jmp nextChar
	
	; Pop all used registers and return
endProc:
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
String_copy endp

;== String_substring_1 =============================
; Allocate memory for a new string and copy the 
;	contets of a source string into it based off 
;	given indices
;===================================================
String_substring_1 proc	
	ptrString equ [ebp + 16]	; address of string1
	beginIndex equ [ebp + 12]	; beginning index
	endIndex equ [ebp + 8]		; ending index
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push esi
	push edi
	push ebx
	push ecx
	push edx
	
	; Copy ptrString into esi
	mov esi, ptrString
	
	; Allocate new momory for new string
	invoke memoryallocBailey, 1000
	mov edi, eax	;new strings address in edi and eax
	
	; Save indices
	mov edx, beginIndex
	mov ecx, endIndex
	
	; Check if endi index is less that beginning index
	cmp edx, ecx
	jle continue
	jmp endProc
	
	; Check if the index is less than 0
	cmp edx, 0
	jge continue
	jmp endProc
	
	; Get String Length of string1
	push esi
	call String_length
	add esp, 4
	
	; Check if the index is greater than the length
	cmp ecx, eax
	jl continue
	jmp endProc

	; resave new string address and set a count to copy
continue:
	mov eax, edi
	sub ecx, edx
	
	; Segment to get current chars and check count for 0
nextChar:
	mov bh, [esi + edx]
	mov bl, [edi]
	cmp ecx, 0
	jge copy
	jmp endProc

	; Segment to copy the contents
copy:
	mov [edi], bh
	dec ecx
	inc esi
	inc edi
	jmp nextChar
	
	; Pop all used registers and return
endProc:
	pop edx
	pop ecx
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
String_substring_1 endp

;== String_substring_2 =============================
; Allocate memory for a new string and copy the 
;	contets of a source string into it based off 
;	given starting index
;===================================================
String_substring_2 proc	
	ptrString equ [ebp + 12] ;string1
	beginIndex equ [ebp + 8] ;start index
	
	; Push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push esi
	push edi
	push ebx
	push ecx
	
	; Allocate new memory for new string 
	invoke memoryallocBailey, 1000
	mov edi, eax
	
	; Save string1 pointer and index into registers
	mov esi, ptrString
	mov ecx, beginIndex
	
	; Check if beginning index is less than 0
	cmp ecx, 0
	jge nextChar
	jmp endProc
	
	; Get string length
	push esi
	call String_length
	add esp, 4
	
	; Check if Length is less thatn index
	cmp ecx, eax
	mov eax, edi
	jl nextChar
	jmp endProc
	
	; Segment to check for end of string for source string
nextChar:
	mov bh, [esi + ecx]
	mov bl, [edi]
	cmp bh, 0
	jge copy
	jmp endProc
	
	; Segment to copy contents
copy:
	mov [edi], bh
	inc esi
	inc edi
	jmp nextChar
	
	; Pop all used registers and return
endProc:
	pop ecx
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
String_substring_2 endp

;== String_charAt ==================================
; Return a character of a string at a specified 
;	index
;===================================================
String_charAt proc
	ptrString equ [ebp + 12]
	index equ[ebp + 8]
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push esi
	push ecx
	push edx
	
	; Set registers 
	mov edx, '0'
	mov esi, ptrString
	mov ecx, index
	add ecx, 1	; must be incremented

	; Get string length
	push ptrString
	call String_length
	add esp, 4
	
	; Check if the index is greater than the lenght 
	cmp eax, ecx
	jl endProc
	
	; Check if the index is less than 0
	cmp ecx, 0
	jl endProc
	
	; Segment to check for count of 0 and save current char
beginWhile:
	cmp ecx, 0
	je endProc
	mov dl, byte ptr [esi]
	inc esi
	dec ecx
	jmp beginWhile
	
	; Resave eax and pop all used registers and return
endProc:
	mov eax, edx
	
	pop edx
	pop ecx
	pop esi
	pop ebp
	ret
String_charAt endp

;== String_startsWith_1 ============================
; Return true if the string contains a substring 
;	starting at a specified index
;===================================================
String_startsWith_1 proc
	ptrString equ [ebp + 16]
	ptrSubString equ [ebp + 12]
	index equ[ebp + 8]
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push esi
	push edi
	push ecx
	push ebx
	
	; Set registers
	mov eax, 1
	mov esi, ptrString
	mov edi, ptrSubString
	mov ecx, index
	
	; Check for end of sting
nextChar:
	mov bh, [esi + ecx]
	mov bl, [edi]
	cmp bl, 0
	jne compare
	jmp endProc

	; Compare the chars and prep for next char
compare:
	inc esi
	inc edi
	cmp bl, bh
	je nextChar
	mov eax, 0
	
	; Pop all used registers and return
endProc:
	pop ebx
	pop ecx
	pop edi
	pop esi
	pop ebp
	ret
String_startsWith_1 endp

;== String_startsWith_2 ============================
; Return true if the string contains a substring 
;	starting at a index 0
;===================================================
String_startsWith_2 proc
	ptrString equ [ebp + 12]
	ptrSubString equ [ebp + 8]
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push esi
	push edi
	push ebx
	
	; Set registers
	mov eax, 1
	mov esi, ptrString
	mov edi, ptrSubString
	
	; Check for end of string
nextChar:
	mov bh, [esi]
	mov bl, [edi]
	cmp bl, 0
	jne compare
	jmp endProc

	; Compare the chars and prep next char
compare:
	inc esi
	inc edi
	cmp bl, bh
	je nextChar
	mov eax, 0
	
	; Pop all used registers and return
endProc:
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
String_startsWith_2 endp

;== String_endsWith ================================
; Returns true if the string ends with a given 
;	substring 
;===================================================
String_endsWith proc
	ptrString equ [ebp + 12]
	ptrSubString equ [ebp+ 8]
	
	; push ebp ans save esp into ebp to use
	push ebp
	mov ebp, esp
	
	; Push other registers to be used
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	; Set pointers registers
	mov esi, ptrString
	mov edi, ptrSubString	
	
	; Get string lenght and dec by 1 to get max index
	push esi
	call String_length
	add esp, 4
	mov ecx, eax
	dec ecx
	
	; Get substring length and get its max index
	push edi
	call String_length
	add esp, 4
	mov edx, eax
	dec edx
	
	; Check if the index is greater than the length
	cmp edx, ecx
	jl nextChar
	mov eax, 0
	jmp endProc
	
	; Get chars and check fo end of string
nextChar:	
	mov eax, 1
	mov bh, [esi + ecx]
	mov bl, [edi + edx]
	cmp edx, 0
	jge compare
	jmp endProc

	; Compare and decrement for nex char
compare:
	dec ecx
	dec edx
	cmp bl, bh
	je nextChar
	mov eax, 0

	; Pop all used registers and return
endProc:	
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret
String_endsWith endp
 
end




















