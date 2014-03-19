; 作成者: 大竹 洋平
; 作成日: 2013.04.25
; 8021H番地から8060Hまで順に40H,3FH....,1と格納するプログラム.
;
		ORG	8000H		;RAM or ROM
		LD	A,40H		;Input Data
		LD	HL,8021H	;Start Address
LOOP:	LD	(HL),A		;Input RAM
		INC	HL			;Next Address
		DEC	A			;Next Input Data
		JP	NZ,LOOP		;if(A != 0) jump
		END