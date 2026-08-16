//
// 2 Read / 1 Write レジスタ・ファイル
//

import BasicTypes::*;
import Types::*;

module RegisterFile(
	input logic clk,			// クロック
    input logic rst,			// リセット（1でリセット）

	input RegNumPath rdNumA,	// 読み出しレジスタ番号A
	input RegNumPath rdNumB,	// 読み出しレジスタ番号B

	input DataPath   wrData,	// 書き込みデータ
	input RegNumPath wrNum,	    // 書き込みレジスタ番号
	input logic      wrEnable,  // 書き込み制御 1の場合，書き込みを行う

	output DataPath rdDataA,	// 読み出しデータA
	output DataPath rdDataB 	// 読み出しデータB
);

	// 実際に値が入るストレージ
	// DataPath の配列（サイズ：REG_FILE_SIZE）
	DataPath storage[ REG_FILE_SIZE ]; 

	// 書き込みと，レジスタ・ファイルの実現
	// クロックの立ち上がりによって書き込みが行われる と言う動作を書くことで，
	// コンパイラはこれを順序回路だと解釈する．
	always_ff @( posedge clk or posedge rst ) begin
		if( rst ) begin
			for( int i = 0; i < REG_FILE_SIZE; i++ ) begin
				storage[ i ] <= '0;
			end
            storage[ REG_SP ] <= STACK_INIT_ADDR; // スタックポインタの初期値を設定
		end
		else if( wrEnable & (wrNum != REG_ZERO) ) begin			// 書き込み制御
			storage[ wrNum ] <= wrData;	// 順序回路では，ノンブロッキング代入で
		end
	end

	// 読み出し
	assign rdDataA = storage[ rdNumA ];
	assign rdDataB = storage[ rdNumB ];

endmodule

