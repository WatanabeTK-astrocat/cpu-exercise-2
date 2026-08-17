//
// ALU
//

import BasicTypes::*;
import Types::*;

module ALU(
    output DataPath aluOut,
    
    input DataPath aluInA,
    input DataPath aluInB,
    input ShamtPath shamt,
    input FunctEnum funct
);

    DataPath aluInB_signed;

    always_comb begin
        
        aluOut = '0;

        if (funct == SUB) begin
            aluInB_signed = -aluInB;
        end else begin
            aluInB_signed = aluInB;
        end

        unique case (funct)
        // 算術演算
        ADD,
        SUB:
            aluOut = aluInA + aluInB_signed;
        // 論理演算
        AND:
            aluOut = aluInA & aluInB;
        OR:
            aluOut = aluInA | aluInB;
        XOR:
            aluOut = aluInA ^ aluInB;
        NOR:
            aluOut = ~(aluInA | aluInB);
        SLT:
            aluOut[0] = ($signed(aluInA) < $signed(aluInB)) ? TRUE: FALSE;
        // シフト演算
        SLLI:
            aluOut = $unsigned(aluInB) << shamt;
        SRLI:
            aluOut = $unsigned(aluInB) >> shamt;
        SRAI:
            aluOut = $signed(aluInB) >>> shamt;
        default:
            aluOut = '0;
        endcase

    end

endmodule