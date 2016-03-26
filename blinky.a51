; ************************************************************************
; Source file		: blinky.a51
; Project		: 
; Version		:
; Date			: 
; Student		: 
; University		: SPbPU

; Chip type		: 80C515
; Clock frequency	: 12 MHz
; Memory model		: Small
; Internal RAM size	: 256
; External RAM size	: 0
; Data Stack size	: 48
; Cross assembler	: ASEM-51 v 1.1
; ************************************************************************

$NOMOD51				; ��������� ����������� ���������� ������� x51-�����������, ����� ����� ���������� ����
;$NOPAGING				; ��������� �� ��������
$INCLUDE (80C515.MCU)	; ���������� ���� ���������� �������

;T0COUNT EQU	50000		; ������������ ���-�� ������ ��� �������� 
;-------------------------------------------------------------------------
; ���������������� ����������

BUTTON	BIT	P1.0
LED 	BIT P1.1

;-------------------------------------------------------------------------
; �������������� ���������� ������ ������ ��� ���������� � ����
DSEG	at 	020h		
Counter:		DS	1		 
Switch:		DS	1 		 		 
//DisplayPhase:	DS	1 	 
//Digit0: 	DS	1 		
//Digit1:    	DS	1 	 

stackArea:	DS	48		; ���� �� ������ 020h + 6 = 026h

CSEG					; ������� ����
;-------------------------------------------------------------------------
; ������� �������� ����������

	ORG	RESET			
	jmp	Init  		
	reti

;-------------------------------------------------------------------------
; ������������� �� � �������

Init:
	mov Counter, #00h;
	mov Switch, #00h;
	CAll MainLoop

MainLoop:

	CALL ledDelay
	CALL countIterationIfPressed			
	CALL checkIfReleased


   cpl LED

jmp MainLoop


ledDelay:
	
		mov	r0,#03h
	outerCicle:
		mov	r1,#00h
	innerCicle:
		mov r2,#00h
		djnz r2, $ 
		djnz r1,innerCicle
		djnz r0,outerCicle

ret

countIterationIfPressed:
	
	jb BUTTON,checkIfReleased
	inc Counter
	ret
		
	checkIfReleased:
	mov R3, Counter
	cjne R3, #00h, L1 
	 
	CALL determineLonginessOfPress

	L1:

ret

determineLonginessOfPress:
	mov A, R3
	sub A, #05h



ret


LongPressHandler:
   mov Switch, #02h
ret

ShortPressHandler:
   mov Switch, #01h
ret

END


