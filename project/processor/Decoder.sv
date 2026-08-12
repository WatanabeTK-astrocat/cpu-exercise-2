//
// デコード・ユニット
//

import BasicTypes::*;
import Types::*;

module Decoder(
    output OpInfo opInfo,
    input InsnPath insn
);

    RegNumPath rd; // 書き込み先レジスタ番号。opinfoには含まれず、ここで一時的に保持する

    always_comb begin

        opInfo = '0;
        // Cutting out bit fields from instructions
        opInfo.opcode   = OpcodeEnum'(  insn[OPCODE_POS       : OPCODE_POS       + 1 - OPCODE_WIDTH]    );
        opInfo.rs       =               insn[REG_RS_POS       : REG_RS_POS       + 1 - REG_NUM_WIDTH];
        opInfo.rt       =               insn[REG_RT_POS       : REG_RT_POS       + 1 - REG_NUM_WIDTH];
               rd       =               insn[REG_RD_POS       : REG_RD_POS       + 1 - REG_NUM_WIDTH];
        opInfo.shamt    =               insn[SHAMT_POS        : SHAMT_POS        + 1 - SHAMT_WIDTH];
        opInfo.funct    = FunctEnum'(   insn[FUNCT_POS        : FUNCT_POS        + 1 - FUNCT_WIDTH]     );
        opInfo.imm      =               insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
        opInfo.jmpAddr  =               insn[JUMP_ADDRESS_POS : JUMP_ADDRESS_POS + 1 - JUMP_ADDRESS_WIDTH];
        
        // Switch by opcode
        unique case (opInfo.opcode)
        R_TYPE: begin
            opInfo.rfWrNum      = rd;
            opInfo.rfWrEnable   = TRUE;
        end
        ADDI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;
            
            opInfo.funct        = ADD;
        end
        SUBI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;
            
            opInfo.funct        = SUB;
        end
        ANDI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;
            
            opInfo.funct        = AND;
        end
        ORI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;
            
            opInfo.funct        = OR;
        end
        XORI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;
            
            opInfo.funct        = XOR;
        end
        SLTI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;
            
            opInfo.funct        = SLT;
        end
        LW,
        LH,
        LB: begin
            opInfo.isLoad       = TRUE;
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;

            opInfo.funct        = ADD;
        end
        SW,
        SH,
        SB: begin
            opInfo.isStore      = TRUE;
            opInfo.isALUInImm   = TRUE;

            opInfo.funct        = ADD;
        end
        LUI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.rfWrNum      = opInfo.rt;
            opInfo.rfWrEnable   = TRUE;

            opInfo.funct        = SLLI;
            opInfo.shamt        = 16; // LUI命令は即値を16ビット左シフトする
        end
        BEQ,
        BNE,
        BLT,
        BGE,
        BLTU,
        BGEU: begin
            opInfo.isBranch     = TRUE;
        end
        J: begin
            opInfo.isJumpA      = TRUE;
            opInfo.rs           = '0;
            opInfo.rt           = '0;
        end
        JAL: begin
            opInfo.isJumpA      = TRUE;
            opInfo.rfWrNum      = REG_RA;
            opInfo.rfWrEnable   = TRUE;
            opInfo.rs           = '0;
            opInfo.rt           = '0;
        end
        JR: begin
            opInfo.isJumpR      = TRUE;
            // rs is necessary since it is the jump target
            opInfo.rt           = '0;
        end
        JALR: begin
            opInfo.isJumpR      = TRUE;
            opInfo.rfWrNum      = REG_RA;
            opInfo.rfWrEnable   = TRUE;
            // rs is necessary since it is the jump target
            opInfo.rt           = '0;
        end
        default: begin
            rd = '0;
            opInfo.rs = '0;
            opInfo.rt = '0;
        end
        endcase
    end

endmodule
