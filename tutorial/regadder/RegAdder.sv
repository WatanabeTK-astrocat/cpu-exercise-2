//
// レジスタと加算器を組み合わせた回路のシミュレーション
//

import Types::*;

module RegAdder(
	input logic         clk,	    // クロック
	
	output DataPath     sumData,	// 読み出しデータ (レジスタ番号AとBの中身の和)

	input RegNumPath    rdNumA,	    // 読み出しレジスタ番号A
	input RegNumPath    rdNumB,	    // 読み出しレジスタ番号B

	input DataPath      wrData,	    // 書き込みデータ
	input RegNumPath    wrNum,	    // 書き込みレジスタ番号
	input logic         wrEnable	// 書き込み制御 1の場合，書き込みを行う
);

    DataPath rdDataA;    // 読み出しデータA
    DataPath rdDataB;    // 読み出しデータB

	// レジスタファイルのインスタンス化
    RegisterFile regFile(
        .clk( clk ),
		.rdDataA ( rdDataA  ),
		.rdDataB ( rdDataB  ),
		.rdNumA  ( rdNumA   ),
		.rdNumB  ( rdNumB   ),
		.wrData  ( wrData   ),
		.wrNum   ( wrNum    ),
		.wrEnable( wrEnable )
    );

    // 加算器のインスタンス化
    Adder adder(
        .dst( sumData ),
        .srcA( rdDataA ),
        .srcB( rdDataB )
    );

endmodule
