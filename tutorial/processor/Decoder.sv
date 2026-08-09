//
// デコード・ユニット
//

import BasicTypes::*;
import Types::*;

module Decoder(
    output OpInfo opInfo,
    input InsnPath insn
);

    always_comb begin

        opInfo = '0;
        // Cutting out bit fields from instructions
        opInfo.opcode   = OpcodeEnum'(  insn[OPCODE_POS       : OPCODE_POS       + 1 - OPCODE_WIDTH]    );
        opInfo.rs       =               insn[REG_RS_POS       : REG_RS_POS       + 1 - REG_NUM_WIDTH];
        opInfo.rt       =               insn[REG_RT_POS       : REG_RT_POS       + 1 - REG_NUM_WIDTH];
        opInfo.rd       =               insn[REG_RD_POS       : REG_RD_POS       + 1 - REG_NUM_WIDTH];
        opInfo.shamt    =               insn[SHAMT_POS        : SHAMT_POS        + 1 - SHAMT_WIDTH];
        opInfo.funct    = FunctEnum'(   insn[FUNCT_POS        : FUNCT_POS        + 1 - FUNCT_WIDTH]     );
        opInfo.imm      =               insn[IMMEDIATE_POS    : IMMEDIATE_POS    + 1 - IMMEDIATE_WIDTH];
        opInfo.jmpAddr  =               insn[JUMP_ADDRESS_POS : JUMP_ADDRESS_POS + 1 - JUMP_ADDRESS_WIDTH];
        
        // Switch by opcode
        unique case (opInfo.opcode)
        R_TYPE: begin
            opInfo.regWrNum     = opInfo.rd;
            opInfo.regWrEnable  = TRUE;
        end
        ADDI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.regWrNum     = opInfo.rt;
            opInfo.regWrEnable  = TRUE;
            opInfo.rd           = '0;
            
            opInfo.funct        = ADD;
        end
        SUBI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.regWrNum     = opInfo.rt;
            opInfo.regWrEnable  = TRUE;
            opInfo.rd           = '0;
            
            opInfo.funct        = SUB;
        end
        ANDI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.regWrNum     = opInfo.rt;
            opInfo.regWrEnable  = TRUE;
            opInfo.rd           = '0;
            
            opInfo.funct        = AND;
        end
        ORI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.regWrNum     = opInfo.rt;
            opInfo.regWrEnable  = TRUE;
            opInfo.rd           = '0;
            
            opInfo.funct        = OR;
        end
        XORI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.regWrNum     = opInfo.rt;
            opInfo.regWrEnable  = TRUE;
            opInfo.rd           = '0;
            
            opInfo.funct        = XOR;
        end
        SLTI: begin
            opInfo.isALUInImm   = TRUE;
            opInfo.regWrNum     = opInfo.rt;
            opInfo.regWrEnable  = TRUE;
            opInfo.rd           = '0;
            
            opInfo.funct        = SLT;
        end
        LW,
        LH,
        LB: begin
            opInfo.isLoad       = TRUE;
            opInfo.isALUInImm   = TRUE;
            opInfo.rd           = '0;

            opInfo.funct        = ADD;
        end
        SW,
        SH,
        SB: begin
            opInfo.isStore      = TRUE;
            opInfo.isALUInImm   = TRUE;
            opInfo.rd           = '0;

            opInfo.funct        = ADD;
        end
        BEQ,
        BNE,
        BLT,
        BGE,
        BLTU,
        BGEU: begin
            opInfo.isBranch     = TRUE;
            opInfo.rd           = '0;
        end
        J: begin
            opInfo.isJump       = TRUE;
            opInfo.rs           = '0;
            opInfo.rt           = '0;
            opInfo.rd           = '0;
        end
        JAL: begin
            opInfo.isJump       = TRUE;
            opInfo.regWrNum     = REG_RA;
            opInfo.regWrEnable  = TRUE;
            opInfo.rs           = '0;
            opInfo.rt           = '0;
            opInfo.rd           = '0;
        end
        JR: begin
            opInfo.isJump       = TRUE;
            // rs is necessary since it is the jump target
            opInfo.rt           = '0;
            opInfo.rd           = '0;
        end
        JALR: begin
            opInfo.isJump       = TRUE;
            opInfo.regWrNum     = REG_RA;
            opInfo.regWrEnable  = TRUE;
            // rs is necessary since it is the jump target
            opInfo.rt           = '0;
            opInfo.rd           = '0;
        end
        default: begin
            opInfo.rd = '0;
            opInfo.rs = '0;
            opInfo.rt = '0;
        end
        endcase
    end

endmodule
