DATA    SEGMENT
        HENGX   DB 100 DUP('*')	
	TIS	DB "Please input the Tab to change$"	

;��һ���ӳ������ݶ�*******************************	
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
	INFOR   DB " Press any key to next...$"
;�ڶ����ӳ������ݶ�**********************************
	SINF1   DB "Please input a number:$"
        SINF2   DB "The result is:$"
        SIBUF   DB 7,0,6 DUP(?)
        SOBUF   DB 6 DUP(?)
        SNUM    DB 33H,36H,31H
;�������ӳ������ݶ�**********************************
	SINPUT	DB "INPUT(>1):$"
	STRING1	DB 33,0,32 DUP(?)
	STRING2	DB 32 DUP(?)
	STRING3	DB 32 DUP(?)
;���ĸ��ӳ������ݶ�**********************************
	INFO1     DB 'WELCOME YOU TO COME HERE!$'
	INFO2     DB 'this is a music program!$'
	INFO3     DB 'please select!$'
	INFO4     DB 'INPUT ERROR!$'
	INFO5     DB 'PLEASE INPUT AGAIN!$'
	MUSLIST   DB 'A MUSIC1'
	MUSLIST1  DB 'B MUSIC2'
        MUSLIST2  DB 'C MUSIC3'
        MUSLIST3  DB 'Q EXIT'
        
;����һ*********************************************************
MUS_FREG1 DW 330,294,262,294,3 DUP (330)
          DW 3 DUP (294),330,392,392
          DW 330,294,262,294,4 DUP (330)
          DW 294,294,330,294,262,-1
MUS_TIME1 DW 6 DUP (25),50
          DW 2 DUP (25,25,50)
          DW 12 DUP (25),100
;*********************************************************���ֶ�
MUS_FREG2 DW 330,392,330,294,330,392,330,294,330
          DW 330,392,330,294,262,294,330,392,294
          DW 262,262,220,196,196,220,262,294,332,262,-1
MUS_TIME2 DW 3 DUP(50),25,25,50,25,25,100
          DW 2 DUP(50,50,25,25),100
          DW 3 DUP(50,25,25),100
;********************************************************������
MUS_FREG3 DW 262,262,294,262,349
          DW 330,262,262,294,262
          DW 392,349,262,262,523
          DW 440,349,262,262,466
          DW 466,440,262,392,349,-1

MUS_TIME3 DW 50,50,100,100,100
          DW 100,100,50,50,100,100
          DW 100,100,100,50,50,100
          DW 100,100,100,100,100,50
          DW 50,100,100,100,100,100
	
	
DATA    ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA
START:  MOV     AX,DATA
        MOV     DS,AX
*****����һ����*****
SHOW      MACRO b
          LEA DX,b
          MOV AH,9
          INT 21H
          ENDM
;**********************���ֵ�ַ��
ADDRESS MACRO A,B
LEA SI,A
LEA BP,DS:B
ENDM
;��Ļ��ʾ��ʽ���ú�ָ��SETCRT
SETCRT  MACRO
        MOV     AH,0
        MOV     AL,2
        INT     10H
        ENDM
;������ָ��CLEAR
CLEAR   MACRO
        MOV     AH,06H
        MOV     AL,0
        INT     10H
        ENDM
;���ù���ָ��CURSOR
CURSOR  MACRO   ROW,CLM
	
        MOV     AH,02H
        MOV     BH,00H
        MOV     DH,ROW
        MOV     DL,CLM
	
        INT     10H
        ENDM
;������Ϣ��ʾ��ָ��DSTRING
DSTRING	MACRO	STRING
	PUSH	DX
	PUSH	AX
	MOV	DX,OFFSET STRING
	MOV	AH,09H
	INT	21H
	POP	AX
	POP	DX
	ENDM
	
	MOV     BX,OFFSET HENGX+80
        MOV     BYTE PTR[BX],'$'
	
CHONGX:	CALL	PINGM
	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB
	CMP	AL,27
	JE	TUIC
	JMP	CHONGX

TAB:    CALL	PINGM

	CALL	FIRST
