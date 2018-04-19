	include ..\Irvine\Irvine32.inc
	memoryallocBailey proto near32 stdcall, dsize:dword
	
	extern String_length@0:proc
	String_length equ String_length@0
	
	.data
	
	.code
;== String_indexOf_1================================
; 
;===================================================
String_indexOf_1 proc
	ptrString equ [ebp + 12]	;get address of string
	char equ [ebp + 8]			;get char
	
	push ebp		;push ebp onto the stack
	mov ebp, esp	;move the stack pointer to the base pointer
	
	push esi		;push esi onto the stack
	push ebx		;push ebx onto the stack
	
	mov esi, ptrString	;move the start of ptrString into esi
	mov eax, 0			;move 0 into eax
	
nextChar:
	mov bl, [esi] 		;compare the string element to the character
	mov bh, char		;move char into bh
	cmp bl, 0			;compare the bl to 0 (null terminator)
	jne compare			;if not equal, jump to compare
	jmp endProc			;else, jump to endProc
	
compare:
	inc esi			;increment esi
	cmp bh, bl		;compare the character to the string
	je endProc		;if the character and string are the same, jump to endProc
	inc eax			;increment eax
	jmp nextChar	;jump to the nextChar
	

endProc:
	pop ebx 	;pop ebx off the stack
	pop esi 	;pop esi off the stack
	pop ebp		;pop ebp off the stack
	ret
String_indexOf_1 endp

;== String_indexOf_2================================
; 
;===================================================
String_indexOf_2 proc
	ptrString equ [ebp + 16]	;get address of string
	char equ [ebp + 12]			;get char
	index equ [ebp + 8]			;get index
	
	push ebp
	mov ebp, esp
	
	push esi
	push ebx
	push ecx
	
	mov esi, ptrString
	mov ecx, index
	mov eax, ecx

nextChar:
	mov bl, [esi + ecx] 
	mov bh, char
	cmp bl, 0
	jne compare
	jmp endProc
	
compare:
	inc esi
	cmp bh, bl
	je endProc
	inc eax
	jmp nextChar
	

endProc:
	pop ecx
	pop ebx 
	pop esi 
	pop ebp
	ret
String_indexOf_2 endp

;== String_indexOf_3================================
; 
;===================================================
String_indexOf_3 proc
	ptrString1 equ [ebp + 12]	
	ptrString2 equ [ebp + 8]
	
	push ebp
	mov ebp, esp
	
	push edi
	push esi
	push ebx
	
	mov esi, ptrString1
	mov edi, ptrString2
	mov eax, 0

nextChar:
	mov bh, [esi]
	mov bl, [edi]
	cmp bh, 0
	jne compare
	jmp endProc
	
compare:
	inc esi
	cmp bh, bl
	inc eax
	je strCompare
	jmp nextChar
	
strCompare:
	mov ecx, esi			;save string 1 pointer to esi
	mov edx, edi			;save string 2 pointer to esi
	
nextChar2:						;label for next char in string
	mov bh, [ecx]				;save char of string1 in dl
	mov bl, [edx]				;save char of string2 in bl
	cmp bl, 0				;check if end of string
	jne compare2					;goto compare label if not 0
	jmp endProc				;goto end procedure if 0

compare2:						;label to compare the chars
	inc esi						;prep for next char
	inc edi						;prep for next char
	cmp bh, bl					;compare the chars
	je nextChar2				;goto next char if true
	jmp	nextChar				;return value of false if not equal


endProc:
	pop ebx 
	pop esi 
	pop edi
	pop ebp
	ret
String_indexOf_3 endp

;== String_lastIndexOf_1============================
; 
;===================================================
String_lastIndexOf_1 proc
	ptrString equ [ebp + 12]	;get address of string
	char equ [ebp + 8]		;get char
	
	push ebp
	mov ebp, esp
	
	push esi
	push ebx
	
	mov esi, ptrString
	
	push esi
	call String_length
	add esp, 4
	mov ecx, eax
	
	
nextChar:
	mov bh, [esi + ecx] 
	mov bl, char
	cmp ecx, 0
	jne compare
	jmp endProc
	
compare:
	dec ecx
	cmp bh, bl
	je endProc
	dec eax
	jmp nextChar
	

endProc:
	pop ebx 
	pop esi 
	pop ebp
	ret
String_lastIndexOf_1 endp

;== String_lastIndexOf_2============================
; 
;===================================================
String_lastIndexOf_2 proc
	ptrString equ [ebp + 16]	
	char equ [ebp + 12]
	index equ [ebp + 8]
	
	push ebp
	mov ebp, esp
	
	push esi
	push ebx
	push ecx
	
	mov esi, ptrString
	mov ecx, index

	mov eax, ecx
	
nextChar:
	mov bh, [esi + ecx] 
	mov bl, char
	cmp ecx, 0
	jne compare
	jmp endProc
	
compare:
	dec ecx
	cmp bh, bl
	je endProc
	dec eax
	jmp nextChar
	

endProc:
	pop ecx
	pop ebx 
	pop esi 
	pop ebp
	ret
String_lastIndexOf_2 endp


;== String_toLowerCase============================
; 
;=================================================

	String_toLowerCase proc
	ptrString equ [ebp + 8]
	
	push ebp		;push the base pointer
	mov	 ebp, esp	;move the stack pointer to the base pointer
	
	push esi
	push ebx
	
	mov esi, ptrString	;move the start of the address into esi

	
compare:
	mov bl, [esi]		;stores start of string address
	
	cmp bl, 0			;compare first element to 0
	je endProc			;if equal exit
	
	cmp bl, 'A'			;compare the address ptr to 'a'
	jb	toLower			;if greater, jump to toLower
		
	cmp bl, 'Z'			;compare the address ptr to 'z'
	ja	toLower			;if less, jump to toLower
	
	add bl, 32
	
	
toLower:
	;sub bl, 32		;convert to uppercase
	mov [esi], bl		;store the value into eax
	inc esi			;inc ecx to traverse string
	
	
	jmp compare		;jump to compare to repeat steps


endProc:		;Pop all registers
	mov eax, ptrString
	
	pop ebx
	pop esi
	pop ebp
	ret



String_toLowerCase endp






String_toUpperCase proc

	ptrString equ [ebp + 8]
	
	push ebp		;push the base pointer
	mov	 ebp, esp	;move the stack pointer to the base pointer
	
	push esi
	push ebx
	
	mov esi, ptrString	;move the start of the address into esi

	
compare:
	mov bl, [esi]		;stores start of string address
	
	cmp bl, 0			;compare first element to 0
	je endProc			;if equal exit
	
	cmp bl, 'a'			;compare the address ptr to 'a'
	jb	toUpper			;if greater, jump to toUpper
		
	cmp bl, 'z'			;compare the address ptr to 'z'
	ja	toUpper			;if less, jump to toUpper
	
	sub bl, 32
	
	
toUpper:
	;sub bl, 32		;convert to uppercase
	mov [esi], bl		;store the value into eax
	inc esi			;inc ecx to traverse string
	
	
	jmp compare		;jump to compare to repeat steps


endProc:		;Pop all registers
	mov eax, ptrString
	
	pop ebx
	pop esi
	pop ebp
	ret

String_toUpperCase endp



end



