//
// 16ビット減算器
//

// 基本的な型を定義したファイルの読み込み
import Types::*;

module Subtractor(
    output
        DataPath dst,   // 出力線の宣言
    input
        DataPath srcA,
        DataPath srcB   // 入力線の宣言
);

    // 減算
    assign dst = srcA - srcB;

endmodule
