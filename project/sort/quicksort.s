	.file	"sort.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C23 (GCC) version 16.2.0 (riscv64-elf)
#	compiled by GNU C version Apple LLVM 16.0.0 (clang-1600.0.26.6), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mabi=ilp32 -misa-spec=20191213 -march=rv32i -O0 -ffreestanding
	.text
	.globl	array
	.bss
	.align	2
	.type	array, @object
	.size	array, 8192
array:
	.zero	8192
	.text
	.align	2
	.globl	swap
	.type	swap, @function
swap:
	addi	sp,sp,-48	#,,
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	addi	s0,sp,48	#,,
	mv	a5,a0	# tmp139, i
	mv	a4,a1	# tmp141, j
	sh	a5,-34(s0)	# tmp140, i
	mv	a5,a4	# tmp142, tmp141
	sh	a5,-36(s0)	# tmp142, j
# sort.c:13:     short temp = array[i];
	lh	a5,-34(s0)		# _1, i
# sort.c:13:     short temp = array[i];
	lui	a4,%hi(array)	# tmp143,
	addi	a4,a4,%lo(array)	# tmp144, tmp143,
	slli	a5,a5,1	#, tmp145, _1
	add	a5,a4,a5	# tmp145, tmp146, tmp144
	lhu	a5,0(a5)	# tmp147, array[_1]
	sh	a5,-18(s0)	# tmp147, temp
# sort.c:14:     array[i] = array[j];
	lh	a4,-36(s0)		# _2, j
# sort.c:14:     array[i] = array[j];
	lh	a5,-34(s0)		# _3, i
# sort.c:14:     array[i] = array[j];
	lui	a3,%hi(array)	# tmp148,
	addi	a3,a3,%lo(array)	# tmp149, tmp148,
	slli	a4,a4,1	#, tmp150, _2
	add	a4,a3,a4	# tmp150, tmp151, tmp149
	lh	a4,0(a4)		# _4, array[_2]
# sort.c:14:     array[i] = array[j];
	lui	a3,%hi(array)	# tmp152,
	addi	a3,a3,%lo(array)	# tmp153, tmp152,
	slli	a5,a5,1	#, tmp154, _3
	add	a5,a3,a5	# tmp154, tmp155, tmp153
	sh	a4,0(a5)	# _4, array[_3]
# sort.c:15:     array[j] = temp;
	lh	a5,-36(s0)		# _5, j
# sort.c:15:     array[j] = temp;
	lui	a4,%hi(array)	# tmp156,
	addi	a4,a4,%lo(array)	# tmp157, tmp156,
	slli	a5,a5,1	#, tmp158, _5
	add	a5,a4,a5	# tmp158, tmp159, tmp157
	lhu	a4,-18(s0)	# tmp160, temp
	sh	a4,0(a5)	# tmp160, array[_5]
# sort.c:16: }
	nop	
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	swap, .-swap
	.align	2
	.globl	median3
	.type	median3, @function
median3:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	addi	s0,sp,32	#,,
	mv	a5,a0	# tmp136, a
	mv	a3,a1	# tmp138, b
	mv	a4,a2	# tmp140, c
	sh	a5,-18(s0)	# tmp137, a
	mv	a5,a3	# tmp139, tmp138
	sh	a5,-20(s0)	# tmp139, b
	mv	a5,a4	# tmp141, tmp140
	sh	a5,-22(s0)	# tmp141, c
# sort.c:27:     if (a < b) {
	lh	a4,-18(s0)		# tmp142, a
	lh	a5,-20(s0)		# tmp143, b
	bge	a4,a5,.L3	#, tmp142, tmp143,
# sort.c:28:         if (b < c) {
	lh	a4,-20(s0)		# tmp144, b
	lh	a5,-22(s0)		# tmp145, c
	bge	a4,a5,.L4	#, tmp144, tmp145,
# sort.c:29:             return b;
	lh	a5,-20(s0)		# _1, b
	j	.L5		#
.L4:
# sort.c:30:         } else if (a < c) {
	lh	a4,-18(s0)		# tmp146, a
	lh	a5,-22(s0)		# tmp147, c
	bge	a4,a5,.L6	#, tmp146, tmp147,
# sort.c:31:             return c;
	lh	a5,-22(s0)		# _1, c
	j	.L5		#
