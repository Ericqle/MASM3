; Author: 		Eric Le
; Assignment:	MASM3
; Class:		CS3B
; Date:			April 19, 2018
; Description:

	include ..\Irvine\Irvine32.inc
	ascint32	PROTO Near32 stdcall, lpStringToConvert:dword  				;macro to convert ascII value to int value
	getstring	PROTO Near32 stdcall, lpStringToGet:dword, dlength:dword 	;macro to get user input
	putstring 	PROTO Near32 stdcall, lpStringToPrint:dword 				;macro to print a string to console
	
	extern String_equals@0:				proc
	extern String_equalsIgnoreCase@0:	proc
	extern String_copy@0:				proc
	extern String_substring_1@0:		proc
	extern String_substring_2@0:		proc
	extern String_charAt@0:				proc
	extern String_startsWith_1@0:		proc
	extern String_startsWith_2@0:		proc
	extern String_endsWith@0:			proc
	
	String_equals 			equ String_equals@0
	String_equalsIgnoreCase equ String_equalsIgnoreCase@0
	String_copy 			equ String_copy@0
	String_substring_1 		equ String_substring_1@0
	String_substring_2 		equ String_substring_2@0
	String_charAt 			equ String_charAt@0
	String_startsWith_1 	equ String_startsWith_1@0
	String_startsWith_2 	equ String_startsWith_2@0
	String_endsWith			equ String_endsWith@0
	
.data
	strCurrently		byte "  currently:",0
	strMenu1 			byte 10,13,"****************************************************",0
	strMenu2 			byte 10,13,"*                      MASM 3                      *",0
	strMenu3 			byte 10,13,"*--------------------------------------------------*",0
	strMenueChoice1 	byte 10,13,"* <1> Set string1                         currently:",0
	strMenueChoice2 	byte 10,13,"* <2> Set string2                         currently:",0
	strMenueChoice3 	byte 10,13,"* <3> String_length                       currently:",0
	strMenueChoice4 	byte 10,13,"* <4> String_equals                       currently:",0
	strMenueChoice5 	byte 10,13,"* <5> String_equalsIgnoreCas              currently:",0
	strMenueChoice6 	byte 10,13,"* <6> String_copy                         &",0
	strMenueChoice7 	byte 10,13,"* <7> String_substring_1                  &",0
	strMenueChoice8 	byte 10,13,"* <8> String_substring_2                  &",0
	strMenueChoice9 	byte 10,13,"* <9> String_charAt                       currently:",0
	strMenueChoice10	byte 10,13,"* <10> String_startsWith_1                currently:",0
	strMenueChoice11	byte 10,13,"* <11> String_startsWith_2                currently:",0
	strMenueChoice12	byte 10,13,"* <12> String_endsWith                    currently:",0
	strMenueChoice13	byte 10,13,"* <13> String_indexOf_1                   currently:",0
	strMenueChoice14	byte 10,13,"* <14> String_indexOf_2                   currently:",0
	strMenueChoice15	byte 10,13,"* <15> String_indexOf_3                   currently:",0
	strMenueChoice16	byte 10,13,"* <16> String_lastIndexOf_1               currently:",0
	strMenueChoice17	byte 10,13,"* <17> String_lastIndexOf_2               currently:",0
	strMenueChoice18	byte 10,13,"* <18> String_lastIndexOf_3               currently:",0
	strMenueChoice19	byte 10,13,"* <19> String_concat                      currently:",0
	strMenueChoice20	byte 10,13,"* <20> String_replace                     currently:",0
	strMenueChoice21	byte 10,13,"* <21> String_toLowerCase                 currently:",0
	strMenueChoice22	byte 10,13,"* <22> String_toUpperCase                 currently:",0
	strMenueChoice23	byte 10,13,"* <23> Quit                                        *",0
	strMenueChoice24	byte 10,13,"****************************************************",0
	
	strChoicePrompt			byte 10,13,"Choice (1-23): ",0
	strGetString1Prompt		byte 10,13,"Enter String 1: ",0
	strGetString2Prompt		byte 10,13,"Enter String 2: ",0
	strLengthPrompt			byte 10,13,"Which String Would you like the Lenght of (1) or (2): ",0
	strSubString1Prompt1	byte 10,13,"Enter the beginning index for the substring: ",0
	strSubString1Prompt2	byte 10,13,"Enter the ending index for the substring: ",0
	strSubString2Prompt 	byte 10,13,"Enter the staring index for the substring: ",0
	strCharAtPrompt			byte 10,13,"Enter the index of the wanted character: ",0
	strSW1Prompt			byte 10,13,"Enter the start index for the check: ",0 
	strNull	 byte "NULL",0
	strTrue	 byte "TRUE",0
	strFalse byte "FALSE",0
	strZeros byte "00000000",0
	strNewline 	byte 10,13,0
	
	string1 	byte 30 dup(?)
	string2 	byte 30 dup (?)
	subString 	byte 20 dup (?)
	
	status1			dword 0
	status2			dword 0
	status3 		dword 0
	status4 		dword 0
	status5 		dword 0
	
	statusAddress6 	dword 0
	status6 		dword 0
	
	statusAddress7 	dword 0
	status7 		dword 0
	
	statusAddress8  dword 0
	status8			dword 0
	
	status9			dword 0
	status10		dword 0
	status11		dword 0
	status12		dword 0
	
	strChoice	byte 10 dup(?)
	choice 		dword 0
	
	strLengthChoice		byte 10 dup(?)
	lengthChoice 		dword 0
	
	strSS1Begin	byte 10 dup(?)
	strSS1End	byte 10 dup(?)	
	strSS2Begin	byte 10 dup(?)
	strCharAtIndex 	byte 10 dup(?)	
	strSW1Index		byte 10 dup(?)
	
