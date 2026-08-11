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

    always_comb begin
        
        aluOut = '0;

        unique case (funct)
        // 算術演算
        ADD,
        SUB: // 符号反転は CPU 側で行う
            aluOut = aluInA + aluInB;
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
            aluOut[0] = aluInA < aluInB ? TRUE: FALSE;
        // シフト演算
        SLLI:
            aluOut = aluInA << shamt;
        SRLI:
            aluOut = aluInA >> shamt;
        SRAI:
            aluOut = aluInA >>> shamt;
        default:
            aluOut = '0;
        endcase

    end

endmodule