;=====================================================================================
; Author: 		Eric Le, Sabrina Dang
; Assignment:	MASM3
; Class:		CS3B
; Date:			April 19, 2018
; Description:	
;	This Program will implement two sets of string functions using
;	the c-calling convention. It will display a menue and the 
;	selected menue choice will then perform the given string 
;	function. It will aslo be updated at real time to show the
;	results of the functions
;=====================================================================================


	; External libraries and macros
	include ..\Irvine\Irvine32.inc
	ascint32	PROTO Near32 stdcall, lpStringToConvert:dword  				;macro to convert ascII value to int value
	getstring	PROTO Near32 stdcall, lpStringToGet:dword, dlength:dword 	;macro to get user input
	putstring 	PROTO Near32 stdcall, lpStringToPrint:dword 				;macro to print a string to console
	
	; External procedures
	extern String_equals@0:				proc	;get external procedure String_equals
	extern String_equalsIgnoreCase@0:	proc	;get external procedure String_equalsIgnoreCase
	extern String_copy@0:				proc	;get external procedure String_copy
	extern String_substring_1@0:		proc	;get external procedure String_substring_1
	extern String_substring_2@0:		proc	;get external procedure String_substring_2
	extern String_charAt@0:				proc	;get external procedure String_charAt
	extern String_startsWith_1@0:		proc	;get external procedure String_startsWitch_1
	extern String_startsWith_2@0:		proc	;get external procedure String_startsWith_2
	extern String_endsWith@0:			proc	;get external procedure String_endsWith
	extern String_indexOf_1@0:			proc	;get external procedure String_indexOf_1
	extern String_indexOf_2@0:			proc	;get external procedure String_indexOf_2
	extern String_indexOf_3@0:			proc	;get external procedure String_indexOf_3
	extern String_lastIndexOf_1@0:		proc	;get external procedure String_lastIndexOf_1
	extern String_lastIndexOf_2@0:		proc	;get external procedure String_lastIndexOf_2
	extern String_lastIndexOf_3@0:		proc	;get external procedure String_lastIndexOf_3
	extern String_concat@0:				proc	;get external procedure String_concat
	extern String_replace@0:			proc	;get external procedure String_replace
	extern String_toLowerCase@0:		proc	;get external procedure String_toLowerCase
	extern String_toUpperCase@0:		proc	;get external procedure String_toUpperCase
	
	; External Procedure Redefinitions
	String_equals 			equ String_equals@0				
	String_equalsIgnoreCase equ String_equalsIgnoreCase@0	
	String_copy 			equ String_copy@0				
	String_substring_1 		equ String_substring_1@0		
	String_substring_2 		equ String_substring_2@0		
	String_charAt 			equ String_charAt@0				
	String_startsWith_1 	equ String_startsWith_1@0		
	String_startsWith_2 	equ String_startsWith_2@0		
	String_endsWith			equ String_endsWith@0		
	String_indexOf_1		equ String_indexOf_1@0
	String_indexOf_2		equ String_indexOf_2@0
	String_indexOf_3		equ String_indexOf_3@0
	String_lastIndexOf_1	equ String_lastIndexOf_1@0
	String_lastIndexOf_2	equ String_lastIndexOf_2@0
	String_lastIndexOf_3	equ String_lastIndexOf_3@0
	String_concat			equ String_concat@0
	String_replace			equ String_replace@0
	String_toLowerCase		equ String_toLowerCase@0
	String_toUpperCase		equ String_toUpperCase@0
	
