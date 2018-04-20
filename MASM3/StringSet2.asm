;=====================================================================================
; Author: 		Sabrina Dang
; Assignment:	StringSet2 (MASM3)
; Class:		CS3B
; Date:			April 19, 2018
; Description:	
;	This file contains the original implementaions of the second assigned
;	set of string functions
;=====================================================================================
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
	
	push esi
	push edi
	push ebx
	push ecx
	push edx
	
	mov eax, 0
	mov esi, ptrString1
	mov edi, ptrString2

nextChar:
	mov bh, [esi] 
	mov bl, [edi]
	cmp bh, 0
	jne compare
	jmp endProc
	
compare:
	cmp bh, bl
	je strequal
	inc eax
	inc esi
	jmp nextChar

strequal:
	mov ecx, esi
	mov edx, edi
	
nextChar2:
	mov bh, [ecx]
	mov bl, [edx]
	cmp bl, 0
	jne compare2
	inc esi
	jmp endProc
	
compare2:
	inc ecx
	inc edx
	cmp bh, bl
	je nextChar2
	inc esi
	jmp nextChar
	
endProc:
	pop edx
	pop ecx
	pop ebx 
	pop edi
	pop esi 
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

;== String_lastIndexOf_3============================
; 
;===================================================
String_lastIndexOf_3 proc
	ptrString   EQU [ebp + 12]    
	subString EQU [ebp + 8]    

	push ebp               
	mov ebp,esp            
  
    sub esp, 12             
	strLength1 EQU [ebp - 4]     
	strLength2 EQU [ebp - 8]    
	found_index EQU [ebp - 12]

    push ptrString            
    call String_length       
    add esp, 4             
    
    add eax, 1              
    mov strLength1, eax     
    
    
    push subString         
    call String_length       
    add esp, 4            
    
    mov strLength2, eax     
    
    mov eax, strLength1     
    sub eax, strLength2      
    mov strLength1, eax      
    
    mov ecx, 0            
    mov eax, 0              
    mov found_index, eax   
    
nextStart:   
    cmp ecx, strLength1     
    jg endProc                 
    cmp eax , 1            
    je continue                
    
    push ptrString            
    push subString          
    push ecx                
    call startsWith       
    add esp, 12            
    
    inc ecx               
    
    jmp nextStart            
    
continue:
    mov found_index, ecx   
    mov eax, 0             
    jmp nextStart             
    
endProc:
    
    mov eax, found_index    
    sub eax, 1             
    
    add esp, 12            
    pop ebp                
    
    ret
String_lastIndexOf_3 endp


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


;== String_toUpperCase============================
; 
;=================================================
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

;== String_replace ===============================
; 
;=================================================
String_replace proc
	ptrString equ [ebp + 16]	
	char1 equ [ebp + 12]
	char2 equ [ebp + 8]
	
	push ebp
	mov ebp, esp
	
	push esi
	push ebx
	push edx
	push edi
	
	mov esi, ptrString
	mov bh, char1
	mov bl, char2
	
nextChar:
	mov dl, [esi] 
	cmp dl, 0
	jne compare
	jmp endProc
	
compare:
	cmp bh, [esi]
	je change
	inc esi
	jmp nextChar

change: 
	mov [esi], bl
	inc esi
	jmp nextChar
	
endProc:
	mov eax, ptrString
	pop edi
	pop edx
	pop ebx
	pop esi 
	pop ebp
	ret
String_replace endp

;== String_concat ================================
; 
;=================================================
String_concat proc				
	ptrString1 equ [ebp + 12]
	ptrString2 equ [ebp + 8]
	
	push ebp					
	mov ebp, esp
	
	push esi
	push edi
	push edx
	push ebx
	
	mov esi, ptrString1
	mov edx, ptrString2
	
	invoke memoryallocBailey, 1000
	mov edi, eax
	
nextChar:
	mov bh, [esi]
	mov bl, [edi]
	cmp bh, 0
	jne copy
	jmp nextChar2

copy:
	mov [edi], bh
	inc esi
	inc edi
	jmp nextChar
	
nextChar2:
	mov bh, [edx]
	mov bl, [edi]
	cmp bh, 0
	jne copy2
	jmp endProc

copy2:
	mov [edi], bh
	inc edx
	inc edi
	jmp nextChar2
	
endProc:
	pop ebx
	pop edx
	pop edi
	pop esi
	pop ebp
	ret
String_concat endp

;== HelperFunction ===============================
; For String_lastIndexOf_3
;=================================================
startsWith proc
    ptrString   equ [ebp + 16]         
    strprefix   equ [ebp + 12]      
    index       equ [ebp + 8]     
    
	push ebp                       
    mov ebp, esp                   
    
    push ebx                       
    push ecx                        
    push esi                        
    push edi                        
    
    sub esp, 4                     
    strlength1 equ [ebp - 4]    
    
    push strprefix              
    call String_length               
    add esp, 4                     
    
    mov strLength1, eax             
    
    mov esi, ptrString               
    add esi, index                 
    mov edi, strprefix              
    
    mov eax, 1                      
    mov ecx, strLength1             
l1:                                
    mov bh, [esi]
    mov bl, [edi]                   
    .if bh != bl || bh == 0       
        mov eax, 0                
        jmp l2                    
    .endif
    inc esi                    
    inc edi                       
    loop l1                         
    
l2: add esp, 4                    
    
    pop edi                         
    pop esi                         
    pop ecx                         
    pop ebx                         
    
    pop ebp                        
    ret                             
startsWith endp
end


