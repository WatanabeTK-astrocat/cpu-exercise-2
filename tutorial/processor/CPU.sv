
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

    input  InsnPath     inst,           // 命令メモリからの入力
    input  DataPath     dataIn          // 読み出しデータ入力
                                        // dataAddr で指定したアドレスから読んだ値が入力される．
);
	
    // ======== 制御線・データ線 ========
    // PC
    InsnAddrPath pcIn;          // 外部書き込みをする時のアドレス
    logic        pcWrEnable;    // 外部書き込み有効
    InsnAddrPath pcOut;         // アドレス出力
    
    // IMem
    InsnPath imemInstCode;      // 命令コード
    
    // Decoder
    OpInfo dcOpinfo;

    // レジスタ・ファイル
    DataPath    rfRdDataA;  // 読み出しデータ rs
    DataPath    rfRdDataB;  // 読み出しデータ rt
    DataPath    rfWrData;   // 書き込みデータ
    RegNumPath  rfWrNum;    // 書き込み番号
    logic       rfWrEnable; // 書き込み制御 1の場合，書き込みを行う
    
    // ALU
    DataPath aluInA;           // ALU 入力A
    DataPath aluInB;           // ALU 入力B
    DataPath aluOut;           // ALU 出力
    
    // Branch
    //logic brTaken;

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
    /* Decoder decoder(
        .opInfo (dcOpinfo),
        .insnCode (imemInsnCode)
    ); */
    
    // RegisterFile
    /* RegisterFile regFile(
        .clk (clk),
        .rdDataA (rfRdDataA),
        .rdDataB (rfRdDataB),
        .rdNumA (dcOpinfo.rs1),
        .rdNumB (dcOpinfo.rs2),
        .wrData (rfWrData),
        .wrNum (rfWrNum),
        .wrEnable (dcOpinfo.regWrEnable)
    ); */
    
    // ALU
    /* ALU alu(
        .aluOut (aluOut),
        .aluInA (aluInA),
        .aluInB (aluInB),
        .shamt (dcOpinfo.shamt),
        .funct (dcOpinfo.funct)
    ); */

    always_comb begin
        // IMem
        imemInstCode = inst;
        insnAddr     = pcOut;

        /* if (dcOpinfo.isJump) begin
            pcWrEnable = TRUE;
        end
        else if (dcOpinfo.isBranch) begin
            pcWrEnable = brTaken;
        end
        else begin
            pcWrEnable = FALSE;
        end
        pcIn = pcOut + EXPAND_BR_DISPLACEMENT(dcOpinfo.imm); */
        pcIn = pcOut + INSN_PC_INC;
    end

endmodule