.code
main PROC
	call initialize
start:	
	mov eax, 0
	call Print_Menu
	invoke getString, 	addr strChoice, 10
	invoke ascint32, 	addr strChoice
	mov choice, eax
	
	cmp eax, 1
	je choice1
	cmp eax, 2
	je choice2
	cmp eax, 3
	je choice3
	cmp eax, 4
	je choice4
	cmp eax, 5
	je choice5
	cmp eax, 6
	je choice6
	cmp eax, 7
	je choice7
	cmp eax, 8
	je choice8
	cmp eax, 9
	je choice9
	cmp eax, 10
	je choice10
	cmp eax, 11
	je choice11
	cmp eax, 12
	je choice12
	cmp eax, 13
	je choice13
	cmp eax, 14
	je choice14
	cmp eax, 15
	je choice15
	cmp eax, 16
	je choice16
	cmp eax, 17
	je choice17
	cmp eax, 18
	je choice18
	cmp eax, 19
	je choice19
	cmp eax, 20
	je choice20
	cmp eax, 21
	je choice21
	cmp eax, 22
	je choice22
	cmp eax, 23
	je choice23
	jmp start

choice1:
	invoke putString, addr strGetString1Prompt
	invoke getString, addr string1, 29
	mov status1, offset string1
	jmp start
	
choice2:
	invoke putString, addr strGetString2Prompt
	invoke getString, addr string2, 29
	mov status2, offset string2
	jmp start
	
choice3:
	;String_length(string1:String):int 
	invoke putString, offset strLengthPrompt
	invoke getString, 	addr strChoice, 10
	invoke ascint32, 	addr strChoice
	cmp eax, 1
	jne continue3
	push offset string1
	jmp continue3_2
continue3:
	cmp eax, 2
	jne noChoice
	push offset string2
continue3_2:

	call String_length
	add esp, 4
	mov status3, eax
	
noChoice:
	jmp start
	
choice4:
	;String_equals(string1:String,string2:String):boolean 
	push offset string1
	push offset string2
	call String_equals
	add esp, 8
	
	cmp eax, 1
	mov status4, offset strFalse
	jne continue4
	mov status4, offset strTrue
continue4:
	jmp start

choice5:
	;String_equalsIgnoreCase(string1:String,string2:String):boolean 
	push offset string1
	push offset string2
	call String_equalsIgnoreCase
	add esp, 8
	
	cmp eax, 1
	mov status5, offset strFalse
	jne continue5
	mov status5, offset strTrue
continue5:
	jmp start

choice6:
	;String_copy(string1:String) :string
	push offset string1
	call String_copy
	add esp, 4
	
	mov status6, eax
	mov statusAddress6, eax
	jmp start

choice7:
	;String_substring_1(string:String ,begin Index:int,endIndex:int):string
	push offset string1
	
	invoke putString, addr strSubString1Prompt1
	invoke getString, addr strSS1Begin, 10
	invoke ascint32,  addr strSS1Begin
	push eax
	
	invoke putString, addr strSubString1Prompt2
	invoke getString, addr strSS1End, 10
	invoke ascint32,  addr strSS1End
	push eax
	
	call String_substring_1
	add esp, 12
	
	mov status7, eax
	mov statusAddress7, eax
	jmp start

choice8:
	;String_substring_2(string:String ,begin Index:int):string
	push offset string1
	
	invoke putString, addr strSubString2Prompt
	invoke getString, addr strSS2Begin, 10
	invoke ascint32,  addr strSS2Begin
	push eax
	
	call String_substring_2
	add esp, 8
	
	mov status8, eax
	mov statusAddress8, eax
	jmp start

choice9:
	;String_charAt(string1:String,position:int):char byte
	push offset string1
	
	invoke putString, addr strCharAtPrompt
	invoke getString, addr strCharAtIndex, 10
	invoke ascint32,  addr strCharAtIndex
	push eax
	
	call String_charAt
	add esp, 8
	
	mov status9, eax
	jmp start

choice10:
	;String_startsWith_1(string1:Stirng,subString:String,pos:int):boolean
	push offset string1
	push offset string2
	
	invoke putString, addr strSW1Prompt
	invoke getString, addr strSW1Index, 10
	invoke ascint32,  addr strSW1Index
	push eax

	call String_startsWith_1
	add esp, 12
	
	cmp eax, 1
	mov status10, offset strFalse
	jne continue10
	mov status10, offset strTrue