.data
	; All Menue Strings
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
	
	; All Menue Prompts
	strChoicePrompt			byte 10,13,"Choice (1-23): ",0											
	strGetString1Prompt		byte 10,13,"Enter String 1: ",0											
	strGetString2Prompt		byte 10,13,"Enter String 2: ",0											
	strLengthPrompt			byte 10,13,"Which String Would you like the Lenght of (1) or (2): ",0	
	strSubString1Prompt1	byte 10,13,"Enter the beginning index for the substring: ",0			
	strSubString1Prompt2	byte 10,13,"Enter the ending index for the substring: ",0				
	strSubString2Prompt 	byte 10,13,"Enter the staring index for the substring: ",0				
	strCharAtPrompt			byte 10,13,"Enter the index of the wanted character: ",0				
	strSW1Prompt			byte 10,13,"Enter the start index for the check: ",0 				
	
	strIndexOf1Prompt 		byte 10,13,"Enter the char to find the first instance of: ",0
	strIndexOf2Prompt1		byte 10,13,"Enter the char to find the first instance of: ",0
	strIndexOf2Prompt2		byte 10,13,"Enter the starting index: ",0
	strLIndexOf1Prompt 		byte 10,13,"Enter the char to find the last instance of: ",0
	strLIndexOf2Prompt1		byte 10,13,"Enter the char to find the last instance of: ",0
	strLIndexOf2Prompt2		byte 10,13,"Enter the starting index: ",0
	strReplacePrompt1		byte 10,13,"Which string would you like to replace the characters of: ",0
	strReplacePrompt2		byte 10,13,"Letter to replace: ",0
	strReplacePrompt3		byte 10,13,"Letter to insert: ",0
	strToLowerPrompt		byte 10,13,"Which string would you like to make lowercase: ",0
	strToHigherPrompt		byte 10,13,"Which string would you like to make uppercase: ",0

	; Additional Ouputs
	strNull	 byte "NULL",0		;string to rep null
	strTrue	 byte "TRUE",0		;string to rep true
	strFalse byte "FALSE",0		;string to rep false
	strZeros byte "00000000",0	;string to rep blank address
	strNewline 	byte 10,13,0	;sting to rep newLine
	
	; Strings to hold string1 and string2
	string1 	byte 30 dup(?)	;string to hold string1
	string2 	byte 30 dup (?)	;string to hols string2
	
	; Sataus for Menue Items
	status1			dword 0	;contains address of string1		
	status2			dword 0	;contains address of string2
	status3 		dword 0	;contains int value of lenght
	status4 		dword 0	;contains address of string rep true or false
	status5 		dword 0 ;contains address of string rep true or false
	statusAddress6 	dword 0	;contians address of string
	status6 		dword 0 ;contains address of string rep of null or copy sring
	statusAddress7 	dword 0 ;contians address of string
	status7 		dword 0 ;contains address of string rep of null or subSring
	statusAddress8  dword 0 ;contians address of string
	status8			dword 0	;contains address of string rep of null or subSring
	status9			dword 0	;contains char value or address of string rep of null
	status10		dword 0	;contains address of string rep true or false
	status11		dword 0	;contains address of string rep true or false
	status12		dword 0	;contains address of string rep true or false
	
	status13	 	dword 0	;contains int of string indexof 1
	status14	 	dword 0 ;contains int of string indexof 2
	status15	 	dword 0 ;contains int of string indexof 3
	status16	 	dword 0 ;contains int of string last indexof 1
	status17	 	dword 0 ;contains int of string last indexof 2
	status18	 	dword 0 ;contains int of string last indexof 3
	status19	 	dword 0 ;contains address of string concat 
	status20	 	dword 0 ;contains address of string replace
	status21	 	dword 0	;contains address of string toLower
	status22	 	dword 0 ;contains address of string toUpper
	
	; Items to Hold Prompt Decisions
	strChoice	byte 10 dup(?)			;item to hold str menue choice
	strLengthChoice		byte 10 dup(?)	;itme to hold str length choice
	lengthChoice 		dword 0			;item to hold int length choice
	strSS1Begin	byte 10 dup(?)			;item to hold ss1 start index 
	strSS1End	byte 10 dup(?)			;item to hold ss1 end index
	strSS2Begin	byte 10 dup(?)			;item to hold ss2 begin index
	strCharAtIndex 	byte 10 dup(?)		;item to hold chaAt index
	strSW1Index		byte 10 dup(?)		;itme to hold sw1 index
	
	strIO1Choice	byte 10 dup(?)		;item to hold index of choice
	strIO2Choice1	byte 10 dup(?)		;item to hold index of2 choice1
	strIO2Choice2	byte 10 dup(?)		;item to hold index of2 choice2
	strLIO1Choice	byte 10 dup(?)		;item to hold last index choice
	strLIO2Choice1	byte 10 dup(?)		;item to hold last index2 choice1
	strLIO2Choice2	byte 10 dup(?)		;item to hold last index2 choice2
	strReplaceChoice byte 10 dup(?)		;item to hold replace choice
	strReplaceChar1 byte 10 dup(?)		;item to hold replace char1
	strReplaceChar2 byte 10 dup(?)		;item to hold replace char2
	strLowerCaseChoice byte 10 dup(?)	;item to hold lowercase choice
	strUpperCaseChoice byte 10 dup(?)	;item to hols uppercase choice
	
