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
    input funct_e funct
);

    always_comb begin
        
        unique case (funct)
        // 算術演算
        ADD,
        SUB: // 符号の変更はALUの外、Executeステージで行う
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
        SLL:
            aluOut = aluInA << shamt;
        SRL:
            aluOut = aluInA >> shamt;
        SRA:
            aluOut = aluInA >>> shamt;
        default:
            aluOut = '0;
        endcase

    end

endmodule