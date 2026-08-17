main:
# bubblesort.c:12:     array[0] = 5;
	li	a5,8192		# tmp137,
	li	a4,5		# tmp138,
	sw	a4,0(a5)	# tmp138, MEM[(volatile int *)8192B]
# bubblesort.c:13:     array[1] = 9;
	li	a4,9		# tmp141,
	sw	a4,4(a5)	# tmp141, MEM[(volatile int *)8196B]
# bubblesort.c:14:     array[2] = 1;
	li	a4,1		# tmp144,
	sw	a4,8(a5)	# tmp144, MEM[(volatile int *)8200B]
# bubblesort.c:15:     array[3] = 4;
	li	a4,4		# tmp147,
	sw	a4,12(a5)	# tmp147, MEM[(volatile int *)8204B]
# bubblesort.c:16:     array[4] = 3;
	li	a4,3		# tmp150,
	sw	a4,16(a5)	# tmp150, MEM[(volatile int *)8208B]
# bubblesort.c:17:     array[5] = 2;
	li	a4,2		# tmp153,
	sw	a4,20(a5)	# tmp153, MEM[(volatile int *)8212B]
# bubblesort.c:18:     array[6] = 0;
	sw	zero,24(a5)	#, MEM[(volatile int *)8216B]
# bubblesort.c:19:     array[7] = 8;
	li	a4,8		# tmp158,
	sw	a4,28(a5)	# tmp158, MEM[(volatile int *)8220B]
# bubblesort.c:21:     sort(size);
	mv	a0,a4	#, tmp158
	call	sort		#
.L10:
	j	.L10		#
sort:
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	li	a6,0		# i,
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	j	.L2		#
.L3:
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	addi	a4,a4,1	#, j, j
.L5:
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	sub	a5,a0,a6	# _10, size, i
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	addi	a5,a5,-1	#, _11, _10
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	ble	a5,a4,.L7	#, _11, j,
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	slli	a3,a4,2	#, _2, j
	li	a2,8192		# tmp151,
	add	a3,a3,a2	# tmp151, _3, _2
	lw	a1,0(a3)		# _4, *_3
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	addi	a5,a4,1	#, _5, j
	slli	a5,a5,2	#, _6, _5
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	add	a5,a5,a2	# tmp151, _7, _6
	lw	a2,0(a5)		# _8, *_7
# bubblesort.c:46:             if (array[j] > array[j + 1]) {
	ble	a1,a2,.L3	#, _4, _8,
# bubblesort.c:47:                 int temp = array[j];
	lw	a2,0(a3)		# temp, *_3
# bubblesort.c:48:                 array[j] = array[j + 1];
	lw	a1,0(a5)		# _9, *_7
# bubblesort.c:48:                 array[j] = array[j + 1];
	sw	a1,0(a3)	# _9, *_3
# bubblesort.c:49:                 array[j + 1] = temp;
	sw	a2,0(a5)	# temp, *_7
	j	.L3		#
.L7:
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	addi	a6,a6,1	#, i, i
.L2:
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	addi	a5,a0,-1	#, _12, size
# bubblesort.c:44:     for (i = 0; i < size - 1; i++) {
	ble	a5,a6,.L8	#, _12, i,
# bubblesort.c:45:         for (j = 0; j < size - i - 1; j++) {
	li	a4,0		# j,
	j	.L5		#
.L8:
# bubblesort.c:53: }
	ret
