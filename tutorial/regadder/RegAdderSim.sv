//
// レジスタファイル-加算器結合モジュールの検証用モジュール
//

// 基本的な型を定義したファイルの読み込み
import Types::*;


//
// レジスタファイル-加算器結合モジュールの検証用のモジュール
//
module RegAdderSim;

	parameter CYCLE_TIME = 10; // 1サイクルを 10ns に設定

	integer cycle;			// 測定用サイクル

	logic clk;				// クロック
	
	DataPath rfRdData;	    // 読み出しデータ

	RegNumPath rfRdNumA;	// 読み出しレジスタ番号A
	RegNumPath rfRdNumB;	// 読み出しレジスタ番号B

	DataPath   rfWrData;	// 書き込みデータ
	RegNumPath rfWrNum;	    // 書き込みレジスタ番号
	logic      rfWrEnable;	// 書き込み制御 1の場合，書き込みを行う

	RegAdder regAdder(
		.clk( clk ),
		.sumData ( rfRdData   ),
		.rdNumA  ( rfRdNumA   ),
		.rdNumB  ( rfRdNumB   ),
		.wrData  ( rfWrData   ),
		.wrNum   ( rfWrNum    ),
		.wrEnable( rfWrEnable )
	);

	// クロック
	initial begin 
		clk = 1'b1;
		cycle = 0;
		
		// 半サイクルごとに clk を反転
	    forever #(CYCLE_TIME / 2) begin
	    	clk = !clk ;
	    	cycle = cycle + 1;
	    end
	end

	// 検証動作を記述する
	initial begin
`ifdef VERILATOR_SIMULATION
		$dumpfile("wave.vcd");
		$dumpvars;
`endif

		// 初期化
		rfRdNumA   = 0;
		rfRdNumB   = 0;
		rfWrData   = 0;
		rfWrNum    = 0;
		rfWrEnable = 0;

		//
		// シミュレーション開始
		//
		
		rfWrEnable = 1;	rfWrNum = 0;	rfWrData = 15;  // $0に15を代入
		#CYCLE_TIME
		
		rfWrEnable = 1;	rfWrNum = 1;	rfWrData = 14;	// $1に14を代入
		#CYCLE_TIME
		
		rfRdNumA   = 0;	rfRdNumB = 1;					// $0と$1を読み出す
		rfWrEnable = 1;	rfWrNum  = 2;	rfWrData = 13;	// $2に13を代入
		#CYCLE_TIME

		rfWrEnable = 1;	rfWrNum = 3;	rfWrData = 12;	// $3に12を代入
		#CYCLE_TIME
		
		rfRdNumA   = 2;	rfRdNumB = 3;					// $2と$3を読み出す
		rfWrEnable = 1;	rfWrNum  = 4;	rfWrData = 11;	// $4に11を代入
		#CYCLE_TIME

		rfWrEnable = 1;	rfWrNum = 5;	rfWrData = 10;	// $5に10を代入
		#CYCLE_TIME

		rfRdNumA   = 4;	rfRdNumB = 5;					// $4と$5を読み出す
		rfWrEnable = 1;	rfWrNum  = 6;	rfWrData = 9;	// $6に9を代入
		#CYCLE_TIME
		
		rfWrEnable = 1;	rfWrNum = 7;	rfWrData = 8;	// $7に8を代入
		#CYCLE_TIME

		rfRdNumA   = 6;	rfRdNumB = 7;	// $6と$7を読み出す
		rfWrEnable = 0;	rfWrNum  = 0;	// 書き込み信号をOFFにする
		#CYCLE_TIME
		
		rfRdNumA = 0;	rfRdNumB = 1;	// $0と$1を読み出す
		#CYCLE_TIME
		
		rfRdNumA = 2;	rfRdNumB = 3;	// $2と$3を読み出す
		#CYCLE_TIME

		rfRdNumA = 4;	rfRdNumB = 5;	// $4と$5を読み出す
		#CYCLE_TIME

		rfRdNumA = 6;	rfRdNumB = 7;	// $6と$7を読み出す
		#CYCLE_TIME

		#(CYCLE_TIME*10)
		$finish;
		// 10サイクル経過して終了
     
	end

	// シミュレーション結果の表示（クロックの立ち上がり時と立ち下がり時）
	always @( posedge clk or negedge clk ) begin 
		
		$write(
			"%s\n",
			( clk == 0 ) ?
		  		"=====================================================" :
		  		"-----------------------------------------------------");
		
		$write(
			"cycle -> %0d\n", 
		  	cycle
		);
		
		$write(
			"          RdNumA[%d] RdNumB[%d] => RdData[%d]\n",
		  	rfRdNumA,
		  	rfRdNumB,
		  	rfRdData
		);
		
		$write(
			"    %s WrNum[%d] WrData[%d]\n",
			(rfWrEnable) ? 
				"Write" : 
				"     ",
			rfWrNum,
			rfWrData
		);
		
		$write(
			"  %s\n",
		  	( clk == 1 ) ? "posedge clk" : "negedge clk"
		);
		
	end
  
endmodule
