//
// 減算器の検証用モジュール
//


//
// 減算器の検証用のモジュール
//
module SubSim;

    import Types::*;

    DataPath subtractorInA, subtractorInB;
    DataPath subtractorOut;

    // 減算器のインスタンス化
    Subtractor sub(
        .dst(subtractorOut),
        .srcA(subtractorInA),
        .srcB(subtractorInB)
    );

    //
    // 検証用の信号の入力を記述
    //
    initial begin
`ifdef VERILATOR_SIMULATION
		$dumpfile("wave.vcd");
		$dumpvars;
`endif

        //シミュレーション開始
		$monitor(
			$stime, 					// 現在の時間
			" a(%d) - b(%d) = c(%d)", 	// printf と同様の書式設定
			subtractorInA, 
			subtractorInB,
			subtractorOut
		);
		
		subtractorInA = 8;	// A に 8 代入
		subtractorInB = 1;	// B に 1 代入

		#40 			// 40ns 経過させる（40 * 1timescale）

		subtractorInA = 9;	// A に 9 代入
		subtractorInB = 6;   // B に 6 代入

		#20 			// 20ns 経過

		$finish;		// シミュレーション終了
    end

endmodule
