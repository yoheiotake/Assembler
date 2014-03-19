;作成者：大竹 洋平
;作成日：2013.05.30
;内部電圧のAD変換プログラム
;
;
SIGNAL	EQU	1EH         ;コントロール信号.　コンパレータのアドレス
DA		EQU	81H         ;DAコンバータのアドレス
ILED	EQU	80H         ;内部LEDのアドレス
ELED	EQU	84H         ;外部LEDのアドレス
ICWR	EQU	83H         ;内部LEDとDAコンバータのCWRのアドレス
ECWR	EQU	87H         ;外部LEDのCWRのアドレス
;
		ORG	8000H
		LD	A,80H       ;外部LEDのCW
		OUT	(ECWR),A
		LD	A,80H       ;内部LEDとDAコンバータのCW
		OUT	(ICWR),A
LOOP:	LD	A,0         ;カウンタの初期化
		LD	B,A         ;カウンタ値の待避
LOOP2:	OUT	(DA),A
		IN	A,(SIGNAL)	;コントロール信号をロード
		BIT	2,A         ;AD変換の終了判定
		JP	Z,EXIT      ;AD変換が終了した場合ジャンプ
		INC	B           ;カウンタの更新
		LD	A,B         ;DAコンバータに出力するためアキュムレータにロード
		JP	LOOP2
EXIT:	LD	A,B
		OUT	(ILED),A
		OUT	(ELED),A
		JP	LOOP
;
		END