.L6:
# sort.c:33:             return a;
	lh	a5,-18(s0)		# _1, a
	j	.L5		#
.L3:
# sort.c:36:         if (a < c) {
	lh	a4,-18(s0)		# tmp148, a
	lh	a5,-22(s0)		# tmp149, c
	bge	a4,a5,.L7	#, tmp148, tmp149,
# sort.c:37:             return a;
	lh	a5,-18(s0)		# _1, a
	j	.L5		#
.L7:
# sort.c:38:         } else if (b < c) {
	lh	a4,-20(s0)		# tmp150, b
	lh	a5,-22(s0)		# tmp151, c
	bge	a4,a5,.L8	#, tmp150, tmp151,
# sort.c:39:             return c;
	lh	a5,-22(s0)		# _1, c
	j	.L5		#
.L8:
# sort.c:41:             return b;
	lh	a5,-20(s0)		# _1, b
.L5:
# sort.c:44: }
	mv	a0,a5	#, <retval>
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	median3, .-median3
	.align	2
	.globl	partition
	.type	partition, @function
partition:
	addi	sp,sp,-48	#,,
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	addi	s0,sp,48	#,,
	mv	a5,a0	# tmp153, left
	mv	a4,a1	# tmp155, right
	sh	a5,-34(s0)	# tmp154, left
	mv	a5,a4	# tmp156, tmp155
	sh	a5,-36(s0)	# tmp156, right
# sort.c:47:     if (left >= right) {
	lh	a4,-34(s0)		# tmp157, left
	lh	a5,-36(s0)		# tmp158, right
	bge	a4,a5,.L22	#, tmp157, tmp158,
# sort.c:51:     short pivot_l = array[left];
	lh	a5,-34(s0)		# _1, left
# sort.c:51:     short pivot_l = array[left];
	lui	a4,%hi(array)	# tmp159,
	addi	a4,a4,%lo(array)	# tmp160, tmp159,
	slli	a5,a5,1	#, tmp161, _1
	add	a5,a4,a5	# tmp161, tmp162, tmp160
	lhu	a5,0(a5)	# tmp163, array[_1]
	sh	a5,-22(s0)	# tmp163, pivot_l
# sort.c:52:     short pivot_r = array[right];
	lh	a5,-36(s0)		# _2, right
# sort.c:52:     short pivot_r = array[right];
	lui	a4,%hi(array)	# tmp164,
	addi	a4,a4,%lo(array)	# tmp165, tmp164,
	slli	a5,a5,1	#, tmp166, _2
	add	a5,a4,a5	# tmp166, tmp167, tmp165
	lhu	a5,0(a5)	# tmp168, array[_2]
	sh	a5,-24(s0)	# tmp168, pivot_r
# sort.c:53:     short pivot_m = array[((right + left) >> 1)];
	lh	a4,-36(s0)		# _3, right
	lh	a5,-34(s0)		# _4, left
	add	a5,a4,a5	# _4, _5, _3
# sort.c:53:     short pivot_m = array[((right + left) >> 1)];
	srai	a5,a5,1	#, _6, _5
# sort.c:53:     short pivot_m = array[((right + left) >> 1)];
	lui	a4,%hi(array)	# tmp169,
	addi	a4,a4,%lo(array)	# tmp170, tmp169,
	slli	a5,a5,1	#, tmp171, _6
	add	a5,a4,a5	# tmp171, tmp172, tmp170
	lhu	a5,0(a5)	# tmp173, array[_6]
	sh	a5,-26(s0)	# tmp173, pivot_m
# sort.c:54:     short pivot = median3(pivot_l, pivot_m, pivot_r);
	lh	a3,-24(s0)		# tmp174, pivot_r
	lh	a4,-26(s0)		# tmp175, pivot_m
	lh	a5,-22(s0)		# tmp176, pivot_l
	mv	a2,a3	#, tmp174
	mv	a1,a4	#, tmp175
	mv	a0,a5	#, tmp176
	call	median3		#
	mv	a5,a0	# tmp177,
	sh	a5,-28(s0)	# tmp177, pivot
# sort.c:55:     short low = left;
	lhu	a5,-34(s0)	# tmp178, left
	sh	a5,-18(s0)	# tmp178, low
# sort.c:56:     short high = right;
	lhu	a5,-36(s0)	# tmp179, right
	sh	a5,-20(s0)	# tmp179, high
