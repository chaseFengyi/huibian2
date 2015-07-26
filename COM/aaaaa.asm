DATA    SEGMENT
        HENGX   DB 100 DUP('*')	
	TIS1	DB "Please input the Tab to change$"	
	TIS2	DB "Welcome!That is meau$"
	TIS3	DB "Press the Tab to move next$"
	TIS4	DB "Press the Esc to exit$"
	TIS5	DB "The first is display time of now$"
	TIS6	DB "The second is 1+2+...+n=sum$"
	TIS7	DB "The third is display string$"
	TIS8	DB "FIRST$"
	TIS9	DB "Display the time$"

;第一个子程序数据段*******************************	
	BUF1	DB "Today is:$"
	BUF2	DB "Current time is:$"
	YEAR    DB 20H,20H,20H,20H,' year ','$'
	MONTH   DB 20H,20H,' month ','$'
	DAY	DB 20H,20H,' day ','$'
	HOUR  	DB 20H,20H,':','$'
	MINUTE	DB 20H,20H,':','$'
	SECOND	DB 20H,20H,':','$'
	MSECOND DB 20H,20H,'$'
	MSE	DB 20H,20H,' week ','$'
	INFOR   DB " Press any key to exit...$"
;第二个子程序数据段**********************************
	SINF1   DB "Please input a number:$"
        SINF2   DB "The result is:$"
        SIBUF   DB 7,0,6 DUP(?)
        SOBUF   DB 6 DUP(?)
        SNUM    DB 33H,36H,31H
;第三个子程序数据段**********************************
	INPUT	DB "INPUT(>1):$"
	STRING1	DB 33,0,32 DUP(?)
	STRING2	DB 32 DUP(?)
	STRING3	DB 32 DUP(?)
;第四个子程序数据段**********************************
	FINFOR1 DB "Please Press Any Key to input a letter:$"      
     	FINFOR2 DB "You input a lowercase letter! $"      
     	FINFOR3 DB "You input a Uppercase letter! $"      
     	FINFOR4 DB "You input a Digit! $"      
     	FINFOR5 DB "You input Other letter! $" 
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA
START:  MOV     AX,DATA
        MOV     DS,AX
;屏幕显示方式设置宏指令SETCRT
SETCRT  MACRO
        MOV     AH,0
        MOV     AL,2
        INT     10H
        ENDM
;清屏宏指令CLEAR
CLEAR   MACRO
        MOV     AH,06H
        MOV     AL,0
        INT     10H
        ENDM
;设置光标宏指令CURSOR
CURSOR  MACRO   ROW,CLM
	
        MOV     AH,02H
        MOV     BH,00H
        MOV     DH,ROW
        MOV     DL,CLM
	
        INT     10H
        ENDM
;设置信息显示宏指令DSTRING
DSTRING	MACRO	STRING
	PUSH	DX
	PUSH	AX
	MOV	DX,OFFSET STRING
	MOV	AH,09H
	INT	21H
	POP	AX
	POP	DX
	ENDM
	
CHONGX:	CALL	PINGM
	CURSOR	3,68
	DSTRING	TIS8
	CURSOR	10,62
	DSTRING	TIS9
	CURSOR	3,18
	DSTRING	TIS2
	CURSOR	7,3
	DSTRING	TIS3
	CURSOR	8,3
	DSTRING	TIS4
	CURSOR	9,3
	DSTRING	TIS5
	CURSOR	10,3
	DSTRING	TIS6
	CURSOR	11,3
	DSTRING	TIS7
	
	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB
	CMP	AL,27
	JE	TUIC
	JMP	CHONGX

TAB:    CALL	PINGM

	CALL	FIRST
TUIC:   MOV     AH,4CH
        INT     21H

