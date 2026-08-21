	.file	"quicksort.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zmmul1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C23 (GCC) version 16.2.0 (riscv64-elf)
#	compiled by GNU C version Apple LLVM 16.0.0 (clang-1600.0.26.6), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mabi=ilp32 -misa-spec=20191213 -march=rv32im_zmmul -Og -fno-toplevel-reorder
	.text
	.globl	array
	.section	.srodata,"a"
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
# quicksort.c:11:     array[0] = 5;
	li	a5,8192		# tmp137,
	li	a4,5		# tmp138,
	sw	a4,0(a5)	# tmp138, MEM[(volatile int *)8192B]
# quicksort.c:12:     array[1] = 9;
	li	a4,9		# tmp141,
	sw	a4,4(a5)	# tmp141, MEM[(volatile int *)8196B]
# quicksort.c:13:     array[2] = 1;
	li	a4,1		# tmp144,
	sw	a4,8(a5)	# tmp144, MEM[(volatile int *)8200B]
# quicksort.c:14:     array[3] = 4;
	li	a4,4		# tmp147,
	sw	a4,12(a5)	# tmp147, MEM[(volatile int *)8204B]
# quicksort.c:15:     array[4] = 3;
	li	a4,3		# tmp150,
	sw	a4,16(a5)	# tmp150, MEM[(volatile int *)8208B]
# quicksort.c:16:     array[5] = 2;
	li	a4,2		# tmp153,
	sw	a4,20(a5)	# tmp153, MEM[(volatile int *)8212B]
# quicksort.c:17:     array[6] = 0;
	sw	zero,24(a5)	#, MEM[(volatile int *)8216B]
# quicksort.c:18:     array[7] = 8;
	li	a4,8		# tmp158,
	sw	a4,28(a5)	# tmp158, MEM[(volatile int *)8220B]
# quicksort.c:20:     sort(size);
	mv	a0,a4	#, tmp158
	call	sort		#
.L2:
	j	.L2		#
	.size	main, .-main
	.align	2
	.globl	swap
	.type	swap, @function
swap:
# quicksort.c:35:     int temp = array[i];
	slli	a0,a0,2	#, _2, i
	li	a5,8192		# tmp145,
	add	a0,a0,a5	# tmp145, _3, _2
# quicksort.c:35:     int temp = array[i];
	lw	a4,0(a0)		# temp, *_3
# quicksort.c:36:     array[i] = array[j];
	slli	a1,a1,2	#, _5, j
	add	a1,a1,a5	# tmp145, _6, _5
	lw	a5,0(a1)		# _7, *_6
# quicksort.c:36:     array[i] = array[j];
	sw	a5,0(a0)	# _7, *_3
# quicksort.c:37:     array[j] = temp;
	sw	a4,0(a1)	# temp, *_6
# quicksort.c:38: }
	ret	
	.size	swap, .-swap
	.align	2
	.globl	median3
	.type	median3, @function
median3:
# quicksort.c:49:     if (a < b) {
	bge	a0,a1,.L6	#, a, b,
# quicksort.c:50:         if (b < c) {
	blt	a1,a2,.L8	#, b, c,
# quicksort.c:52:         } else if (a < c) {
	bge	a0,a2,.L5	#, a, c,
# quicksort.c:53:             return c;
	mv	a0,a2	# <retval>, c
	ret	
.L6:
# quicksort.c:58:         if (a < c) {
	blt	a0,a2,.L5	#, a, c,
# quicksort.c:60:         } else if (b < c) {
	bge	a1,a2,.L11	#, b, c,
# quicksort.c:61:             return c;
	mv	a0,a2	# <retval>, c
	ret	
.L8:
# quicksort.c:51:             return b;
	mv	a0,a1	# <retval>, b
	ret	
.L11:
# quicksort.c:63:             return b;
	mv	a0,a1	# <retval>, b
.L5:
# quicksort.c:66: }
	ret	
	.size	median3, .-median3
	.align	2
	.globl	partition
	.type	partition, @function
partition:
# quicksort.c:69:     if (left >= right) {
	bge	a0,a1,.L23	#, left, right,
# quicksort.c:68: void partition(int left, int right) {
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s1,20(sp)	#,
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	sw	s4,8(sp)	#,
	mv	s1,a0	# left, left
	mv	s4,a1	# right, right