.L21:
# sort.c:58:         while (low < right && array[low] < pivot) {
	j	.L12		#
.L14:
# sort.c:59:             low++;
	lh	a5,-18(s0)		# low.0_7, low
	slli	a5,a5,16	#, low.1_8, low.0_7
	srli	a5,a5,16	#, low.1_8, low.1_8
	addi	a5,a5,1	#, tmp180, low.1_8
	slli	a5,a5,16	#, _9, tmp180
	srli	a5,a5,16	#, _9, _9
	sh	a5,-18(s0)	# _9, low
.L12:
# sort.c:58:         while (low < right && array[low] < pivot) {
	lh	a4,-18(s0)		# tmp181, low
	lh	a5,-36(s0)		# tmp182, right
	bge	a4,a5,.L13	#, tmp181, tmp182,
# sort.c:58:         while (low < right && array[low] < pivot) {
	lh	a5,-18(s0)		# _10, low
	lui	a4,%hi(array)	# tmp183,
	addi	a4,a4,%lo(array)	# tmp184, tmp183,
	slli	a5,a5,1	#, tmp185, _10
	add	a5,a4,a5	# tmp185, tmp186, tmp184
	lh	a5,0(a5)		# _11, array[_10]
# sort.c:58:         while (low < right && array[low] < pivot) {
	lh	a4,-28(s0)		# tmp187, pivot
	bgt	a4,a5,.L14	#, tmp187, _11,
.L13:
# sort.c:61:         if (low >= right) {
	lh	a4,-18(s0)		# tmp188, low
	lh	a5,-36(s0)		# tmp189, right
	bge	a4,a5,.L23	#, tmp188, tmp189,
# sort.c:64:         while (left < high && array[high] > pivot) {
	j	.L16		#
.L18:
# sort.c:65:             high--;
	lh	a5,-20(s0)		# high.2_12, high
	slli	a5,a5,16	#, high.3_13, high.2_12
	srli	a5,a5,16	#, high.3_13, high.3_13
	addi	a5,a5,-1	#, tmp190, high.3_13
	slli	a5,a5,16	#, _14, tmp190
	srli	a5,a5,16	#, _14, _14
	sh	a5,-20(s0)	# _14, high
.L16:
# sort.c:64:         while (left < high && array[high] > pivot) {
	lh	a4,-34(s0)		# tmp191, left
	lh	a5,-20(s0)		# tmp192, high
	bge	a4,a5,.L17	#, tmp191, tmp192,
# sort.c:64:         while (left < high && array[high] > pivot) {
	lh	a5,-20(s0)		# _15, high
	lui	a4,%hi(array)	# tmp193,
	addi	a4,a4,%lo(array)	# tmp194, tmp193,
	slli	a5,a5,1	#, tmp195, _15
	add	a5,a4,a5	# tmp195, tmp196, tmp194
	lh	a5,0(a5)		# _16, array[_15]
# sort.c:64:         while (left < high && array[high] > pivot) {
	lh	a4,-28(s0)		# tmp197, pivot
	blt	a4,a5,.L18	#, tmp197, _16,
.L17:
# sort.c:67:         if (left >= high) {
	lh	a4,-34(s0)		# tmp198, left
	lh	a5,-20(s0)		# tmp199, high
	bge	a4,a5,.L24	#, tmp198, tmp199,
# sort.c:70:         if (low < high) {
	lh	a4,-18(s0)		# tmp200, low
	lh	a5,-20(s0)		# tmp201, high
	bge	a4,a5,.L20	#, tmp200, tmp201,
# sort.c:71:             swap(low, high);
	lh	a4,-20(s0)		# tmp202, high
	lh	a5,-18(s0)		# tmp203, low
	mv	a1,a4	#, tmp202
	mv	a0,a5	#, tmp203
	call	swap		#
# sort.c:58:         while (low < right && array[low] < pivot) {
	j	.L21		#
.L20:
# sort.c:73:             partition(left, high - 1);
	lhu	a5,-20(s0)	# high.4_17, high
	addi	a5,a5,-1	#, tmp204, high.4_17
	slli	a5,a5,16	#, _18, tmp204
	srli	a5,a5,16	#, _18, _18
# sort.c:73:             partition(left, high - 1);
	slli	a4,a5,16	#, _19, _18
	srai	a4,a4,16	#, _19, _19
	lh	a5,-34(s0)		# tmp205, left
	mv	a1,a4	#, _19
	mv	a0,a5	#, tmp205
	call	partition		#
