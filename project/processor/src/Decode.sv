//
// デコード・ユニット
//

import BasicTypes::*;
import Types::*;

module Decode(
    input InsnPath insn,
    output OpInfo opInfoOut
);

    always_comb begin

        opInfoOut = '0;
        // Cutting out bit fields from instructions
        opInfoOut.opcode            = OpcodeEnum'(  insn[OPCODE_POS       : OPCODE_POS       + 1 - OPCODE_WIDTH]    );
        opInfoOut.rs                =               insn[REG_RS_POS       : REG_RS_POS       + 1 - REG_NUM_WIDTH];
        opInfoOut.rt                =               insn[REG_RT_POS       : REG_RT_POS       + 1 - REG_NUM_WIDTH];
        
        // Switch by opcode
        unique case (opInfoOut.opcode)
        R_TYPE: begin
            opInfoOut.rfWrNum       = insn[REG_RD_POS       : REG_RD_POS       + 1 - REG_NUM_WIDTH];
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.shamt         = insn[SHAMT_POS        : SHAMT_POS        + 1 - SHAMT_WIDTH];
            opInfoOut.funct         = FunctEnum'(   insn[FUNCT_POS        : FUNCT_POS        + 1 - FUNCT_WIDTH]     );
        end
        ADDI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];

            opInfoOut.funct         = ADD;
        end
        SUBI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
            
            opInfoOut.funct         = SUB;
        end
        ANDI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
            
            opInfoOut.funct         = AND;
        end
        ORI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
            
            opInfoOut.funct         = OR;
        end
        XORI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
            
            opInfoOut.funct         = XOR;
        end
        SLTI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
            
            opInfoOut.funct         = SLT;
        end
        LW,
        LH,
        LB: begin
            opInfoOut.isLoad        = TRUE;
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];

            opInfoOut.funct         = ADD;
        end
        SW,
        SH,
        SB: begin
            opInfoOut.isStore       = TRUE;
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];

            opInfoOut.funct         = ADD;
        end
        LUI: begin
            opInfoOut.isALUInImm    = TRUE;
            opInfoOut.rfWrNum       = opInfoOut.rt;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];

            opInfoOut.funct         = SLLI;
            opInfoOut.shamt         = 16; // LUI命令は即値を16ビット左シフトする
        end
        BEQ,
        BNE,
        BLT,
        BGE,
        BLTU,
        BGEU: begin
            opInfoOut.isBranch      = TRUE;
            opInfoOut.imm           = insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
        end
        J: begin
            opInfoOut.isJumpA       = TRUE;
            opInfoOut.jmpAddr       = insn[JUMP_ADDRESS_POS : JUMP_ADDRESS_POS + 1 - JUMP_ADDRESS_WIDTH];
            opInfoOut.rs            = '0;
            opInfoOut.rt            = '0;
        end
        JAL: begin
            opInfoOut.isJumpA       = TRUE;
            opInfoOut.jmpAddr       = insn[JUMP_ADDRESS_POS : JUMP_ADDRESS_POS + 1 - JUMP_ADDRESS_WIDTH];
            opInfoOut.rfWrNum       = REG_RA;
            opInfoOut.rfWrEnable    = TRUE;
            opInfoOut.rs            = '0;
            opInfoOut.rt            = '0;
        end
        JR: begin
            opInfoOut.isJumpR       = TRUE;
            // rs is necessary since it is the jump target
            opInfoOut.rt            = '0;
        end
        JALR: begin
            opInfoOut.isJumpR       = TRUE;
            opInfoOut.rfWrNum       = REG_RA;
            opInfoOut.rfWrEnable    = TRUE;
            // rs is necessary since it is the jump target
            opInfoOut.rt            = '0;
        end
        default: begin
            opInfoOut = '0; // NOP命令として扱う
        end
        endcase
    end

endmodule
