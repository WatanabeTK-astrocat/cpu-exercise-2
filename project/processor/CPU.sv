
import BasicTypes::*;
import Types::*;

module CPU(
    input logic clk,    // クロック
    input logic rst,    // リセット（1でリセット）
    
    output InsnAddrPath insnAddr,       // 命令メモリへのアドレス出力
    output DataAddrPath dataAddr,       // データバスへのアドレス出力
    output DataPath     dataOut,        // 書き込みデータ出力
                                        // dataAddr で指定したアドレスに対して書き込む値を出力する．
    output logic        dataWrEnable,   // データ書き込み有効

    input  InsnPath     insn,           // 命令メモリからの入力
    input  DataPath     dataIn          // 読み出しデータ入力
                                        // dataAddr で指定したアドレスから読んだ値が入力される．
);
	
    // ======== 制御線・データ線 ========
    // PC
    InsnAddrPath pcIn;          // 外部書き込みをする時のアドレス
    logic        pcWrEnable;    // 外部書き込み有効
    InsnAddrPath pcOut;         // アドレス出力
    
    // IMem
    InsnPath imemInsnCode;      // 命令コード
    
    // Decoder
    OpInfo dcOpInfo;

    // レジスタ・ファイル
    DataPath    rfRdDataA;  // 読み出しデータ rs
    DataPath    rfRdDataB;  // 読み出しデータ rt
    DataPath    rfWrData;   // 書き込みデータ
    
    // ALU
    DataPath aluInA;           // ALU 入力A
    DataPath aluInB;           // ALU 入力B
    DataPath aluOut;           // ALU 出力
    
    // Branch
    logic brTaken;

    // ======== モジュールのインスタンス化 ========
    // PC
    PC pc(
        .clk (clk),
        .rst (rst),
        .addrOut (pcOut),
        .addrIn (pcIn),
        .wrEnable (pcWrEnable)
    );

    // Decoder
    Decoder decoder(
        .opInfo (dcOpInfo),
        .insn (imemInsnCode)
    );
    
    // RegisterFile
    RegisterFile regFile(
        .clk (clk),
        .rst (rst),
        .rdDataA (rfRdDataA),
        .rdDataB (rfRdDataB),
        .rdNumA (dcOpInfo.rs),
        .rdNumB (dcOpInfo.rt),
        .wrData (rfWrData),
        .wrNum (dcOpInfo.rfWrNum),
        .wrEnable (dcOpInfo.rfWrEnable)
    );
    
    // ALU
    ALU alu(
        .aluOut (aluOut),
        .aluInA (aluInA),
        .aluInB (aluInB),
        .shamt (dcOpInfo.shamt),
        .funct (dcOpInfo.funct)
    );

    // Branch Unit
    BranchUnit branch(
        .brTaken(brTaken),
        .opcode(dcOpInfo.opcode),
        .compInA(rfRdDataA),
        .compInB(rfRdDataB)
    );

    always_comb begin
        // ======== Instruction Fetch ========
        // IMem
        imemInsnCode = insn;
        insnAddr     = pcOut;

        // PC update
        if (dcOpInfo.isJumpA) begin
            pcWrEnable = TRUE;
            pcIn = EXPAND_JMPADDR_2_INSNADDRPATH(dcOpInfo.jmpAddr);
        end
        else if (dcOpInfo.isJumpR) begin
            pcWrEnable = TRUE;
            pcIn = EXPAND_DATAPATH_2_INSNADDRPATH(rfRdDataA);
        end
        else if (dcOpInfo.isBranch) begin
            pcWrEnable = brTaken;
            pcIn = pcOut + EXPAND_DISPLACEMENT_2_INSNADDRPATH(dcOpInfo.imm);
        end
        else begin
            pcWrEnable = FALSE;
            pcIn = 11'b0;
        end

        // ======== Execute ========
        // ALU input selection and reverse for SUB
        aluInA = rfRdDataA;
        if (dcOpInfo.isALUInImm) begin
            aluInB = {{16{dcOpInfo.imm[15]}}, dcOpInfo.imm};
        end
        else begin
            aluInB = rfRdDataB;
        end
        if (dcOpInfo.funct == SUB) begin
            aluInB = -aluInB;
        end

        // ======== Memory ========
        // DMem write
        dataWrEnable = dcOpInfo.isStore;
        dataAddr     = GET_ADDR(aluOut);
        dataOut      = rfRdDataB;

        // ======== Write Back ========
        // Register write data
        if (dcOpInfo.isJumpA | dcOpInfo.isJumpR) begin
            rfWrData = {21'b0, pcOut} + INSN_PC_INC;
        end
        else if (dcOpInfo.isLoad) begin
            rfWrData = dataIn;
        end
        else begin
            rfWrData = aluOut;
        end
    end

endmodule
