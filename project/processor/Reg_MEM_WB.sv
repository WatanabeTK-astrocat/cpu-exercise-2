//
// Memory-WriteBackレジスタ
//

import BasicTypes::*;
import Types::*;

module Reg_MEM_WB(
    input logic clk,    // クロック
    input logic rst,    // リセット（1でリセット）
    input logic flush,  // フラッシュ（1で次のクロック時レジスタをリセット）

    input DataPath      rfWrDataIn,     // レジスタファイルへの書き込みデータ
    input logic         rfWrEnableIn,   // レジスタファイルへの書き込み有効入力（1で有効）
    input RegNumPath    rfWrNumIn,      // レジスタファイルへの書き込みアドレス入力

    output DataPath     rfWrDataOut,    // レジスタファイルへの書き込みデータ出力
    output logic        rfWrEnableOut,  // レジスタファイルへの書き込み有効出力（1で有効）
    output RegNumPath   rfWrNumOut      // レジスタファイルへの書き込みアドレス出力
);

    // ======== 制御線・データ線 ========

    DataPath     rfWrData_reg;
    logic        rfWrEnable_reg;
    RegNumPath   rfWrNum_reg;

    // ======== 論理回路 ========

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rfWrData_reg <= '0;
            rfWrEnable_reg <= '0;
            rfWrNum_reg <= '0;
        end
        else if (flush) begin
            rfWrData_reg <= '0;
            rfWrEnable_reg <= '0;
            rfWrNum_reg <= '0;
        end
        else begin
            rfWrData_reg <= rfWrDataIn;
            rfWrEnable_reg <= rfWrEnableIn;
            rfWrNum_reg <= rfWrNumIn;
        end
    end

    // ======== 出力割り当て ========

    assign rfWrDataOut = rfWrData_reg;
    assign rfWrEnableOut = rfWrEnable_reg;
    assign rfWrNumOut = rfWrNum_reg;

endmodule
