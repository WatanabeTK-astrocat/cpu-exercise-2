//
// Fetch-Decodeレジスタ
//

import BasicTypes::*;
import Types::*;

module Reg_IF_ID(
    input logic clk,    // クロック
    input logic rst,    // リセット（1でリセット）
    input logic stall,  // ストール（1で次のクロック時レジスタを保持）
    input logic flush,  // フラッシュ（1で次のクロック時レジスタをリセット）
    
    input InsnAddrPath  insnAddrIn,     // 命令メモリへのアドレス入力
    input InsnPath      insnIn,         // 命令コード入力
    
    output InsnAddrPath insnAddrOut,    // 命令メモリへのアドレス出力
    output InsnPath     insnOut         // 命令コード出力
);

    // ======== 制御線・データ線 ========

    InsnAddrPath insnAddr_reg;
    InsnPath     insn_reg;

    // ======== 論理回路 ========

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            insnAddr_reg <= '0;
            insn_reg     <= '0;
        end
        else if (flush) begin
            insnAddr_reg <= '0;
            insn_reg     <= '0;
        end
        else if (!stall) begin
            insnAddr_reg <= insnAddrIn;
            insn_reg     <= insnIn;
        end
    end

    // ======== 出力割り当て ========

    assign insnAddrOut = insnAddr_reg;
    assign insnOut = insn_reg;

endmodule