continue10:
	jmp start

choice11:
	;String_startsWith_2(string1:Stirng,subString:String):boolean
	push offset string1
	push offset string2
	call String_startsWith_2
	add esp, 8
	
	cmp eax, 1
	mov status11, offset strFalse
	jne continue11
	mov status11, offset strTrue
continue11:
	jmp start

choice12:
	;String_endsWith(string1:String,subString:String):boolean
	push offset string1
	push offset string2
	call String_endsWith
	add esp, 8
	
	cmp eax, 1
	mov status12, offset strFalse
	jne continue12
	mov status12, offset strTrue
continue12:
	jmp start

choice13:
	jmp start

choice14:
	jmp start
	
choice15:
	jmp start
	
choice16:
	jmp start
	
choice17:
	jmp start
	
choice18:
	jmp start
	
choice19:
	jmp start
	
choice20:
	jmp start
	
choice21:
	jmp start
	
choice22:
	jmp start
	
choice23:
	jmp endProc
	
endProc:
	exit
main ENDP
	
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

;== Print_Menu =====================================
; Print the menu and current status of the 
;	operations
;===================================================
Print_Menu proc
	push eax
	push edx
	invoke putString, addr strMenu1
	invoke putString, addr strMenu2
	invoke putString, addr strMenu3
	
	invoke putString, addr strMenueChoice1
	cmp status1, 0
	je continue1
	mov edx, status1
	call WriteString
	continue1:
	
	invoke putString, addr strMenueChoice2
	cmp status2, 0
	je continue2
	mov edx, status2
	call WriteString
	continue2:
	
	invoke putString, addr strMenueChoice3
	mov eax, status3
	call WriteDec
	
	invoke putString, addr strMenueChoice4
	cmp status4, 0
	je continue4
	mov edx, status4
	call WriteString
	continue4:
	
	invoke putString, addr strMenueChoice5
	cmp status5, 0
	je continue5
	mov edx, status5
	call WriteString
	continue5:
	
	invoke putString, addr strMenueChoice6
	cmp statusAddress6, 0
	je coninue6
	mov eax, statusAddress6
	call WriteDec
	jmp end6
coninue6:
	mov edx, offset strZeros
	call WriteString
end6:
	invoke putString, addr strCurrently
	mov edx, status6
	call WriteString
	
	invoke putString, addr strMenueChoice7
	cmp statusAddress7, 0
	je coninue7
	mov eax, statusAddress7
	call WriteDec
	jmp end7
coninue7:
	mov edx, offset strZeros
	call WriteString
end7:
	invoke putString, addr strCurrently
	mov edx, status7
	call WriteString
	
	invoke putString, addr strMenueChoice8
	cmp statusAddress6, 0
	je coninue8
	mov eax, statusAddress8
	call WriteDec
	jmp end8
coninue8:
	mov edx, offset strZeros
	call WriteString
end8:
	invoke putString, addr strCurrently
	mov edx, status8
	call WriteString
	
	invoke putString, addr strMenueChoice9
	cmp status9, 0
	je continue9
	mov eax, status9
	call WriteChar
	jmp end9
	continue9:
	mov edx, offset strNull
	call WriteString
	end9:
	
	invoke putString, addr strMenueChoice10
	cmp status10, 0
	je continue10
	mov edx, status10
	call WriteString
	continue10:
	
	invoke putString, addr strMenueChoice11
	cmp status11, 0
	je continue11
	mov edx, status11
	call WriteString
	continue11:
	
	invoke putString, addr strMenueChoice12
	cmp status12, 0
	je continue12
	mov edx, status12
	call WriteString
	continue12:
	
	invoke putString, addr strMenueChoice13
	invoke putString, addr strMenueChoice14
	invoke putString, addr strMenueChoice15
	invoke putString, addr strMenueChoice16
	invoke putString, addr strMenueChoice17
	invoke putString, addr strMenueChoice18
	invoke putString, addr strMenueChoice19
	invoke putString, addr strMenueChoice20
	invoke putString, addr strMenueChoice21
	invoke putString, addr strMenueChoice22
	invoke putString, addr strMenueChoice23
	invoke putString, addr strMenueChoice24
	invoke putString, addr strChoicePrompt
	pop edx
	pop eax
	ret
Print_Menu endp

;== Initialize =====================================
;
;===================================================
Initialize proc
	mov status1, offset strNull
	mov status2, offset strNull
	mov status3, 0
	mov status4, offset strFalse
	mov status5, offset strFalse
	mov status6, offset strNull
	mov statusAddress6, 0
	mov status7, offset strNull
	mov statusAddress7, 0
	mov status8,  offset strNull
	mov statusAddress8, 0
	mov status9, offset 0
	mov status10, offset strFalse
	mov status11, offset strFalse
	mov status12, offset strFalse

	ret
Initialize endp
end main





