//
// Program Counter
//

import BasicTypes::*;
import Types::*;

module PC(
    input logic clk,    // クロック
    input logic rst,    // リセット

    input InsnAddrPath addrIn,      // 外部書き込みをする時のアドレス
    input logic wrEnable,           // 外部書き込み有効
    input logic stall,              // ストール信号（1でPCを更新しない）

    output InsnAddrPath addrOut     // アドレス出力
);

    // ======== 制御線・データ線 ========

    InsnAddrPath pc;

    // ======== 論理回路 ========

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= INSN_RESET_VECTOR;
        end
        else if (wrEnable) begin
            pc <= addrIn;
        end
        else if (!stall) begin
            pc <= pc + INSN_PC_INC;
        end
    end
    
    // 出力
    assign addrOut = pc;

endmodule