.code
main PROC
	call initialize		;initialize default values for menue
start:	
	mov eax, 0								;reset eax
	call Print_Menu							;print the menue
	invoke getString, 	addr strChoice, 10	;get choice from user
	invoke ascint32, 	addr strChoice		;convert choice to int choice
	
	; Compare and find the instruction to go to based on menue choice
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

;------- Get String1 ---------------------------------------
;	Prompt for and recieve input for string1
;-----------------------------------------------------------
choice1:
	invoke putString, addr strGetString1Prompt
	invoke getString, addr string1, 29
	mov status1, offset string1
	jmp start

;------- Get String2 ---------------------------------------
;	Prompt for and recieve input for string
;-----------------------------------------------------------
choice2:
	invoke putString, addr strGetString2Prompt
	invoke getString, addr string2, 29
	mov status2, offset string2
	jmp start
	
;------- Call String_length --------------------------------
;	call String_length using c-calling convention
;-----------------------------------------------------------
choice3:
	; Prompt for choice to find lenght of string1 or string2
	invoke putString, offset strLengthPrompt
	invoke getString, 	addr strChoice, 10
	invoke ascint32, 	addr strChoice
	
	; Use string1
	cmp eax, 1
	jne continue3
	push offset string1
	jmp continue3_2
	
	; Use string2
continue3:
	cmp eax, 2
	jne noChoice
	push offset string2
	
	; String_length(string1:String):int 
continue3_2:
	call String_length
	add esp, 4
	
	; Update status for menu
	mov status3, eax
	
noChoice:
	jmp start
	
;------- Call String_equals --------------------------------
;	call String_equals using c-calling convention
;-----------------------------------------------------------
choice4:
	; String_equals(string1:String,string2:String):boolean 
	push offset string1
	push offset string2
	call String_equals
	add esp, 8
	
	; Update status for the menu
	cmp eax, 1
	mov status4, offset strFalse
	jne continue4
	mov status4, offset strTrue
continue4:
	jmp start

;------- Call String_equalsIgnoreCase ----------------------
;	call String_equalsIgnoreCase using c-calling convention
;-----------------------------------------------------------
choice5:
	; String_equalsIgnoreCase(string1:String,string2:String):boolean 
	push offset string1
	push offset string2
	call String_equalsIgnoreCase
	add esp, 8
	
	; Update status for the menu
	cmp eax, 1
	mov status5, offset strFalse
	jne continue5
	mov status5, offset strTrue
continue5:
	jmp start

;------- Call String_copy ---------------------------------
;	call String_copy using c-calling convention
;-----------------------------------------------------------
choice6:
	; String_copy(string1:String) :string
	push offset string1
	call String_copy
	add esp, 4
	
	; Update status for menu
	mov status6, eax
	mov statusAddress6, eax
	jmp start

;------- Call String_substring_1 ---------------------------
;	call String_substring_1 using c-calling convention
;-----------------------------------------------------------
choice7:
	push offset string1
	
	; Prompt for and recieve beginning index
	invoke putString, addr strSubString1Prompt1
	invoke getString, addr strSS1Begin, 10
	invoke ascint32,  addr strSS1Begin
	push eax
	
	; Prompt for and recieve ending index
	invoke putString, addr strSubString1Prompt2
	invoke getString, addr strSS1End, 10
	invoke ascint32,  addr strSS1End
	push eax
	
	; String_substring_1(string:String ,begin Index:int,endIndex:int):string
	call String_substring_1
	add esp, 12
	
	; Update status for menu
	mov status7, eax
	mov statusAddress7, eax
	jmp start

;------- Call String_substring_2 ---------------------------
;	call String_substring_2 using c-calling convention
;-----------------------------------------------------------
choice8:
	push offset string1
	
	; Prompt for beginning index
	invoke putString, addr strSubString2Prompt
	invoke getString, addr strSS2Begin, 10
	invoke ascint32,  addr strSS2Begin
	push eax
	
	; String_substring_2(string:String ,begin Index:int):string
	call String_substring_2
	add esp, 8
	
	; Update status for menu
	mov status8, eax
	mov statusAddress8, eax
	jmp start

