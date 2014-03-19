; 作成者: 大竹 洋平
; 作成日: 2013.05.14
; 7Bit加算器･減算器
;
EA 		EQU	84H			;外部LEDへの出力
IL		EQU	80H			;内部LEDへの出力
IA		EQU	1CH			;内部DIPスイッチ入力
EC		EQU	86H			;外部DIPスイッチ入力
CWR		EQU	87H			;外部I/O（1）のコントロールワードレジスタ
LCWR	EQU	83H			;外部I/O（2）のコントロールワードレジスタ
;
		ORG	8000H		;プログラムの先頭（開始）アドレス
		LD	A,89H		;コントロールワードをアキュムレータにロード
		OUT	(CWR),A		;CWRに1000 1001を入れる
		LD	A,80H
		OUT	(LCWR),A	;LCWRに1000 0000を入れる

LOOP:	LD	D,80H		;減算時のMSBを無効にするための被減算数
		LD	C,IA
		IN	A,(EC)
		IN	B,(C)
		BIT	7,A			;外部DIPスイッチのMSBの判定
		JP	NZ,RESET	;0でない場合はPCにRESETの番地をセット
		BIT	7,B			;内部DIPスイッチのMSBの判定
		JP	Z,SUB		;0なら加算なのでビット反転は飛ばす
;
		SUB	D			;減算前にアキュムレータのMSBを0にセット
		CPL				;補数を得るために各Bitを反転させる
		INC	A			;反転後に1を加え補数を作成
;
SUB:	ADD	A,B
		OUT	(EA),A		;外部LEDへ出力
		OUT	(IL),A		;内部LEDへ出力

		JP	LOOP		;実験を継続させるためプログラムを繰り返し実行
;
RESET:	LD	A,0
		OUT	(EA),A		;外部LEDのリセット
		OUT	(IL),A		;内部LEDのリセット
		JP	LOOP
	
		HALT
		END