PINGM	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX

	MOV     BX,OFFSET HENGX+80
        MOV     BYTE PTR[BX],'$'
        SETCRT
        CLEAR
	CURSOR	1,0
	DSTRING	HENGX
        CURSOR  5,0		;设置第一条横线光标位置
        DSTRING	HENGX		;输出第一条横线
	CURSOR	22,0
	DSTRING	HENGX
	
	MOV	CX,1
	
SHUX1:	CURSOR	CX,0		;输出第一条竖线
	MOV	DL,'*'
	MOV	AH,2
	INT	21H
	INC	CX
	CMP	CX,22
	JNZ	SHUX1



	MOV	CX,1
SHUX3:	CURSOR	CX,60		;输出第三条竖线
	MOV	DL,'*'
	MOV	AH,2
	INT	21H
	INC	CX
	CMP	CX,22
	JNZ	SHUX3
	
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
PINGM	ENDP
;第一个屏幕上的子程序，用来显示时期和时间***************************************	
FIRST	PROC	NEAR	
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	
TIMER1	MACRO 	REG, ADR	;将寄存器中存放的二进制数转换为ASCII码并存内存中
        PUSH	AX
        PUSH  	BX
        LEA  	SI, ADR
        MOV  	AL, REG
        MOV  	AH, 00
        MOV   	BL, 10
        DIV   	BL
        ADD  	AL, 30H
        MOV     [SI], AL         
        ADD  	AH, 30H
        INC   	SI
        MOV   	[SI], AH
        POP   	BX
        POP   	AX
        ENDM
		
	CURSOR	7,3		
	DSTRING BUF1
        CURSOR	11,3	
        DSTRING INFOR
LOOPR: 	MOV	AH, 2AH
        INT    	21H		;取当前日期	
	PUSH	CX
        MOV     CH,AL
        TIMER1  CH,MSE 		;将星期值转换为ASCII码并存放在MSE单元中
        MOV  	CH,DL 
        TIMER1 	CH,DAY		;将几号转换为ASCII码并存放在DAY中		
        POP	CX
        TIMER1  DH,MONTH	;将月份转换为ASCII码并存放在MONTH中        
	
	MOV 	AX,CX
	MOV 	CX,10
        LEA	BX,YEAR+4
LOOP1:
	MOV 	DX,0
	DIV 	CX
	ADD 	DL,30H
	DEC 	BX
	MOV	[BX],DL
	OR 	AX,AX
	JNZ 	LOOP1	

	CURSOR 	8,4		;设置光标位置显示当前时期			
	DSTRING	YEAR
	DSTRING	MONTH
        DSTRING	DAY
        DSTRING	MSE
     	

SHIJ:	CURSOR	9,3		
	DSTRING BUF2
LOOP2: 	MOV	AH, 2CH
        INT    	21H		
	PUSH	CX
        MOV     CH,DL
        TIMER1  CH,MSECOND 	;将毫秒值转换为ASCII码并存放在MSECOND中
        MOV  	CH, DH 
        TIMER1 	CH, SECOND	;将秒值转换为ASCII码并存放在SECOND中		
        POP	CX
       	TIMER1	CL,MINUTE	;将分值转换为ASCII码并存放在MINUTE中		
      	TIMER1	CH,HOUR		;将小时值转换为ASCII码并存放在HOUR中
	CURSOR  10,4		;设置光标位置显示当前时间		
	DSTRING	HOUR
	DSTRING	MINUTE
        DSTRING	SECOND
        DSTRING	MSECOND
	
	MOV 	AH,0BH		
    	INT   	21H
      	CMP   	AL,00H
        JNZ    	EXITT		
     	JMP   	LOOP2	
EXITT:	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB1
	CMP	AL,27
	JE	TUIC1
	JMP	EXITT
TAB1:	CALL	PINGM
	CALL	SECONDS
TUIC1:	MOV	AH,4CH
	INT	21H
	
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
FIRST	ENDP		
;第一个子程序结束处**********************************************************

