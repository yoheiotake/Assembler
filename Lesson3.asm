; 作成者: 大竹 洋平
; 作成日: 2013.05.16
; DAコンバータチェック用下降カウンタプログラム
;
CH0		EQU		81H		;ch.0 用出力ポートアドレス
CH1		EQU		82H		;ch.1 用出力ポートアドレス
CWR		EQU		83H		;CWRのアドレス
		ORG		8000H	
		LD		A,80H	;コントロールワード
		OUT		(CWR),A
LOOP:	LD		A,0FFH	;FFでは文字として扱われる 11111111Bでも可能
LOOP1:	LD		B,A
		OUT		(CH0),A	;TP6で出力の確認
		AND		0C0H	;論理積により,上位2Bitのみ保持
		OUT		(CH1),A	;TP7で出力の確認
		LD		A,B
		DEC		A
		JP		NZ,LOOP1
		JP		LOOP
		END