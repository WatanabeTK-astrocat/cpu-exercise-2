
package Types;

// 基本的な定数や型の定義
import BasicTypes::*;

// ここより下に，各人の定義を追加してください

// ======== 命令セット形式 ========
// 命令幅は32bit (BasicTypes.sv で定義済み)

// 
// 命令セットアーキテクチャはMIPSをベースに独自の拡張を加えたものとする．
//
// R 形式
// 31:26         | 25:21     | 20:16     | 15:11     | 10:6         | 5:0
// opcode (6bit) | rs (5bit) | rt (5bit) | rd (5bit) | shamt (5bit) | funct (6bit)
//
// I 形式
// opcode (6bit) | rs (5bit) | rt (5bit) | immediate (16bit)
//
// J 形式
// opcode (6bit) | address (26bit)
//

// operation code の幅は 6bit
parameter OPCODE_WIDTH = 6;
parameter OPCODE_POS   = 31;
typedef logic [OPCODE_WIDTH-1:0] OpcodePath;

// レジスタファイルのレジスタ番号の幅は 5bit (32レジスタ)
parameter REG_NUM_WIDTH = 5;
parameter REG_FILE_SIZE = 2 ** REG_NUM_WIDTH;
parameter REG_RS_POS = 25;
parameter REG_RT_POS = 20;
parameter REG_RD_POS = 15;
typedef logic [REG_NUM_WIDTH-1:0] RegNumPath;

// シフト量の幅は 5bit
parameter SHAMT_WIDTH = 5;
parameter SHAMT_POS   = 10;
typedef logic [SHAMT_WIDTH-1:0] ShamtPath;

// ALUの演算コードであるfunctの幅は 6bit
parameter FUNCT_WIDTH = 6;
parameter FUNCT_POS   = 5;
typedef logic [FUNCT_WIDTH-1:0] FunctPath;

// 即値の幅は 16bit
parameter IMMEDIATE_WIDTH = 16;
parameter IMMEDIATE_POS   = 15;
typedef logic [IMMEDIATE_WIDTH-1:0] ImmediatePath;

// ジャンプ命令のアドレスの幅は 26bit
parameter JUMP_ADDRESS_WIDTH = 26;
parameter JUMP_ADDRESS_POS   = 25;
typedef logic [JUMP_ADDRESS_WIDTH-1:0] JumpAddressPath;


// ======== opcodeの定義 ========
typedef enum OpcodePath {
    // R 形式
    R_TYPE = 'b000000,
    // 算術命令
    ADDI   = 'b001000,
    SUBI   = 'b001001,
    // 論理命令
    ANDI   = 'b001100,
    ORI    = 'b001101,
    XORI   = 'b001110,
    SLTI   = 'b001010,
    // (シフト命令): 全部R形式
    // データ転送命令
    LW     = 'b100011,
    SW     = 'b101011,
    LH     = 'b100001,
    SH     = 'b101001,
    LB     = 'b100000,
    SB     = 'b101000,
    // 条件分岐命令
    BEQ    = 'b010000,
    BNE    = 'b010001,
    BLT    = 'b010100,
    BGE    = 'b010101,
    BLTU   = 'b010110,
    BGEU   = 'b010111,
    // ジャンプ命令
    J      = 'b000010,
    JAL    = 'b000011,
    JR     = 'b000100,
    JALR   = 'b000101
} OpcodeEnum;

// TODO: システムコール命令の定義を追加すること

// ======== ALU のコード funct の定義 ========
typedef enum FunctPath {
    // 算術操作
    ADD  = 'b100000,
    SUB  = 'b100010,
    // 論理操作
    AND  = 'b100100,
    OR   = 'b100101,
    XOR  = 'b100110,
    NOR  = 'b100111,
    SLT  = 'b101010,
    // シフト操作
    SLL  = 'b000000,
    SRL  = 'b000010,
    SRA  = 'b000011
} FunctEnum;

// ======== デコードされた命令情報の構造体 ========
typedef struct packed {
    OpcodeEnum opcode;
    RegNumPath rs;
    RegNumPath rt;
    RegNumPath rd;
    ShamtPath shamt;
    FunctEnum funct;
    ImmediatePath imm;
    JumpAddressPath jmpAddr;
    logic isALUInImm;   // ALUの第2オペランドが即値かどうか
    RegNumPath regWrNum;     // 書き込み先レジスタ番号
    logic regWrEnable;  // レジスタ書き込み有効かどうか
    logic isLoad;       // メモリからのロード命令かどうか
    logic isStore;      // メモリへのストア命令かどうか
    logic isBranch;     // 分岐命令かどうか
    logic isJump;       // ジャンプ命令かどうか
} OpInfo;

// ======== 特殊レジスタ ========
parameter REG_ZERO = 5'b00000; // 常に0を返すレジスタ
parameter REG_RA   = 5'b11111; // リターンアドレスを格納するレジスタ

// ======== 便利関数 ========
// constant を InsnAddrPath の幅にまで符号拡張する
// InsnAddrPath が小さいので，上を取り出す
function automatic InsnAddrPath EXPAND_BR_DISPLACEMENT(
    input ImmediatePath disp
);
    return { disp[ INSN_ADDR_WIDTH-1 : 0 ] };
endfunction

endpackage
