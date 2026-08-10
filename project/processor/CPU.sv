
import BasicTypes::*;
import Types::*;

module CPU(
    input logic clk,    // クロック
    input logic rst,    // リセット
    
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
    OpInfo dcOpinfo;

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
        .opInfo (dcOpinfo),
        .insn (imemInsnCode)
    );
    
    // RegisterFile
    RegisterFile regFile(
        .clk (clk),
        .rdDataA (rfRdDataA),
        .rdDataB (rfRdDataB),
        .rdNumA (dcOpinfo.rs),
        .rdNumB (dcOpinfo.rt),
        .wrData (rfWrData),
        .wrNum (dcOpinfo.rfWrNum),
        .wrEnable (dcOpinfo.rfWrEnable)
    );
    
    // ALU
    ALU alu(
        .aluOut (aluOut),
        .aluInA (aluInA),
        .aluInB (aluInB),
        .shamt (dcOpinfo.shamt),
        .funct (dcOpinfo.funct)
    );

    // Branch Unit
    BranchUnit branch(
        .brTaken(brTaken),
        .opcode(dcOpinfo.opcode),
        .compInA(rfRdDataA),
        .compInB(rfRdDataB)
    );

    always_comb begin
        // ======== Instruction Fetch ========
        // IMem
        imemInsnCode = insn;
        insnAddr     = pcOut;

        // PC update
        if (dcOpinfo.isJumpA) begin
            pcWrEnable = TRUE;
            pcIn = EXPAND_JMPADDR_2_INSNADDRPATH(dcOpinfo.jmpAddr);
        end
        else if (dcOpinfo.isJumpR) begin
            pcWrEnable = TRUE;
            pcIn = pcOut + EXPAND_DATAPATH_2_INSNADDRPATH(rfRdDataA);
        end
        else if (dcOpinfo.isBranch) begin
            pcWrEnable = brTaken;
            pcIn = pcOut + EXPAND_DISPLACEMENT_2_INSNADDRPATH(dcOpinfo.imm);
        end
        else begin
            pcWrEnable = FALSE;
            pcIn = 11'b0;
        end

        // ======== Execute ========
        // ALU input selection and reverse for SUB
        aluInA = rfRdDataA;
        if (dcOpinfo.isALUInImm) begin
            aluInB[15:0] = dcOpinfo.imm;
            aluInB[31:16] = 16'b0;
        end
        else begin
            aluInB = rfRdDataB;
        end
        if (dcOpinfo.funct == SUB) begin
            aluInB = -aluInB;
        end

        // ======== Memory ========
        // DMem write
        dataWrEnable = dcOpinfo.isStore;
        dataAddr     = GET_ADDR(aluOut);
        dataOut      = rfRdDataB;

        // ======== Write Back ========
        // Register write data
        if (dcOpinfo.isJumpA | dcOpinfo.isJumpR) begin
            rfWrData = {21'b0, pcOut} + INSN_PC_INC;
        end
        else if (dcOpinfo.isLoad) begin
            rfWrData = dataIn;
        end
        else begin
            rfWrData = aluOut;
        end
    end

endmodule