TUIC:   SETCRT
	CLEAR
	MOV     AH,4CH
        INT     21H

PINGM	PROC	NEAR

	PUSHF
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX

        SETCRT
        CLEAR
        CURSOR  1,0		;���õ�һ�����߹��λ��
        DSTRING	HENGX		;�����һ������
	CURSOR	11,0		;���õڶ������߹��λ��
	DSTRING	HENGX		;����ڶ�������
	CURSOR	22,0		;���õ��������߹��λ��
	DSTRING	HENGX		;�������������
	CURSOR	23,0
	DSTRING	TIS
	MOV	CX,1
	
SHUX1:	CURSOR	CX,0		;�����һ������
	MOV	DL,'*'
	MOV	AH,2
	INT	21H
	INC	CX
	CMP	CX,22
	JNZ	SHUX1

	MOV	CX,1
SHUX2:	CURSOR	CX,40		;����ڶ�������
	MOV	DL,'*'
	MOV	AH,2
	INT	21H
	INC	CX
	CMP	CX,22
	JNZ	SHUX2

	MOV	CX,1
SHUX3:	CURSOR	CX,79		;�������������
	MOV	DL,'*'
	MOV	AH,2
	INT	21H
	INC	CX
	CMP	CX,22
	JNZ	SHUX3
	
	CURSOR	23,30
	
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	POPF
	RET
PINGM	ENDP
;��һ����Ļ�ϵ��ӳ���������ʾʱ�ں�ʱ��***************************************	
FIRST	PROC	NEAR	
	PUSHF
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	
TIMER1	MACRO 	REG, ADR	;���Ĵ����д�ŵĶ�������ת��ΪASCII�벢���ڴ���
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
		
	CURSOR	2,2		
	DSTRING BUF1
        CURSOR	6,2	
        DSTRING INFOR
LOOPR: 	MOV	AH, 2AH
        INT    	21H		;ȡ��ǰ����	
	PUSH	CX
        MOV     CH,AL
        TIMER1  CH,MSE 		;������ֵת��ΪASCII�벢�����MSE��Ԫ��
        MOV  	CH,DL 
        TIMER1 	CH,DAY		;������ת��ΪASCII�벢�����DAY��		
        POP	CX
        TIMER1  DH,MONTH	;���·�ת��ΪASCII�벢�����MONTH��        
	
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

	CURSOR 	3,3		;���ù��λ����ʾ��ǰʱ��			
	DSTRING	YEAR
	DSTRING	MONTH
        DSTRING	DAY
        DSTRING	MSE
     	

SHIJ:	CURSOR	4,2		
	DSTRING BUF2
LOOP2: 	MOV	AH, 2CH
        INT    	21H		
	PUSH	CX
        MOV     CH,DL
        TIMER1  CH,MSECOND 	;������ֵת��ΪASCII�벢�����MSECOND��
        MOV  	CH, DH 
        TIMER1 	CH, SECOND	;����ֵת��ΪASCII�벢�����SECOND��		
        POP	CX
       	TIMER1	CL,MINUTE	;����ֵת��ΪASCII�벢�����MINUTE��		
      	TIMER1	CH,HOUR		;��Сʱֵת��ΪASCII�벢�����HOUR��
	CURSOR  5,3		;���ù��λ����ʾ��ǰʱ��		
	DSTRING	HOUR
	DSTRING	MINUTE
        DSTRING	SECOND
        DSTRING	MSECOND
	
	MOV 	AH,0BH		
    	INT   	21h
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
TAB1:	CALL	SECONDS
TUIC1:	SETCRT
	CLEAR
	MOV	AH,4CH
	INT	21H
		
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	POPF
	RET
FIRST	ENDP		
;��һ���ӳ��������**********************************************************

;�ڶ����ӳ�����������1+2+...+n�ĺ�*****************************************
SECONDS	PROC	NEAR
	PUSHF
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX	
	CURSOR	3,42
	DSTRING	SINF1
	CURSOR	4,42
	MOV 	AH,0BH		
    	INT   	21h
	CMP	AL,9H
	JE	TAB2
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
	CURSOR	5,42	
      	DSTRING	SINF2
        DSTRING	SOBUF
