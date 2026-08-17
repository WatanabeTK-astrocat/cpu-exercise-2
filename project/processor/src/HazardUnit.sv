//
// ハザード検出ユニット
//

import BasicTypes::*;
import Types::*;

module HazardUnit(
    input OpInfo        ID_opInfoIn,    // デコードステージにおける命令情報
                                        // FDレジスタにはこの情報は入らない; FDレジスタの後にデコードが入るため、
                                        // デコードされた直後のものをそのまま入れるだけで良い
    input OpInfo        EX_opInfoIn,    // 実行ステージにおける命令情報
    input OpInfo        MEM_opInfoIn,   // メモリステージにおける命令情報
    input logic         MEM_brTaken,    // メモリステージにおける条件分岐成立フラグ（1で成立）

    output logic        IF_stall,       // IFステージ ストール信号（1でPCを保持）
    output logic        IF_ID_flush,    // IF/IDレジスタ フラッシュ信号（1でIF/IDレジスタをリセット）
    output logic        ID_EX_flush,    // ID/EXレジスタ フラッシュ信号（1でID/EXレジスタをリセット）
    output logic        EX_MEM_flush,   // EX/MEMレジスタ フラッシュ信号（1でEX/MEMレジスタをリセット）
    output OpInfo       ID_opInfoOut    // デコードステージにおける命令情報
);

    always_comb begin
        // デフォルト値
        IF_stall = FALSE;
        IF_ID_flush = FALSE;
        ID_EX_flush = FALSE;
        EX_MEM_flush = FALSE;
        ID_opInfoOut = ID_opInfoIn;

        // ======== ストール判定 ========
        if (EX_opInfoIn.isLoad && (
            (EX_opInfoIn.rt != 0) && ((EX_opInfoIn.rt == ID_opInfoIn.rs) || (EX_opInfoIn.rt == ID_opInfoIn.rt))
        )) begin
            // Load-use hazard
            IF_stall = TRUE;
            ID_opInfoOut = '0; // ID/EXレジスタの出力を0にしておく
        end
        if (ID_opInfoIn.isJumpA) begin
            // JumpA hazard
            IF_stall = TRUE;
            IF_ID_flush = TRUE;
        end
        if (MEM_opInfoIn.isJumpR || (MEM_opInfoIn.isBranch && MEM_brTaken)) begin
            // Branch hazard (常に分岐しないと予測するため、分岐が成立した場合はフラッシュする)
            ID_opInfoOut = '0; // ID/EXレジスタの出力を0にしておく
            IF_ID_flush = TRUE;
            ID_EX_flush = TRUE;
            EX_MEM_flush = TRUE;
        end

    end

endmodule
