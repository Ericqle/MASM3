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
String_equals proc 				;start of procedure
	ptrString1 equ [ebp + 12]	;get address of string1
	ptrString2 equ [ebp + 8]	;get address of string2
	
	push ebp					;push ebp to stack
	mov ebp, esp				;save esp into ebp
	
	push ebx					;push ebx to stack 
	push edx					;push edx to stack 							
	push esi					;push esi to stack 
	push edi					;push edi to stack 


	mov eax, 1					;set eax true
	mov esi, ptrString1			;save string 1 pointer to esi
	mov edi, ptrString2			;save string 2 pointer to esi
	
nextChar:						;label for next char in string
	mov bl, [esi]				;save char of string1 in dl
	mov dl, [edi]				;save char of string2 in bl
	cmp bl, 0					;chaeck if end of string
	jne compare					;goto compare label if not 0
	cmp dl, 0					;check if end of string
	jne compare					;goto compare label if not 0
	jmp endProc					;goto end procedure if 0

compare:						;label to compare the chars
	inc esi						;prep for next char
	inc edi						;prep for next char
	cmp bl, dl					;compare the chars
	je nextChar					;goto next char if true
	mov eax, 0					;return value of false if not equal

endProc:						;label for end procedure
	pop edi						;pop edi off stack
	pop esi						;pop esi off stack
	pop edx						;pop edx off stack
	pop ebx						;pop ebx off stack
	
	pop ebp						;pop ebp off stack
	ret							;return to prev address
String_equals endp				;end of procedure

;== String_equalsIgnoreCase ========================
; Compare 2 strings and return a 1 in eax if true 
; 	and 0 in eax if false, but ignores casing
;===================================================
String_equalsIgnoreCase proc 	;start of procedure
	ptrString1 equ [ebp + 12]	;get address of string1
	ptrString2 equ [ebp + 8]	;get address of string2
	
	push ebp					;push ebp to stack
	mov ebp, esp				;save esp into ebp
	
	push ebx					;push ebx to the stack
	push edx					;push edx to the stack
	push esi					;push esi to the stack
	push edi					;push edi to the stack

	mov eax, 1					;set return to true 
	mov esi, ptrString1			;save string1 address in esi
	mov edi, ptrString2			;save string2 address in edi
	
nextChar:						;label for next char
	mov bl, [esi]				;save string1 char into bl
	mov dl, [edi]				;save string2 char into dl

	cmp bl, 0					;check if end of string
	jne compare					;goto compare if not
	cmp dl, 0					;check if end of string
	jne compare					;goto compare if not 
	jmp endProc					;if end, goto endProc
	
compare:						;label for making char lowercase
	inc esi						;prep for next char 
	inc edi						;prep for next char
	
	cmp bl, 'a'					;make sure char is lowercase
	jb cont						;if so, continue
	cmp bl, 'z'					;make sure char is lowercase
	ja cont						;if so, continue
	sub bl, 32					;make lowercase to compare
	
cont:							;label for char for other string  to lowercase
	cmp dl, 'a'					;make sure char is lowercase
	jb cont2					;if so, continue
	cmp dl, 'z'					;make sure char is lowercase
	ja cont2					;if so, continue
	sub dl, 32					;make lowercase
	
cont2:							;label that compares chars
	cmp bl, dl					;compare
	je nextChar					;next cahr if equal
	mov eax, 0					;set return false if not equal

endProc:						;label for end procedure
	pop edi						;pop edi off the stack
	pop esi						;pop esi off the stack
	pop edx						;pop edx off the stack
	pop ebx						;pop ebx off the stack
	
	pop ebp						;pop ebp off the stack
	ret							;return to prev address
String_equalsIgnoreCase endp	;end of procedure

;== String_copy ====================================
; 
;===================================================
String_copy proc				;start of procedure
	ptrString equ [ebp + 8]		;get address of the string
	push ebp					;push ebp to the stack
	mov ebp, esp				;save esp into ebp
	
	push esi					;
	push edi
	push ebx
	
	mov esi, ptrString
	invoke memoryallocBailey, 1000
	mov edi, eax
	
nextChar:
	mov bh, [esi]
	mov bl, [edi]
	cmp bh, 0
	jne copy
	jmp endProc

