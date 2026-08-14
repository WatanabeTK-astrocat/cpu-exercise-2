//
// CPU メイン部
//

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

    input  InsnPath     insnIn,         // 命令メモリからの入力
    input  DataPath     dataIn          // 読み出しデータ入力
                                        // dataAddr で指定したアドレスから読んだ値が入力される．
);
	
    // ======== 制御線・データ線 ========

    // Instruction Fetch・PC
    // なし (IMemへは insnAddr, insnIn で接続される)
    
    // Instruction Decode
    InsnAddrPath    ID_insnAddr;    // 命令アドレス
    InsnPath        ID_insn;        // 命令コード
    OpInfo          ID_rawopInfo;   // ハザードを考慮する前のデコードされた命令情報
    OpInfo          ID_opInfo;      // ハザードを考慮した後のデコードされた命令情報
    DataPath        ID_rfRdDataA;   // レジスタファイルからの読み出しデータ rs
    DataPath        ID_rfRdDataB;   // レジスタファイルからの読み出しデータ rt
    
    // Execute
    InsnAddrPath    EX_insnAddr;    // 命令アドレス
    InsnPath        EX_insn;        // 命令コード
    OpInfo          EX_opInfo;      // デコードされた命令情報
    DataPath        EX_rfRdDataA;   // レジスタファイルからの読み出しデータ rs
    DataPath        EX_rfRdDataB;   // レジスタファイルからの読み出しデータ rt
    DataPath        EX_fwdDataA;    // フォワーディングされたデータ rs
    DataPath        EX_fwdDataB;    // フォワーディングされたデータ rt
    DataPath        EX_aluInA;      // ALU 入力 A (rs) EX_fwdDataA で固定
    DataPath        EX_aluInB;      // ALU 入力 B (immediate or rtの二択と符号反転があるため、EX_opInfo.isALUInImm等で切り替える)
    DataPath        EX_aluOut;      // ALU 出力
    logic           EX_brTaken;     // 条件分岐が成立したかどうかのフラグ（1で成立）

    // Memory
    // DMemへは dataAddr, dataOut, dataWrEnable, dataIn で接続される
    InsnAddrPath    MEM_insnAddr;   // 命令アドレス
    InsnPath        MEM_insn;       // 命令コード
    OpInfo          MEM_opInfo;     // デコードされた命令情報
    DataPath        MEM_fwdDataA;   // フォワーディングされたデータ rs
    DataPath        MEM_fwdDataB;   // フォワーディングされたデータ rt
    DataPath        MEM_aluOut;     // ALU 出力
    logic           MEM_brTaken;    // 条件分岐が成立したかどうかのフラグ（1で成立）
    // MemoryのうちEMレジスタに保持しないもの
    DataPath        MEM_rfWrData;   // レジスタファイルへの書き込みデータ 
    InsnAddrPath    pcIn;           // PCへの外部書き込みアドレス (MEM/WBレジスタには入れない)
    logic           pcWrEnable;     // PCへの外部書き込み有効 (MEM/WBレジスタには入れない)

    // Write Back
    DataPath        WB_rfWrData;    // 書き込みデータ
    logic           WB_rfWrEnable;  // レジスタファイルへの書き込み有効
    RegNumPath      WB_rfWrNum;     // レジスタファイルへの書き込みアドレス

    // ストール信号
    logic           IF_stall;       // IFステージ ストール信号（1でPCを保持）
    logic           IF_ID_flush;    // IF/IDレジスタ フラッシュ信号（1でIF/IDレジスタをリセット）
    logic           ID_EX_flush;    // ID/EXレジスタ フラッシュ信号（1でID/EXレジスタをリセット）
    logic           EX_MEM_flush;   // EX/MEMレジスタ フラッシュ信号（1でEX/MEMレジスタをリセット）

    // ======== モジュールのインスタンス化 ========
    // PC
    PC pc(
        .clk (clk),
        .rst (rst),
        .addrIn (pcIn),
        .wrEnable (pcWrEnable),
        .stall (IF_stall),
        .addrOut (insnAddr)
    );

    // Fetch-Decodeレジスタ
    Reg_IF_ID regIFID(
        .clk (clk),
        .rst (rst),
        .stall (IF_stall),
        .flush (IF_ID_flush),
        .insnAddrIn (insnAddr),
        .insnIn (insnIn),
        .insnAddrOut (ID_insnAddr),
        .insnOut (ID_insn)
    );

    // Decode
    Decode decode(
        .insn (ID_insn),
        .opInfoOut (ID_rawopInfo)
    );

    // ハザード検出ユニット
    HazardUnit hazard(
        .ID_opInfoIn (ID_rawopInfo),
        .EX_opInfoIn (EX_opInfo),
        .MEM_opInfoIn (MEM_opInfo),
        .IF_stall (IF_stall),
        .IF_ID_flush (IF_ID_flush),
        .ID_EX_flush (ID_EX_flush),
        .EX_MEM_flush (EX_MEM_flush),
        .ID_opInfoOut (ID_opInfo)
    );
    
    // レジスタファイル
    RegisterFile regFile(
        .clk (clk),
        .rst (rst),
        .rdNumA (ID_opInfo.rs),
        .rdNumB (ID_opInfo.rt),
        .wrData (WB_rfWrData),
        .wrNum (WB_rfWrNum),
        .wrEnable (WB_rfWrEnable),
        .rdDataA (ID_rfRdDataA),
        .rdDataB (ID_rfRdDataB)
    );

    // Decode-Executeレジスタ
    Reg_ID_EX regIDEX(
        .clk (clk),
        .rst (rst),
        .flush (ID_EX_flush),
        .insnAddrIn (ID_insnAddr),
        .insnIn (ID_insn),
        .opInfoIn (ID_opInfo),
        .rfRdDataAIn (ID_rfRdDataA),
        .rfRdDataBIn (ID_rfRdDataB),
        .insnAddrOut (EX_insnAddr),
        .insnOut (EX_insn),
        .opInfoOut (EX_opInfo),
        .rfRdDataAOut (EX_rfRdDataA),
        .rfRdDataBOut (EX_rfRdDataB)
    );

    // フォワーディングユニット
    ForwardingUnit forwarding(
        .EX_rfRdDataA (EX_rfRdDataA),
        .EX_rfRdDataB (EX_rfRdDataB),
        .EX_opInfo (EX_opInfo),
        .EX_MEM_rfWrData (MEM_rfWrData),
        .EX_MEM_rfWrNum (MEM_opInfo.rfWrNum),
        .EX_MEM_rfWrEnable (MEM_opInfo.rfWrEnable),
        .MEM_WB_rfWrData (WB_rfWrData),
        .MEM_WB_rfWrNum (WB_rfWrNum),
        .MEM_WB_rfWrEnable (WB_rfWrEnable),
        .dataAOut (EX_fwdDataA),
        .dataBOut (EX_fwdDataB)
    );
    
    // ALU
    ALU alu(
        .aluOut (EX_aluOut),
        .aluInA (EX_aluInA),
        .aluInB (EX_aluInB),
        .shamt (EX_opInfo.shamt),
        .funct (EX_opInfo.funct)
    );

    // 条件分岐判定ユニット
    BranchUnit branch(
        .brTaken (EX_brTaken),
        .opcode (EX_opInfo.opcode),
        .compInA (EX_fwdDataA),
        .compInB (EX_fwdDataB)
    );

    // Execute-Memoryレジスタ
    Reg_EX_MEM regEXMEM(
        .clk (clk),
        .rst (rst),
        .flush (EX_MEM_flush),
        .insnAddrIn (EX_insnAddr),
        .insnIn (EX_insn),
        .opInfoIn (EX_opInfo),
        .rfRdDataAIn (EX_fwdDataA),
        .rfRdDataBIn (EX_fwdDataB),
        .aluOutIn (EX_aluOut),
        .brTakenIn (EX_brTaken),
        .insnAddrOut (MEM_insnAddr),
        .insnOut (MEM_insn),
        .opInfoOut (MEM_opInfo),
        .rfRdDataAOut (MEM_fwdDataA),
        .rfRdDataBOut (MEM_fwdDataB),
        .aluOutOut (MEM_aluOut),
        .brTakenOut (MEM_brTaken)
    );

    // Memory-WriteBackレジスタ
    Reg_MEM_WB regMEMWB(
        .clk (clk),
        .rst (rst),
        .flush (FALSE), // MEM/WBレジスタにはフラッシュ信号はないので，flush入力は不要
        .rfWrDataIn (MEM_rfWrData),
        .rfWrEnableIn (MEM_opInfo.rfWrEnable),
        .rfWrNumIn (MEM_opInfo.rfWrNum),
        .rfWrDataOut (WB_rfWrData),
        .rfWrEnableOut (WB_rfWrEnable),
        .rfWrNumOut (WB_rfWrNum)
    );

    // ======== 論理回路 ========

    always_comb begin
        // ======== Instruction Fetch ========

        // ======== Instruction Decode ========

        // ======== EXecute ========
        // ALU input selection and reverse for SUB
        EX_aluInA = EX_fwdDataA;
        if (EX_opInfo.isALUInImm) begin
            EX_aluInB = {{16{EX_opInfo.imm[15]}}, EX_opInfo.imm};
        end
        else begin
            EX_aluInB = EX_fwdDataB;
        end
        if (EX_opInfo.funct == SUB) begin
            EX_aluInB = -EX_aluInB;
        end

        // ======== MEMory ========
        // DMem write
        dataWrEnable = MEM_opInfo.isStore;
        dataAddr     = GET_ADDR(MEM_aluOut);
        dataOut      = MEM_fwdDataB;

        // Register write data selection
        if (MEM_opInfo.isJumpA | MEM_opInfo.isJumpR) begin
            MEM_rfWrData = {21'b0, MEM_insnAddr} + INSN_PC_INC;
        end
        else if (MEM_opInfo.isLoad) begin
            MEM_rfWrData = dataIn;
        end
        else begin
            MEM_rfWrData = MEM_aluOut;
        end

        // PC update
        if (MEM_opInfo.isJumpA) begin
            pcWrEnable = TRUE;
            pcIn = EXPAND_JMPADDR_2_INSNADDRPATH(MEM_opInfo.jmpAddr);
        end
        else if (MEM_opInfo.isJumpR) begin
            pcWrEnable = TRUE;
            pcIn = EXPAND_DATAPATH_2_INSNADDRPATH(MEM_fwdDataA);
        end
        else if (MEM_opInfo.isBranch) begin
            pcWrEnable = MEM_brTaken;
            pcIn = MEM_insnAddr + EXPAND_DISPLACEMENT_2_INSNADDRPATH(MEM_opInfo.imm);
        end
        else begin
            pcWrEnable = FALSE;
            pcIn = 11'b0;
        end

        // ======== Write Back ========
    end

endmodule
