ORG 0000H 

	MOV P1,#00H 
	MOV P0,#00H 
	CLR P1.0
	SETB P1.1
	
	MOV R4,#00H
	MOV B,#0AH
	
	MOV A,#38H
	ACALL COMWRT
	ACALL DELAY
	MOV A,#0EH
	ACALL COMWRT
	ACALL DELAY
	MOV A,#01H
	ACALL COMWRT
	ACALL DELAY
	MOV A,#06H
	ACALL COMWRT
	ACALL DELAY
	MOV R2,#0FFH
	
	MAIN:MOV TMOD,#20H 
	
	MOV TL1,#0C5H 
	MOV TH1,#0C5H
	
	MOV A,#00H
	SETB P1.0 
	ACALL DELAY10 
	CLR P1.0 
	HERE: JNB P1.1,HERE 

	BACK: SETB TR1 
	HERE1: JNB TF1,HERE1 
	CLR TR1 
	CLR TF1 
	INC A
	JB P1.1,BACK 
	
	MOV R4,A
	
	ACALL DISPLAY 
	here2:SJMP main
	
	DISPLAY:	
	MOV A,R4
	MOV B,#0AH
	DIV AB
	MOV 42H,B
	MOV B,#0AH
	DIV AB
	MOV 41H,B
	MOV B,#0AH
	DIV AB
	MOV 40H,B
	
	MOV A,#84H
	ACALL COMWRT
	ACALL DELAY
	
	MOV A,40H
	ADD A,#30H
	MOV 50H,A
	ACALL DATAWRT
	ACALL DELAY
	
	MOV A,41H
	ADD A,#30H
	MOV 51H,A
	ACALL DATAWRT
	ACALL DELAY
	
	MOV A,42H
	ADD A,#30H
	MOV 52H,A
	ACALL DATAWRT
	ACALL DELAY
	
	ret
	
	
	DELAY10: MOV R6,#02H // 10uS delay
	LABEL1: DJNZ R6,LABEL1
	RET
	
	COMWRT: MOV P2,A
		CLR P3.7
		CLR P3.6
		SETB P3.5
		ACALL DELAY
		CLR P3.5
		RET
		
	DATAWRT: MOV P2,A
		SETB P3.7
		CLR P3.6
		SETB P3.5
		ACALL DELAY
		CLR P3.5
		RET
		
	DELAY: MOV R7,#0FFH
	LABEL2: DJNZ R7,LABEL2
	RET
	
	
END