copy:
	mov [edi], bh
	inc esi
	inc edi
	jmp nextChar
	
endProc:
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
String_copy endp

;== String_substring_1 =============================
; 
;===================================================
String_substring_1 proc	
	ptrString equ [ebp + 16]
	beginIndex equ [ebp + 12]
	endIndex equ [ebp + 8]
	
	push ebp
	mov ebp, esp
	
	push esi
	push edi
	push ebx
	push ecx
	push edx
	
	mov esi, ptrString
	invoke memoryallocBailey, 1000
	mov edi, eax
	
	mov edx, beginIndex
	mov ecx, endIndex
	
	cmp edx, ecx
	jle continue
	jmp endProc
	
	cmp edx, 0
	jge continue
	jmp endProc
	
	push esi
	call String_length
	add esp, 4
	
	cmp ecx, eax
	jl continue
	jmp endProc

continue:
	mov eax, edi
	sub ecx, edx
	
nextChar:
	mov bh, [esi + edx]
	mov bl, [edi]
	cmp ecx, 0
	jge copy
	jmp endProc

copy:
	mov [edi], bh
	dec ecx
	inc esi
	inc edi
	jmp nextChar
	
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
; 
;===================================================
String_substring_2 proc	
	ptrString equ [ebp + 12]
	beginIndex equ [ebp + 8]
	
	push ebp
	mov ebp, esp
	
	push esi
	push edi
	push ebx
	push ecx
	
	invoke memoryallocBailey, 1000
	mov edi, eax
	
	mov esi, ptrString
	mov ecx, beginIndex
	
	cmp ecx, 0
	jge nextChar
	jmp endProc
	
	push esi
	call String_length
	add esp, 4
	
	cmp ecx, eax
	mov eax, edi
	jl nextChar
	jmp endProc
	
nextChar:
	mov bh, [esi + ecx]
	mov bl, [edi]
	cmp bh, 0
	jge copy
	jmp endProc

copy:
	mov [edi], bh
	inc esi
	inc edi
	jmp nextChar
	
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
	
	push ebp
	mov ebp, esp
	
	push esi
	push ecx
	push edx
	
	mov edx, '0'
	mov esi, ptrString
	mov ecx, index
	add ecx, 1

	push ptrString
	call String_length
	add esp, 4
	
	cmp eax, ecx
	jl endProc
	cmp ecx, 0
	jl endProc
	
beginWhile:
	cmp ecx, 0
	je endProc
	mov dl, byte ptr [esi]
	inc esi
	dec ecx
	jmp beginWhile
	
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
	
	push ebp
	mov ebp, esp
	
	push esi
	push edi
	push ecx
	push ebx
	
	mov eax, 1
	mov esi, ptrString
	mov edi, ptrSubString
	mov ecx, index
	
nextChar:
	mov bh, [esi + ecx]
	mov bl, [edi]
	cmp bl, 0
	jne compare
	jmp endProc

compare:
	inc esi
	inc edi
	cmp bl, bh
	je nextChar
	mov eax, 0

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
	
	push ebp
	mov ebp, esp
	
	push esi
	push edi
	push ebx
	
	mov eax, 1
	mov esi, ptrString
	mov edi, ptrSubString
	
nextChar:
	mov bh, [esi]
	mov bl, [edi]
	cmp bl, 0
	jne compare
	jmp endProc

compare:
	inc esi
	inc edi
	cmp bl, bh
	je nextChar
	mov eax, 0

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
	
	push ebp
	mov ebp, esp
	
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	mov esi, ptrString
	mov edi, ptrSubString	
	
	push esi
	call String_length
	add esp, 4
	mov ecx, eax
	dec ecx
	
	push edi
	call String_length
	add esp, 4
	mov edx, eax
	dec edx
	
	cmp edx, ecx
	jl nextChar
	mov eax, 0
	jmp endProc
	
nextChar:	
	mov eax, 1
	mov bh, [esi + ecx]
	mov bl, [edi + edx]
	cmp edx, 0
	jge compare
	jmp endProc

compare:
	dec ecx
	dec edx
	cmp bl, bh
	je nextChar
	mov eax, 0

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




















