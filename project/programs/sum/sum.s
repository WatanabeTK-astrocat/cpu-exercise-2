main:
	li	a5,16           # 0
	li	a4,5            # 4
	sw	a4,0(a5)        # 8
	li	a4,9            # 12
	sw	a4,4(a5)        # 16
	li	a4,1            # 20
	sh	a4,8(a5)        # 24
	li	a4,4            # 28
	sh	a4,12(a5)       # 32
	li	a4,3            # 36
	sh	a4,16(a5)       # 40
	li	a4,2            # 44
	sh	a4,20(a5)       # 48
	sh	zero,24(a5)     # 52
	li	a4,8            # 56
	sh	a4,28(a5)       # 60
	call	sum_array   # 64
	sh	a0,0(zero)      # 68
.L5:
	j	.L5             # 72
sum_array:
	addi    a2,a5,32    # 76
	li	a0,0            # 80
	j	.L2             # 84
.L3:
	lh 	a4,0(a5)        # 88
	add	a0,a4,a0        # 92
	addi	a5,a5,4     # 96
.L2:
	blt	a5,a2,.L3       # 100
	ret                 # 104