;------- Call String_charAt --------------------------------
;	call String_charAt using c-calling convention
;-----------------------------------------------------------
choice9:
	push offset string1
	
	; Prompt and recieve index for wanted char
	invoke putString, addr strCharAtPrompt
	invoke getString, addr strCharAtIndex, 10
	invoke ascint32,  addr strCharAtIndex
	push eax
	
	; String_charAt(string1:String,position:int):char byte
	call String_charAt
	add esp, 8
	
	; Update status for menu
	mov status9, eax
	jmp start

;------- Call String_startsWith_1 --------------------------
;	call String_startsWith_1 using c-calling convention
;-----------------------------------------------------------
choice10:
	push offset string1
	push offset string2
	
	; Prompt for and recieve beginning index 
	invoke putString, addr strSW1Prompt
	invoke getString, addr strSW1Index, 10
	invoke ascint32,  addr strSW1Index
	push eax
	
	; String_startsWith_1(string1:Stirng,subString:String,pos:int):boolean
	call String_startsWith_1
	add esp, 12
	
	; Update status for menu
	cmp eax, 1
	mov status10, offset strFalse
	jne continue10
	mov status10, offset strTrue
continue10:
	jmp start

;------- Call String_startsWith_ ---------------------------
;	call String_startsWith_2 using c-calling convention
;-----------------------------------------------------------
choice11:
	; String_startsWith_2(string1:Stirng,subString:String):boolean
	push offset string1
	push offset string2
	call String_startsWith_2
	add esp, 8
	
	; Update status for menu 
	cmp eax, 1
	mov status11, offset strFalse
	jne continue11
	mov status11, offset strTrue
continue11:
	jmp start
	
;------- Call String_endsWith ------------------------------
;	call String_endsWith using c-calling convention
;-----------------------------------------------------------
choice12:
	;String_endsWith(string1:String,subString:String):boolean
	push offset string1
	push offset string2
	call String_endsWith
	add esp, 8
	
	; Update status for menu
	cmp eax, 1
	mov status12, offset strFalse
	jne continue12
	mov status12, offset strTrue
continue12:
	jmp start

;------- Call String_indexOf_1 ----------------------------
;	call String_indexOf_1 using c-calling convention
;-----------------------------------------------------------
choice13:
	mov eax, 0
	push offset string1
	
	; Prompt and Get input
	invoke putString, addr strIndexOf1Prompt
	invoke getString, addr strIO1Choice,1
	mov al, byte ptr strIO1Choice
	push eax 
	
	; String_indexOf_1(string1:String,ch:char):int  
	call String_indexOf_1
	add esp, 8
	
	; update status
	mov status13, eax
	jmp start

;------- Call String_indexOf_2 -----------------------------
;	call String_indexOf_2 using c-calling convention
;-----------------------------------------------------------
choice14:
	mov eax, 0
	push offset string1
	
	; Prompt and Get input
	invoke putString, addr strIndexOf2Prompt1
	invoke getString, addr strIO2Choice1,1
	mov al, byte ptr strIO2Choice1
	push eax
	
	; Prompt and Get input
	invoke putString, addr strIndexOf2Prompt2
	invoke getString, addr strIO2Choice2,1
	invoke ascint32, addr strIO2Choice2
	push eax 
	
	; String_indexOf_2(string1:String,ch:char,index:int):int  
	call String_indexOf_2
	add esp, 12
	
	; update status
	mov status14, eax
	jmp start
	
;------- Call String_indexOf_3 ------------------------------
;	call String_indexOf_3 using c-calling convention
;-----------------------------------------------------------
choice15:
	push offset string1
	push offset string2
	call String_indexOf_3
	add esp, 8
	
	mov status15, eax
	jmp start
	
;------- Call String_lastIndexOf_1 ----------------------------
;	call String_indexOf_1 using c-calling convention
;-----------------------------------------------------------
choice16:
	mov eax, 0
	push offset string1
	
	; Prompt and Get input
	invoke putString, addr strLIndexOf1Prompt
	invoke getString, addr strLIO1Choice,1
	mov al, byte ptr strLIO1Choice
	push eax 
	
	; String_lastIndexOf_1(string1:String,ch:char):int  
	call String_lastIndexOf_1
	add esp, 8
	
	; update status
	mov status16, eax
	jmp start
	
