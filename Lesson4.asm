;作成者：大竹 洋平
;作成日：2013.05.23
;イニシャルＹ.Ｏを表示するプログラム
;
;
CH0		EQU		81H         ; DA,CH.0, X座標
CH1		EQU		82H         ; DA.CH.1, Y座標
;
		ORG		8000H
		LD		A,80H       ;コントロールワード80Hをアキュムレータにロード
		OUT		(83H),A     ;CWRにコントロールワードを出力
LOOP:	LD		B,64        ;原点のX座標
		LD		C,128       ;原点のY座標
		LD		A,B
		OUT		(CH0),A     ;原点のX座標を出力
		LD		A,C
		OUT		(CH1),A     ;原点のY座標を出力
		LD		A,41        ;関数RRRをループする回数
		CALL	RRR         ;Yの右上の斜線を表示する関数
		LD		A,41        ;関数LLLをループする回数
		CALL	LLL         ;Yの左上の斜線を表示する関数
		LD		A,41        ;関数VERをループする回数
		CALL	VER         ;Yの縦線を表示する関数
		CALL	CIRCLE      ;Oを表示する関数
		JP		LOOP        ;出力を繰り返し,イニシャルを表示し続ける
		END

;Yの右上の斜線を表示する関数
RRR:	DEC		A		;ループカウンタの更新
		JP		Z,NEXT	;ゼロになった場合NEXTを実行し,ループを終了する
		LD		D,A		;ループカウンタをDレジスタに待避
		LD		A,B		;X座標の演算のために原点のX座標をロード
		ADD		A,D		;右上の斜線のX座標は原点よりも右にあるので加算
		OUT		(CH0),A	;X座標の出力
		LD		A,C		;Y座標の演算のために原点のY座標をロード
		ADD		A,D		;右上の斜線のY座標は原点よりも上にあるので加算
		OUT		(CH1),A	;Y座標の出力
		LD		A,D		;ループカウンタの更新をするためにロード
		JP		RRR		;関数RRRを繰り返し実行する
NEXT:	RET				;ループカウンタが0の時に実行され,関数を終了する
;
;Yの左上の斜線を表示する関数
LLL:	DEC		A
		JP		Z,NEXT
		LD		D,A
		LD		A,B
		SUB		D		;左上の斜線のX座標は原点よりも左にあるので減算
		OUT		(CH0),A
		LD		A,C
		ADD		A,D		;左上の斜線のY座標は原点よりも上にあるので加算
		OUT		(CH1),A
		LD		A,D
		JP		LLL
;
;Yの縦線を表示する関数
VER:	DEC		A
		JP		Z,NEXT
		LD		D,A
		LD		A,B
		OUT		(CH0),A	;縦線のX座標は原点のX座標と同じ.そのまま出力
		LD		A,C
		SUB		D		;縦線のY座標は原点のY座標よりも下にあるので減算
		OUT		(CH1),A
		LD		A,D
		JP		VER
;
;Oを表示する関数
CIRCLE:	LD		C,88	;”O”の原点のY座標.”Y”のY座標の最小値と同じ
		LD		B,64	;”O”の原点のX座標.最終的に128がX座標になる
		LD		A,B		;上でBに128をロードする場合は不要な処理
		ADD		A,64	;上でBに128をロードする場合は不要な処理
		LD		B,A		;上でBに128をロードする場合は不要な処理
		LD		IX,CH0D	;原点からのX座標の差分をロード
		LD		IY,CH1D	;原点からのY座標の差分をロード
LP:		LD		A,(IX)	;X座標の演算のためにロード
		CP		255		;終了判定
		JP		Z,NEXT
		ADD		A,B		;Oの原点のX座標とsinの値を加算し,X座標を求める
		OUT		(CH0),A	;X座標の出力
		LD		A,(IY)	;Y座標の演算のためにロード
		ADD		A,C		;Oの原点のY座標とcosの値を加算し,Y座標を求める
		OUT		(CH1),A	;Y座標の出力
		INC		IX		;X座標に加算する値を更新
		INC		IY		;Y座標に加算する値を更新
		JP		LP
		JP		NEXT
;
;sin(x)
CH0D:	DEFB		40
		DEFB		46
		DEFB		52
		DEFB		58
		DEFB		64
		DEFB		68
		DEFB		72
		DEFB		76
		DEFB		78
		DEFB		80
		DEFB		80
		DEFB		80
		DEFB		78
		DEFB		76
		DEFB		72
		DEFB		68
		DEFB		64
		DEFB		58
		DEFB		52
		DEFB		46
		DEFB		40
		DEFB		34
		DEFB		28
		DEFB		22
		DEFB		16
		DEFB		12
		DEFB		8
		DEFB		4
		DEFB		2
		DEFB		0
		DEFB		0
		DEFB		0
		DEFB		2
		DEFB		4
		DEFB		8
		DEFB		12
		DEFB		16
		DEFB		22
		DEFB		28
		DEFB		34
		DEFB		255
;
;cos(x)
CH1D:	DEFB		80
		DEFB		80
		DEFB		78
		DEFB		76
		DEFB		72
		DEFB		68
		DEFB		64
		DEFB		58
		DEFB		52
		DEFB		46
		DEFB		40
		DEFB		34
		DEFB		28
		DEFB		22
		DEFB		16
		DEFB		12
		DEFB		8
		DEFB		4
		DEFB		2
		DEFB		0
		DEFB		0
		DEFB		0
		DEFB		2
		DEFB		4
		DEFB		8
		DEFB		12
		DEFB		16
		DEFB		22
		DEFB		28
		DEFB		34
		DEFB		40
		DEFB		46
		DEFB		52
		DEFB		58
		DEFB		64
		DEFB		68
		DEFB		72
		DEFB		76
		DEFB		78
		DEFB		80
		DEFB		255