;第二个子程序，用来计算1+2+...+n的和*****************************************
SECONDS	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX	
	CURSOR	7,3
	DSTRING	SINF1
	CURSOR	8,4
	MOV     DX,OFFSET SIBUF
        MOV     AH,0AH
        INT     21H
	MOV     CL,SIBUF+1
        MOV     CH,0
       
        
        MOV     SI,OFFSET SIBUF+2
        MOV     AX,0
SAGAIN: MOV     DX,10
        MUL     DX
        AND     BYTE PTR[SI],0FH
        ADD     AL,[SI]
        ADC     AH,0
        INC     SI
        LOOP    SAGAIN

        MOV     CX,AX
        MOV     AX,0
        MOV     BX,1
SLOOP2: ADD     AX,BX
        INC     BX
        LOOP    SLOOP2
        MOV     BX,OFFSET SOBUF+5
        MOV     BYTE PTR[BX],'$'
        MOV     CX,10
SLOOP1: MOV     DX,0
        DIV     CX
        ADD     DL,30H
        DEC     BX
        MOV     [BX],DL
        OR      AX,AX
        JNZ     SLOOP1
	CURSOR	9,3	
      	DSTRING	SINF2
        DSTRING	SOBUF
SHIS:	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB2
	CMP	AL,27
	JE	TUIC2
	JMP	SHIS
TAB2:	CALL	PINGM
	CALL	THIRD
TUIC2:	MOV	AH,4CH
	INT	21H
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
SECONDS	ENDP
;第二个子程序结束**************************************************
;第三个子程序，输入一行字符，逆序输出******************************
THIRD	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX

	CURSOR	7,3
	DSTRING	INPUT
	CURSOR	8,3
	MOV	DX,OFFSET STRING1
	MOV	AH,10
	INT	21H
	MOV 	CL,STRING1+1 
	MOV 	CH,0 
	MOV 	SI,OFFSET STRING1 
	ADD 	SI,CX 
	INC 	SI 
	MOV	DI,OFFSET STRING3
TAGAIN: 
	MOV 	AL,[SI] 
	MOV	[DI],AL 
	DEC 	SI 

	INC	DI
	LOOP 	TAGAIN
	MOV	BYTE PTR [DI],'$'
	CURSOR	9,3
	DSTRING	SINF2
	DSTRING	STRING3
TSHIS:	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB3
	CMP	AL,27
	JE	TUIC3
	JMP	TSHIS
TAB3:	CALL	PINGM
	CALL	FOURTH
TUIC3:	MOV	AH,4CH
	INT	21H	
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
THIRD	ENDP
;第三个子程序结束*******************************************
FOURTH	PROC	NEAR
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	CURSOR	7,3
	DSTRING	FINFOR1   
        MOV 	AH,01H       
        INT	21H        
        CMP  	AL,'0' 
        JB   	OTHER 
        CMP  	AL,'9' 
        JBE  	DIGIT  
        CMP  	AL,'A' 
        JB   	OTHER  
        CMP  	AL,'Z' 
        JBE  	UPPER 
        CMP  	AL,'a'  
        JB   	OTHER   
        CMP  	AL,'z' 
        JBE  	LOWER 
        JMP  	PEND 
LOWER:  
	CURSOR	8,3                              
       	DSTRING	FINFOR2
        JMP 	PEND                     
UPPER:  
	CURSOR	8,3                         
       	DSTRING FINFOR3
        JMP PEND 
DIGIT:  
	CURSOR	8,3                       
        DSTRING	FINFOR4
        JMP PEND 
OTHER:    
	CURSOR	8,3                   
        DSTRING	FINFOR5        
PEND:   MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB4
	CMP	AL,27
	JE	TUIC4
	JMP	PEND
TAB4:	CALL	PINGM
	CALL	FIRST	
TUIC4:  MOV 	AH,4CH
        INT 	21H
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
FOURTH	ENDP
CODE    ENDS
        END     START