SHIS:	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB2
	CMP	AL,27
	JE	TUIC2
	JMP	SHIS
TAB2:	CALL	THIRD
TUIC2:	SETCRT
	CLEAR
	MOV	AH,4CH
	INT	21H
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	POPF
	RET
SECONDS	ENDP
;�ڶ����ӳ������**************************************************
;�������ӳ�������һ���ַ����������******************************
THIRD	PROC	NEAR
	PUSHF
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	DI
	PUSH	SI
	CURSOR	14,3
	DSTRING	SINPUT
	CURSOR	15,3
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
	CURSOR	16,3
	DSTRING	SINF2
	DSTRING	STRING3
TSHIS:	MOV	AH,0
	INT	16H
	CMP	AL,9H
	JE	TAB3
	CMP	AL,27
	JE	TUIC3
	JMP	TSHIS
TAB3:	CALL	FOURTH
TUIC3:	SETCRT
	CLEAR
	MOV	AH,4CH
	INT	21H
	POP	SI
	POP	DI	
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	POPF
	RET
THIRD	ENDP
;�������ӳ������*******************************************
FOURTH	PROC	NEAR
	PUSHF
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
MUSEND:	CURSOR	14,43
          show INFO1
	CURSOR	15,43
          show INFO2
	CURSOR	16,43
          show INFO3
	CURSOR	17,43
          show MUSLIST
	CURSOR	18,43
	SHOW	MUSLIST1
	CURSOR	19,43
	SHOW	MUSLIST2
	CURSOR	20,43
	SHOW	MUSLIST3
	MOV	AH,1
	INT	21H
	CMP	AL,'A'
	JZ	MUSA
       
	JMP	MUSEND
MUSA:	ADDRESS	MUS_FREG1,MUS_TIME1
	CALL	MUSIC
	MOV 	AH,1	
    	INT   	21h
      	CMP   	AL,'Q'
        JZ	TAB4
	JMP	MUSEND
TAB4:	MOV	AH,0
	INT	16H
	CMP	AH,9H
	JZ	FTAB
	CMP	AL,27
	JE	TUIC4
	JMP	TAB4
	
FTAB:	CALL	FIRST	
	
TUIC4:   CLEAR 
	 MOV AH,4CH
          INT 21H
;******************************************����
GENSOUND PROC NEAR
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          PUSH DI
          MOV AL,0B6H
          OUT 43H,AL
          MOV DX,12H
          MOV AX,348ch
          DIV DI
          OUT 42H,AL
          MOV AL,AH
          OUT 42H,AL
          IN AL,61H
          MOV AH,AL
          OR AL,3
          OUT 61H,AL

WAIT1:    MOV CX,3314
          call waitf
DELAY1:   DEC BX
          JNZ WAIT1
          MOV AL,AH
          OUT 61H,AL
          POP DI
          POP DX
          POP CX
          POP BX
          POP AX
          RET
GENSOUND ENDP
;********************************************
waitf proc near
      push ax
waitf1:
      in al,61h
      and al,10h
      cmp al,ah
      je waitf1
      mov ah,al
      loop waitf1
      pop ax
      ret
waitf endp

;*********************************************
MUSIC   PROC NEAR
          PUSH DS
          SUB AX,AX
          PUSH AX
FREG:     MOV DI,[SI]
          CMP DI,-1
          JE END_MUS
          MOV BX,DS:[BP]
          CALL GENSOUND
          ADD SI,2
          ADD BP,2
          JMP FREG
END_MUS:
          RET
MUSIC    ENDP
;************************************************clear!!!

clear1 proc near
      push ax
      push bx
      push cx
      push dx
      mov  ah,6
      mov al,0
      mov ch,14
      mov cl,43
      mov dh,14
      mov dl,79
      mov bh,7
      int 10h
      pop dx
      pop cx
      pop bx
      pop ax
      ret
clear1 endp

	POP	DX
	POP	CX
	POP	BX
	POP	AX
	POPF
	RET
FOURTH	ENDP
CODE    ENDS
        END     START