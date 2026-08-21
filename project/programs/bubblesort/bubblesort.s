	.attribute	4, 16
	.attribute	5, "rv32i2p1"
	.file	"bubblesort.c"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	li	a0, 0
	lui	a2, 2
	li	a1, 5
	li	a3, 9
	sw	a1, 0(a2)
	li	a4, 1
	sw	a3, 4(a2)
	addi	a1, a2, 4
	sw	a4, 4(a1)
	li	a3, 4
	sw	a3, 8(a1)
	li	a3, 3
	sw	a3, 12(a1)
	li	a3, 2
	sw	a3, 16(a1)
	li	a3, 8
	addi	a2, a2, 32
	sw	zero, 20(a1)
	sw	a3, 24(a1)
	li	a3, 7
	j	.LBB0_2
.LBB0_1:                                #   in Loop: Header=BB0_2 Depth=1
	addi	a0, a0, 1
	beq	a0, a3, .LBB0_6
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_4 Depth 2
	slli	a4, a0, 2
	sub	a4, a2, a4
	mv	a5, a1
	j	.LBB0_4
.LBB0_3:                                #   in Loop: Header=BB0_4 Depth=2
	addi	a5, a5, 4
	beq	a5, a4, .LBB0_1
.LBB0_4:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a6, -4(a5)
	lw	a7, 0(a5)
	bge	a7, a6, .LBB0_3
# %bb.5:                                #   in Loop: Header=BB0_4 Depth=2
	lw	a6, -4(a5)
	lw	a7, 0(a5)
	sw	a7, -4(a5)
	sw	a6, 0(a5)
	j	.LBB0_3
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
	j	.LBB0_6
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.globl	sort                            # -- Begin function sort
	.p2align	2
	.type	sort,@function
sort:                                   # @sort
# %bb.0:
	li	a1, 2
	blt	a0, a1, .LBB1_9
# %bb.1:
	li	a2, 0
	addi	a1, a0, -1
	li	a3, -2
	lui	a4, 2
	addi	a4, a4, 4
	mv	a5, a1
	j	.LBB1_4
.LBB1_2:                                #   in Loop: Header=BB1_4 Depth=1
	li	a6, 0
.LBB1_3:                                #   in Loop: Header=BB1_4 Depth=1
	addi	a2, a2, 1
	addi	a5, a5, -1
	beq	a2, a1, .LBB1_10
.LBB1_4:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_7 Depth 2
	sub	a6, a2, a0
	blt	a3, a6, .LBB1_2
# %bb.5:                                #   in Loop: Header=BB1_4 Depth=1
	li	a6, 0
	mv	a7, a4
	j	.LBB1_7
.LBB1_6:                                #   in Loop: Header=BB1_7 Depth=2
	addi	a6, a6, 1
	addi	a7, a7, 4
	beq	a5, a6, .LBB1_3
.LBB1_7:                                #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	t0, -4(a7)
	lw	t1, 0(a7)
	bge	t1, t0, .LBB1_6
# %bb.8:                                #   in Loop: Header=BB1_7 Depth=2
	lw	t0, -4(a7)
	lw	t1, 0(a7)
	sw	t1, -4(a7)
	sw	t0, 0(a7)
                                        # fake_use: $x5
	j	.LBB1_6
.LBB1_9:
	li	a1, 0
                                        # implicit-def: $x16
.LBB1_10:
                                        # fake_use: $x16
                                        # fake_use: $x11
                                        # fake_use: $x10
	ret
.Lfunc_end1:
	.size	sort, .Lfunc_end1-sort
                                        # -- End function
	.type	array,@object                   # @array
	.section	.rodata,"a",@progbits
	.globl	array
	.p2align	2, 0x0
array:
	.word	8192
	.size	array, 4

	.ident	"Homebrew clang version 22.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
