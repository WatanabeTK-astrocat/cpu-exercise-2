	.file	"sum.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zmmul1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C23 (GCC) version 16.2.0 (riscv64-elf)
#	compiled by GNU C version Apple LLVM 16.0.0 (clang-1600.0.26.6), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mabi=ilp32 -misa-spec=20191213 -march=rv32im_zmmul -Og -fno-toplevel-reorder
	.text
	.globl	sum_loc
	.section	.srodata,"a"
	.align	2
	.type	sum_loc, @object
	.size	sum_loc, 4
sum_loc:
	.word	4096
	.globl	array
	.align	2
	.type	array, @object
	.size	array, 4
array:
	.word	8192
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# sum.c:13:     array[0] = 5;
	li	a5,8192		# tmp138,
	li	a4,5		# tmp139,
	sw	a4,0(a5)	# tmp139, MEM[(volatile int *)8192B]
# sum.c:14:     array[1] = 9;
	li	a4,9		# tmp142,
	sw	a4,4(a5)	# tmp142, MEM[(volatile int *)8196B]
# sum.c:15:     array[2] = 1;
	li	a4,1		# tmp145,
	sw	a4,8(a5)	# tmp145, MEM[(volatile int *)8200B]
# sum.c:16:     array[3] = 4;
	li	a4,4		# tmp148,
	sw	a4,12(a5)	# tmp148, MEM[(volatile int *)8204B]
# sum.c:17:     array[4] = 3;
	li	a4,3		# tmp151,
	sw	a4,16(a5)	# tmp151, MEM[(volatile int *)8208B]
# sum.c:18:     array[5] = 2;
	li	a4,2		# tmp154,
	sw	a4,20(a5)	# tmp154, MEM[(volatile int *)8212B]
# sum.c:19:     array[6] = 0;
	sw	zero,24(a5)	#, MEM[(volatile int *)8216B]
# sum.c:20:     array[7] = 8;
	li	a4,8		# tmp159,
	sw	a4,28(a5)	# tmp159, MEM[(volatile int *)8220B]
# sum.c:22:     int sum = sum_array(size);
	mv	a0,a4	#, tmp159
	call	sum_array		#
# sum.c:25:     *sum_loc = sum;  // Write the sum to the memory-mapped I/O address
	li	a5,4096		# tmp160,
	sw	a0,0(a5)	# sum, MEM[(volatile int *)4096B]
.L2:
	j	.L2		#
	.size	main, .-main
	.align	2
	.globl	sum_array
	.type	sum_array, @function
sum_array:
	mv	a2,a0	# size, size
# sum.c:35:     for (int i = 0; i < size; i++) {
	li	a5,0		# i,
# sum.c:34:     int sum = 0;
	li	a0,0		# <retval>,
# sum.c:35:     for (int i = 0; i < size; i++) {
	j	.L5		#
.L6:
# sum.c:36:         sum += array[i];
	slli	a4,a5,2	#, _2, i
	li	a3,8192		# tmp142,
	add	a4,a4,a3	# tmp142, _3, _2
	lw	a4,0(a4)		# _8, *_3
# sum.c:36:         sum += array[i];
	add	a0,a0,a4	# _8, <retval>, <retval>
# sum.c:35:     for (int i = 0; i < size; i++) {
	addi	a5,a5,1	#, i, i
.L5:
# sum.c:35:     for (int i = 0; i < size; i++) {
	blt	a5,a2,.L6	#, i, size,
# sum.c:39: }
	ret	
	.size	sum_array, .-sum_array
	.ident	"GCC: (GNU) 16.2.0"
	.section	.note.GNU-stack,"",@progbits
