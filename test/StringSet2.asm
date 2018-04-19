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
	char equ [ebp + 8]		;get char
	
	push ebp
	mov ebp, esp
	
	push esi
	push ebx
	
	mov esi, ptrString
	mov eax, 0
	
nextChar:
	mov bl, [esi] 
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
	pop ebx 
	pop esi 
	pop ebp
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
end

