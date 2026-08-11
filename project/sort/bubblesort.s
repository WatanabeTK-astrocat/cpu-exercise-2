main:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# bubblesort.c:12:     array[0] = 5;
	li	a5,8192		# tmp137,
	li	a4,5		# tmp138,
	sh	a4,0(a5)	# tmp138, MEM[(volatile short int *)8192B]
# bubblesort.c:13:     array[1] = 9;
	li	a4,9		# tmp141,
	sh	a4,2(a5)	# tmp141, MEM[(volatile short int *)8194B]
# bubblesort.c:14:     array[2] = 1;
	li	a4,1		# tmp144,
	sh	a4,4(a5)	# tmp144, MEM[(volatile short int *)8196B]
# bubblesort.c:15:     array[3] = 4;
	li	a4,4		# tmp147,
	sh	a4,6(a5)	# tmp147, MEM[(volatile short int *)8198B]
# bubblesort.c:16:     array[4] = 3;
	li	a4,3		# tmp150,
	sh	a4,8(a5)	# tmp150, MEM[(volatile short int *)8200B]
# bubblesort.c:17:     array[5] = 2;
	li	a4,2		# tmp153,
	sh	a4,10(a5)	# tmp153, MEM[(volatile short int *)8202B]
# bubblesort.c:18:     array[6] = 0;
	sh	zero,12(a5)	#, MEM[(volatile short int *)8204B]
# bubblesort.c:19:     array[7] = 8;
	li	a4,8		# tmp158,
	sh	a4,14(a5)	# tmp158, MEM[(volatile short int *)8206B]
# bubblesort.c:21:     sort(size);
	mv	a0,a4	#, tmp158
	call	sort		#
.L10:
	j	.L10		#
sort:
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	li	a7,0		# i,
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	j	.L2		#
.L3:
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	addi	a5,a5,1	#, tmp162, j
	slli	a5,a5,16	#, j, tmp162
	srai	a5,a5,16	#, j, j
.L5:
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	sub	a4,a0,a6	# _13, size, _17
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	addi	a4,a4,-1	#, _14, _13
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	bge	a5,a4,.L7	#, j, _14,
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	slli	a3,a5,1	#, _2, j
	li	a2,8192		# tmp158,
	add	a3,a3,a2	# tmp158, _3, _2
	lh	a1,0(a3)		# _4, *_3
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	addi	a4,a5,1	#, _5, j
	slli	a4,a4,1	#, _6, _5
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	add	a4,a4,a2	# tmp158, _7, _6
	lh	a2,0(a4)		# _8, *_7
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	ble	a1,a2,.L3	#, _4, _8,
# bubblesort.c:47:                 short temp = array[j];
	lh	a2,0(a3)		# temp, *_3
# bubblesort.c:48:                 array[j] = array[j + 1];
	lh	a1,0(a4)		# _9, *_7
# bubblesort.c:48:                 array[j] = array[j + 1];
	sh	a1,0(a3)	# _9, *_3
# bubblesort.c:49:                 array[j + 1] = temp;
	sh	a2,0(a4)	# temp, *_7
	j	.L3		#
.L7:
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	addi	a7,a7,1	#, tmp164, i
	slli	a7,a7,16	#, i, tmp164
	srai	a7,a7,16	#, i, i
.L2:
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	mv	a6,a7	# _17, i
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	addi	a5,a0,-1	#, _19, size
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	bge	a7,a5,.L8	#, i, _19,
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	li	a5,0		# j,
	j	.L5		#
.L8:
# bubblesort.c:53: }
	ret	