;------- Call String_lastIndexOf_2 -------------------------
;	call String_indexOf_2 using c-calling convention
;-----------------------------------------------------------
choice17:
	mov eax, 0
	push offset string1
	
	; Prompt and Get input
	invoke putString, addr strLIndexOf2Prompt1
	invoke getString, addr strLIO2Choice1,1
	mov al, byte ptr strLIO2Choice1
	push eax
	
	; Prompt and Get input
	invoke putString, addr strLIndexOf2Prompt2
	invoke getString, addr strLIO2Choice2,1
	invoke ascint32, addr strLIO2Choice2
	push eax 
	
	; String_lastIndexOf_2(string1:String,ch:char,index:int):int  
	call String_lastIndexOf_2
	add esp, 12
	
	; update status
	mov status17, eax
	jmp start
	
;------- Call String_lastIndexOf_3 -------------------------
;	call String_indexOf_3 using c-calling convention
;-----------------------------------------------------------
choice18:
	push offset string1
	push offset string2
	call String_lastIndexOf_3
	add esp, 8
	
	mov status18, eax
	jmp start

;------- Call String_concat --------------------------------
;	call String_concat using c-calling convention
;-----------------------------------------------------------
choice19:
	push offset string1
	push offset string2
	call String_concat
	add esp, 8
	
	mov status19, eax
	jmp start
	
;------- Call String_replace -------------------------------
;	call String_replace using c-calling convention
;-----------------------------------------------------------
choice20:
	; Prompt for choice to use string1 or string2
	invoke putString, offset strReplacePrompt1
	invoke getString, 	addr strReplaceChoice, 1
	invoke ascint32, 	addr strReplaceChoice
	
	; Use string1
	cmp eax, 1
	jne continue20
	push offset string1
	jmp continue20_2
	
	; Use string2
continue20:
	cmp eax, 2
	jne noChoice20
	push offset string2
	
	; Prompt for chars and Call
continue20_2:
	invoke putString, offset strReplacePrompt2
	invoke getString, 	addr strReplaceChar1, 1
	mov al, byte ptr strReplaceChar1
	push eax 
	
	invoke putString, offset strReplacePrompt3
	invoke getString, 	addr strReplaceChar2, 1
	mov al, byte ptr strReplaceChar2
	push eax 
	
	call String_replace
	add esp, 12
	
	; Update status for menu
	mov status20, eax
	
noChoice20:
	jmp start

;------- Call String_toLowerCase -------------------------
;	call String_toLowerCase using c-calling convention
;-----------------------------------------------------------	
choice21:
	; Prompt to make string1 or string2 lowercase
	invoke putString, offset strToLowerPrompt
	invoke getString, 	addr strLowerCaseChoice, 1
	invoke ascint32, 	addr strLowerCaseChoice
	
	; Use string1
	cmp eax, 1
	jne continue21
	push offset string1
	jmp continue21_2
	
	; Use string2
continue21:
	cmp eax, 2
	jne noChoice21
	push offset string2
	
	; Call String_toLowerCase
continue21_2:
	call String_toLowerCase
	add esp, 4
	
	; Update status for menu
	mov status21, eax
	
noChoice21:
	jmp start

;------- Call String_toUpperCase -------------------------
;	call String_toUpperCase using c-calling convention
;-----------------------------------------------------------	
choice22:
	; Prompt to make string1 or string2 Uppercase
	invoke putString, offset strToHigherPrompt
	invoke getString, 	addr strUpperCaseChoice, 1
	invoke ascint32, 	addr strUpperCaseChoice
	
	; Use string1
	cmp eax, 1
	jne continue22
	push offset string1
	jmp continue22_2
	
	; Use string2
continue22:
	cmp eax, 2
	jne noChoice22
	push offset string2
	
	; Call String_uppercase
continue22_2:
	call String_toUpperCase
	add esp, 4
	
	; Update status for menu
	mov status22, eax
	
noChoice22:
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
	ptrString equ [ebp + 8]	;get address of string
	push ebp
	mov ebp, esp
	push esi
	mov eax, 0
	mov esi, ptrString
