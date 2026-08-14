//
// Decode-Executeレジスタ
//

import BasicTypes::*;
import Types::*;

module Reg_ID_EX(
    input logic clk,    // クロック
    input logic rst,    // リセット（1でリセット）
    input logic flush,  // フラッシュ（1で次のクロック時レジスタをリセット）
    
    input InsnAddrPath  insnAddrIn,     // 命令メモリへのアドレス入力
    input InsnPath      insnIn,         // 命令コード入力
    input OpInfo        opInfoIn,       // デコードされた命令情報
    input DataPath      rfRdDataAIn,    // レジスタファイルからの読み出しデータ rs
    input DataPath      rfRdDataBIn,    // レジスタファイルからの読み出しデータ rt
    
    output InsnAddrPath insnAddrOut,    // 命令メモリへのアドレス出力
    output InsnPath     insnOut,        // 命令コード出力
    output OpInfo       opInfoOut,      // デコードされた命令情報出力
    output DataPath     rfRdDataAOut,   // レジスタファイルからの読み出しデータ rs 出力
    output DataPath     rfRdDataBOut    // レジスタファイルからの読み出しデータ rt 出力
);

    // ======== 制御線・データ線 ========

    InsnAddrPath insnAddr_reg;
    InsnPath     insn_reg;
    OpInfo       opInfo_reg;
    DataPath     rfRdDataA_reg;
    DataPath     rfRdDataB_reg;

    // ======== 論理回路 ========

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            insnAddr_reg <= '0;
            insn_reg     <= '0;
            opInfo_reg   <= '0;
            rfRdDataA_reg <= '0;
            rfRdDataB_reg <= '0;
        end
        else if (flush) begin
            insnAddr_reg <= '0;
            insn_reg     <= '0;
            opInfo_reg   <= '0;
            rfRdDataA_reg <= '0;
            rfRdDataB_reg <= '0;
        end
        else begin
            insnAddr_reg <= insnAddrIn;
            insn_reg     <= insnIn;
            opInfo_reg   <= opInfoIn;
            rfRdDataA_reg <= rfRdDataAIn;
            rfRdDataB_reg <= rfRdDataBIn;
        end
    end

    // ======== 出力割り当て ========
    assign insnAddrOut = insnAddr_reg;
    assign rfRdDataAOut = rfRdDataA_reg;
    assign rfRdDataBOut = rfRdDataB_reg;
    assign insnOut = insn_reg;
    assign opInfoOut = opInfo_reg;

endmodule