# sort.c:74:             partition(high, right);
	lh	a4,-36(s0)		# tmp206, right
	lh	a5,-20(s0)		# tmp207, high
	mv	a1,a4	#, tmp206
	mv	a0,a5	#, tmp207
	call	partition		#
# sort.c:75:             return;
	j	.L9		#
.L22:
# sort.c:48:         return;
	nop	
	j	.L9		#
.L23:
# sort.c:62:             return;
	nop	
	j	.L9		#
.L24:
# sort.c:68:             return;
	nop	
.L9:
# sort.c:78: }
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	partition, .-partition
	.align	2
	.globl	sort
	.type	sort, @function
sort:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	addi	s0,sp,32	#,,
	mv	a5,a0	# tmp137, size
	sh	a5,-18(s0)	# tmp138, size
# sort.c:90:     partition(0, size - 1);
	lhu	a5,-18(s0)	# size.5_1, size
	addi	a5,a5,-1	#, tmp139, size.5_1
	slli	a5,a5,16	#, _2, tmp139
	srli	a5,a5,16	#, _2, _2
# sort.c:90:     partition(0, size - 1);
	slli	a5,a5,16	#, _3, _2
	srai	a5,a5,16	#, _3, _3
	mv	a1,a5	#, _3
	li	a0,0		#,
	call	partition		#
# sort.c:91: }
	nop	
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	sort, .-sort
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48	#,,
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	addi	s0,sp,48	#,,
	sw	a0,-36(s0)	# argc, argc
	sw	a1,-40(s0)	# argv, argv
# sort.c:94:     short size = 8;
	li	a5,8		# tmp136,
	sh	a5,-18(s0)	# tmp136, size
# sort.c:96:     array[0] = 5;
	lui	a5,%hi(array)	# tmp137,
	addi	a5,a5,%lo(array)	# tmp138, tmp137,
	li	a4,5		# tmp139,
	sh	a4,0(a5)	# tmp139, array[0]
# sort.c:97:     array[1] = 9;
	lui	a5,%hi(array)	# tmp140,
	addi	a5,a5,%lo(array)	# tmp141, tmp140,
	li	a4,9		# tmp142,
	sh	a4,2(a5)	# tmp142, array[1]
# sort.c:98:     array[2] = 1;
	lui	a5,%hi(array)	# tmp143,
	addi	a5,a5,%lo(array)	# tmp144, tmp143,
	li	a4,1		# tmp145,
	sh	a4,4(a5)	# tmp145, array[2]
# sort.c:99:     array[3] = 4;
	lui	a5,%hi(array)	# tmp146,
	addi	a5,a5,%lo(array)	# tmp147, tmp146,
	li	a4,4		# tmp148,
	sh	a4,6(a5)	# tmp148, array[3]
# sort.c:100:     array[4] = 3;
	lui	a5,%hi(array)	# tmp149,
	addi	a5,a5,%lo(array)	# tmp150, tmp149,
	li	a4,3		# tmp151,
	sh	a4,8(a5)	# tmp151, array[4]
# sort.c:101:     array[5] = 2;
	lui	a5,%hi(array)	# tmp152,
	addi	a5,a5,%lo(array)	# tmp153, tmp152,
	li	a4,2		# tmp154,
	sh	a4,10(a5)	# tmp154, array[5]
# sort.c:102:     array[6] = 0;
	lui	a5,%hi(array)	# tmp155,
	addi	a5,a5,%lo(array)	# tmp156, tmp155,
	sh	zero,12(a5)	#, array[6]
# sort.c:103:     array[7] = 8;
	lui	a5,%hi(array)	# tmp157,
	addi	a5,a5,%lo(array)	# tmp158, tmp157,
	li	a4,8		# tmp159,
	sh	a4,14(a5)	# tmp159, array[7]
# sort.c:105:     sort(size);
	lh	a5,-18(s0)		# tmp160, size
	mv	a0,a5	#, tmp160
	call	sort		#
# sort.c:107:     return 0;
	li	a5,0		# _12,
# sort.c:108: }
	mv	a0,a5	#, <retval>
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	main, .-main
	.ident	"GCC: (GNU) 16.2.0"
	.section	.note.GNU-stack,"",@progbits
