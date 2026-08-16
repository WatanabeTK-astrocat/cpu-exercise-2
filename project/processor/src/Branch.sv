//
// 条件分岐判定ユニット
//

import BasicTypes::*;
import Types::*;

module BranchUnit(
    output logic        brTaken, // 分岐が成立する(if文の中に入ってPCが分岐先に飛ぶ)場合はTRUE，そうでない場合はFALSE

    input OpcodeEnum    opcode,  // 命令のオペコード
    input DataPath      compInA,
    input DataPath      compInB
);

    always_comb begin

        unique case (opcode)
        BEQ:
            brTaken = (compInA == compInB) ? TRUE : FALSE;
        BNE:
            brTaken = (compInA != compInB) ? TRUE : FALSE;
        BLT:
            brTaken = ($signed(compInA) < $signed(compInB))  ? TRUE : FALSE;
        BGE:
            brTaken = ($signed(compInA) >= $signed(compInB)) ? TRUE : FALSE;
        BLTU:
            brTaken = ($unsigned(compInA) < $unsigned(compInB)) ? TRUE : FALSE;
        BGEU:
            brTaken = ($unsigned(compInA) >= $unsigned(compInB)) ? TRUE : FALSE;
        default:
            brTaken = FALSE;
        endcase

    end

endmodule
