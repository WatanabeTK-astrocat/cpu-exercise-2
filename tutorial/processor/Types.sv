
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
typedef logic [OPCODE_WIDTH-1:0] OpcodePath;

// レジスタファイルのレジスタ番号の幅は 5bit (32レジスタ)
parameter REG_NUM_WIDTH = 5;
typedef logic [REG_NUM_WIDTH-1:0] RegNumPath;

// シフト量の幅は 5bit
parameter SHAMT_WIDTH = 5;
typedef logic [SHAMT_WIDTH-1:0] ShamtPath;

// ALUの演算コードであるfunctの幅は 6bit
parameter FUNCT_WIDTH = 6;
typedef logic [FUNCT_WIDTH-1:0] FunctPath;

// 即値の幅は 16bit
parameter IMMEDIATE_WIDTH = 16;
typedef logic [IMMEDIATE_WIDTH-1:0] ImmediatePath;

// ジャンプ命令のアドレスの幅は 26bit
parameter JUMP_ADDRESS_WIDTH = 26;
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
    BGE    = 'b010100,
    BGT    = 'b010111,
    BLE    = 'b010110,
    BLT    = 'b010101,
    // ジャンプ命令
    J      = 'b000010,
    JAL    = 'b000011
} opcode_e;

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
    SRA  = 'b000011,
    // ジャンプ命令 (ALUでは何もしない)
    JR   = 'b010000,
    JALR = 'b010001
} funct_e;

typedef struct packed {
    opcode_e opcode;
    RegNumPath rs;
    RegNumPath rt;
    RegNumPath rd;
    ShamtPath shamt;
    FunctPath funct;
    ImmediatePath imm;
    JumpAddressPath jmpAddr;
} OpInfo;

endpackage