# quicksort.c:73:     int pivot_l = array[left];
	slli	a5,a0,2	#, _2, left
	li	a4,8192		# tmp163,
	add	a5,a5,a4	# tmp163, _3, _2
# quicksort.c:73:     int pivot_l = array[left];
	lw	a0,0(a5)		# pivot_l, *_3
# quicksort.c:74:     int pivot_r = array[right];
	slli	a5,a1,2	#, _5, right
	add	a5,a5,a4	# tmp163, _6, _5
# quicksort.c:74:     int pivot_r = array[right];
	lw	a2,0(a5)		# pivot_r, *_6
# quicksort.c:75:     int pivot_m = array[((right + left) >> 1)];
	add	a5,s1,a1	# right, _7, left
# quicksort.c:75:     int pivot_m = array[((right + left) >> 1)];
	srai	a5,a5,1	#, _9, _7
# quicksort.c:75:     int pivot_m = array[((right + left) >> 1)];
	slli	a5,a5,2	#, _10, _9
	add	a5,a5,a4	# tmp163, _11, _10
# quicksort.c:76:     int pivot = median3(pivot_l, pivot_m, pivot_r);
	lw	a1,0(a5)		#, *_11
	call	median3		#
	mv	s2,a0	# pivot, pivot
# quicksort.c:78:     int high = right;
	mv	s0,s4	# high, right
# quicksort.c:77:     int low = left;
	mv	s3,s1	# low, left
	j	.L14		#
.L16:
# quicksort.c:81:             low++;
	addi	s3,s3,1	#, low, low
	j	.L14		#
.L19:
# quicksort.c:87:             high--;
	addi	s0,s0,-1	#, high, high
.L17:
# quicksort.c:86:         while (left < high && array[high] > pivot) {
	ble	s0,s1,.L18	#, high, left,
# quicksort.c:86:         while (left < high && array[high] > pivot) {
	slli	a5,s0,2	#, _17, high
	li	a4,8192		# tmp171,
	add	a5,a5,a4	# tmp171, _18, _17
	lw	a5,0(a5)		# _19, *_18
# quicksort.c:86:         while (left < high && array[high] > pivot) {
	bgt	a5,s2,.L19	#, _19, pivot,
.L18:
# quicksort.c:89:         if (left >= high) {
	ble	s0,s1,.L12	#, high, left,
# quicksort.c:92:         if (low < high) {
	bge	s3,s0,.L20	#, low, high,
# quicksort.c:93:             swap(low, high);
	mv	a1,s0	#, high
	mv	a0,s3	#, low
	call	swap		#
.L14:
# quicksort.c:80:         while (low < right && array[low] < pivot) {
	bge	s3,s4,.L15	#, low, right,
# quicksort.c:80:         while (low < right && array[low] < pivot) {
	slli	a5,s3,2	#, _13, low
	li	a4,8192		# tmp169,
	add	a5,a5,a4	# tmp169, _14, _13
	lw	a5,0(a5)		# _15, *_14
# quicksort.c:80:         while (low < right && array[low] < pivot) {
	blt	a5,s2,.L16	#, _15, pivot,
.L15:
# quicksort.c:83:         if (low >= right) {
	blt	s3,s4,.L17	#, low, right,
.L12:
# quicksort.c:100: }
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	lw	s4,8(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
.L20:
# quicksort.c:95:             partition(left, high - 1);
	addi	a1,s0,-1	#,, high
	mv	a0,s1	#, left
	call	partition		#
# quicksort.c:96:             partition(high, right);
	mv	a1,s4	#, right
	mv	a0,s0	#, high
	call	partition		#
# quicksort.c:97:             return;
	j	.L12		#
.L23:
	ret	
	.size	partition, .-partition
	.align	2
	.globl	sort
	.type	sort, @function
sort:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# quicksort.c:112:     partition(0, size - 1);
	addi	a1,a0,-1	#,, size
	li	a0,0		#,
	call	partition		#
# quicksort.c:113: }
	lw	ra,12(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	sort, .-sort
	.ident	"GCC: (GNU) 16.2.0"
	.section	.note.GNU-stack,"",@progbits
