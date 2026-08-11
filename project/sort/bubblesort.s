main:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# bubblesort.c:9:     array[0] = 5;
	li	a5,8192		# tmp137,
	li	a3,5		# tmp138,
	sh	a3,0(a5)	# tmp138, MEM[(volatile short int *)8192B]
# bubblesort.c:10:     array[1] = 9;
	li	a3,9		# tmp141,
	sh	a3,2(a5)	# tmp141, MEM[(volatile short int *)8194B]
# bubblesort.c:11:     array[2] = 1;
	li	a3,1		# tmp144,
	sh	a3,4(a5)	# tmp144, MEM[(volatile short int *)8196B]
# bubblesort.c:12:     array[3] = 4;
	li	a3,4		# tmp147,
	sh	a3,6(a5)	# tmp147, MEM[(volatile short int *)8198B]
# bubblesort.c:13:     array[4] = 3;
	li	a3,3		# tmp150,
	sh	a3,8(a5)	# tmp150, MEM[(volatile short int *)8200B]
# bubblesort.c:14:     array[5] = 2;
	li	a3,2		# tmp153,
	sh	a3,10(a5)	# tmp153, MEM[(volatile short int *)8202B]
# bubblesort.c:15:     array[6] = 0;
	sh	zero,12(a5)	#, MEM[(volatile short int *)8204B]
# bubblesort.c:16:     array[7] = 8;
	li	a0,8		# tmp158,
	li	a5,8192		# tmp166,
	sh	a0,14(a5)	# tmp158, MEM[(volatile short int *)8206B]
# bubblesort.c:18:     sort(size);
	call	sort		#
# bubblesort.c:21: }
	lw	ra,12(sp)		#,
	li	a0,0		#,
	addi	sp,sp,16	#,,
	jr	ra		#
sort:
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	li	t1,1		# tmp152,
	ble	a0,t1,.L1	#, _35, tmp152,
	li	a7,4096		# tmp159,
	addi	a7,a7,-1	#, tmp160, tmp159
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	addi	t3,a0,-1	#, _36, _35
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	li	a6,0		# i,
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	li	a5,0		# _17,
.L3:
# bubblesort.c:33:         for (j = 0; j < size - i - 1; j++) {
	sub	a4,a0,a5	# _40, _35, _17
	add	a1,a4,a7	# tmp160, _38, _40
	slli	a1,a1,1	#, _37, _38
# bubblesort.c:33:         for (j = 0; j < size - i - 1; j++) {
	li	a5,8192		# ivtmp.13,
	beq	a4,t1,.L7	#, _40, tmp152,
.L5:
# bubblesort.c:34:             if (array[j] > array[j + 1]) {
	lh	a2,0(a5)		# _4, *_3
	mv	a4,a5	# _3, ivtmp.13
	addi	a5,a5,2	#, ivtmp.13, ivtmp.13
# bubblesort.c:34:             if (array[j] > array[j + 1]) {
	lh	a3,0(a5)		# _8, *_7
# bubblesort.c:34:             if (array[j] > array[j + 1]) {
	ble	a2,a3,.L4	#, _4, _8,
# bubblesort.c:35:                 short temp = array[j];
	lh	a3,0(a4)		# temp, *_3
# bubblesort.c:36:                 array[j] = array[j + 1];
	lh	a2,0(a5)		# _9, *_7
# bubblesort.c:36:                 array[j] = array[j + 1];
	sh	a2,0(a4)	# _9, *_3
# bubblesort.c:37:                 array[j + 1] = temp;
	sh	a3,0(a5)	# temp, *_7
.L4:
# bubblesort.c:33:         for (j = 0; j < size - i - 1; j++) {
	bne	a1,a5,.L5	#, _37, ivtmp.13,
.L7:
	addi	a4,a6,1	#, tmp157, i
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	slli	a5,a4,16	#, _17, tmp157
	srli	a5,a5,16	#, _17, _17
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	mv	a6,a5	# i, _17
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	blt	a5,t3,.L3	#, _17, _36,
.L1:
# bubblesort.c:41: }
	ret	
	.size	sort, .-sort
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