beginWhile:
	cmp byte ptr [esi], 0	;check for end of string
	je endWhile
	inc esi					;inc eax and esi until esi 
	inc eax					; points to null terminater
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
	push eax	;used for brief settings
	push edx	;used for brief settings
	
	;-- Print start of menu---------------
	;-------------------------------------
	invoke putString, addr strMenu1
	invoke putString, addr strMenu2
	invoke putString, addr strMenu3
	
	;-- Print menu for String1 --------------------
	;----------------------------------------------
	invoke putString, addr strMenueChoice1
	cmp status1, 0
	je continue1
	mov edx, status1
	call WriteString
	continue1:
	
	;-- Print menu for String2 -------------------
	;---------------------------------------------
	invoke putString, addr strMenueChoice2
	cmp status2, 0
	je continue2
	mov edx, status2
	call WriteString
	continue2:
	
	;-- Print menu for String Length---------------
	;----------------------------------------------
	invoke putString, addr strMenueChoice3
	mov eax, status3
	call WriteDec
	
	;-- Print menu for String Equals---------------
	;----------------------------------------------
	invoke putString, addr strMenueChoice4
	cmp status4, 0
	je continue4
	mov edx, status4
	call WriteString
	continue4:
	
	;-- Print menu for String EqualsIgnorCase -----
	;----------------------------------------------
	invoke putString, addr strMenueChoice5
	cmp status5, 0
	je continue5
	mov edx, status5
	call WriteString
	continue5:
	
	;-- Print menu for String Copy ----------------
	;----------------------------------------------
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

	;-- Print menu for String SubString_1 ---------
	;----------------------------------------------
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

	;-- Print menu for String SubString_1 ---------
	;----------------------------------------------
	invoke putString, addr strMenueChoice8
	cmp statusAddress8, 0
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

	;-- Print menu for String CharAt --------------
	;----------------------------------------------
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
	
	;-- Print menu for String StartsWith_1 --------
	;----------------------------------------------
	invoke putString, addr strMenueChoice10
	cmp status10, 0
	je continue10
	mov edx, status10
	call WriteString
	continue10:
	
	;-- Print menu for String StartsWith_2 --------
	;----------------------------------------------
	invoke putString, addr strMenueChoice11
	cmp status11, 0
	je continue11
	mov edx, status11
	call WriteString
	continue11:
	
	;-- Print menu for String EndsWith ------------
	;----------------------------------------------
	invoke putString, addr strMenueChoice12
	cmp status12, 0
	je continue12
	mov edx, status12
	call WriteString
	continue12:
	
	;-- Print menu for String IndexOf 1 -----------
	;----------------------------------------------
	invoke putString, addr strMenueChoice13
	mov eax, status13
	call WriteInt
	
	;-- Print menu for String IndexOf 2 -----------
	;----------------------------------------------
	invoke putString, addr strMenueChoice14
	mov eax, status14
	call WriteInt
	
	;-- Print menu for String IndexOf 3 -----------
	;----------------------------------------------
	invoke putString, addr strMenueChoice15
	mov eax, status15
	call WriteInt
	
	;-- Print menu for String LastIndexOf 1 -------
	;----------------------------------------------
	invoke putString, addr strMenueChoice16
	mov eax, status16
	call WriteInt
	
	;-- Print menu for String LastIndexOf 2 -------
	;----------------------------------------------
	invoke putString, addr strMenueChoice17
	mov eax, status17
	call WriteInt
	
	;-- Print menu for String LastIndexOf 3 -------
	;----------------------------------------------
	invoke putString, addr strMenueChoice18
	mov eax, status18
	call WriteInt
	
	;-- Print menu for String Concatenate ---------
	;----------------------------------------------
	invoke putString, addr strMenueChoice19
	mov edx, status19
	call WriteString
	
	;-- Print menu for String Replace -------------
	;----------------------------------------------
	invoke putString, addr strMenueChoice20
	mov edx, status20
	call WriteString
	
	;-- Print menu for String To Lowercase --------
	;----------------------------------------------
	invoke putString, addr strMenueChoice21
	mov edx, status21
	call WriteString
	
	;-- Print menu for String To Uppercase --------
	;----------------------------------------------
	invoke putString, addr strMenueChoice22
	mov edx, status22
	call WriteString
	
	invoke putString, addr strMenueChoice23
	invoke putString, addr strMenueChoice24
	invoke putString, addr strChoicePrompt
	pop edx
	pop eax
	ret
Print_Menu endp

;== Initialize =====================================
; Initialize all statuses to show NULL, TRUE, FALSE
;	or 0
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
	mov status13, -1
	mov status14, -1
	mov status15, -1
	mov status16, -1
	mov status17, -1
	mov status18, -1
	mov status19, offset strNull
	mov status20, offset strNull
	mov status21, offset strNull
	mov status22, offset strNull

	ret
Initialize endp
end main





