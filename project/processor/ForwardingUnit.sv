//
// フォワーディングユニット
//

import BasicTypes::*;
import Types::*;

module ForwardingUnit(
    input DataPath      EX_rfRdDataA,       // レジスタファイルからの読み出しデータ rs
    input DataPath      EX_rfRdDataB,       // レジスタファイルからの読み出しデータ rt
    input OpInfo        EX_opInfo,          // EXステージにおける命令情報

    input DataPath      EX_MEM_rfWrData,    // EX/MEMレジスタにおけるレジスタファイルへの書き込みデータ
    input RegNumPath    EX_MEM_rfWrNum,     // EX/MEMレジスタにおける書き込み先レジスタ番号
    input logic         EX_MEM_rfWrEnable,  // EX/MEMレジスタにおけるレジスタファイルへの書き込み有効信号

    input DataPath      MEM_WB_rfWrData,    // MEM/WBレジスタにおけるレジスタファイルへの書き込みデータ
    input RegNumPath    MEM_WB_rfWrNum,     // MEM/WBレジスタにおける書き込み先レジスタ番号
    input logic         MEM_WB_rfWrEnable,  // MEM/WBレジスタにおけるレジスタファイルへの書き込み有効信号

    output DataPath     dataAOut,       // フォワーディングされたデータA
    output DataPath     dataBOut        // フォワーディングされたデータB
);

    always_comb begin
        if (EX_MEM_rfWrEnable && (EX_MEM_rfWrNum != 0) && (EX_MEM_rfWrNum == EX_opInfo.rs)) begin
            dataAOut = EX_MEM_rfWrData;
        end
        else if (MEM_WB_rfWrEnable && (MEM_WB_rfWrNum != 0) && (MEM_WB_rfWrNum == EX_opInfo.rs)) begin
            dataAOut = MEM_WB_rfWrData;
        end
        else begin
            dataAOut = EX_rfRdDataA;
        end
        if (EX_MEM_rfWrEnable && (EX_MEM_rfWrNum != 0) && (EX_MEM_rfWrNum == EX_opInfo.rt)) begin
            dataBOut = EX_MEM_rfWrData;
        end
        else if (MEM_WB_rfWrEnable && (MEM_WB_rfWrNum != 0) && (MEM_WB_rfWrNum == EX_opInfo.rt)) begin
            dataBOut = MEM_WB_rfWrData;
        end
        else begin
            dataBOut = EX_rfRdDataB;
        end
    end

endmodule
