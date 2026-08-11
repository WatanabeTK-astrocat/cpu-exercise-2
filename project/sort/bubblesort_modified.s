main:
# bubblesort.c:1:      volatile short* const array = (short*)0x2000;
    li	a5,8192
# bubblesort.c:7:      short size = 8;
    addi  a0,a5,7        # array_0 + size - 1を入れておく(for loopの比較)
# bubblesort.c:9:      array[0] = 5;
	li	t3,5
	sh	t3,0(a5)	# MEM[(volatile short int *)8192B]
# bubblesort.c:10:     array[1] = 9;
	li	t3,9
	sh	t3,2(a5)	#MEM[(volatile short int *)8194B]
# bubblesort.c:11:     array[2] = 1;
	li	t3,1
	sh	t3,4(a5)	# MEM[(volatile short int *)8196B]
# bubblesort.c:12:     array[3] = 4;
	li	t3,4
	sh	t3,6(a5)	# MEM[(volatile short int *)8198B]
# bubblesort.c:13:     array[4] = 3;
	li	t3,3
	sh	t3,8(a5)	# MEM[(volatile short int *)8200B]
# bubblesort.c:14:     array[5] = 2;
	li	t3,2
	sh	t3,10(a5)	# MEM[(volatile short int *)8202B]
# bubblesort.c:15:     array[6] = 0;
	sh	zero,12(a5)	# MEM[(volatile short int *)8204B]
# bubblesort.c:16:     array[7] = 8;
	li	t3,8
	sh	t3,14(a5)	# MEM[(volatile short int *)8206B]
# bubblesort.c:18:     sort(size);
sort:
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
	addi	t0,a5,0     # t0(i) = 0 (array_0)
.Libegin:
# bubblesort.c:33:         for (j = 0; j < size - i - 1; j++) {
	addi    t1,a5,0     # t1(j) = 0
    sub a1,a0,t0        # a1 = a0(size - 1) - t0(i)
.Ljbegin:
# bubblesort.c:34:             if (array[j] > array[j + 1]) {
	lh	a2,0(t1)		# a2 = array[j]
    lh  a3,2(t1)        # a3 = array[j + 1] (shortの幅に気を付ける)
	ble	a2,a3,.L4	    # skip to after if
# bubblesort.c:35:                 short temp = array[j];
	lh	t2,0(t1)
# bubblesort.c:36:                 array[j] = array[j + 1];
	lh	t3,2(t1)
	sh	t3,0(t1)
# bubblesort.c:37:                 array[j + 1] = temp;
	sh	t2,2(t1)
.L4:
# bubblesort.c:33:         for (j = 0; j < size - i - 1; j++) {
    addi	t1,t1,2     # j++
	blt t1,a1,.Ljbegin
# bubblesort.c:32:     for (i = 0; i < size - 1; i++) {
    addi	t0,t0,2     # j++
	blt	t0,a0,.Libegin	#, _17, _36,
# bubblesort.c:41: }
