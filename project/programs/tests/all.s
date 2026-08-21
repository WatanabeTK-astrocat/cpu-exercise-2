label1:
# arithmetic operations
    add r1,r2,r3        # 0
    sub r4,r5,r6        # 1
    addi r7,r8,100      # 2
    subi r9,r10,100     # 3
# logical operations
    and r11,r12,r13     # 4
    or r14,r15,r16      # 5
    xor r17,r18,r19     # 6
    nor r20,r21,r22     # 7
    andi r23,r24,100    # 8
    ori r25,r26,100     # 9
    xori r27,r28,100    # 10
    slt r29,r30,r1      # 11
    slti r2,r3,100      # 12
# shift operations
    sll r4,r5,r6        # 13
    slli r7,r8,2        # 14
    srl r9,r10,r11      # 15
    srli r12,r13,2      # 16
    sra r14,r15,r16     # 17
    srai r17,r18,2      # 18
# data transfer operations
    lw r1,0(r0)         # 19
    sw r2,4(r0)         # 20
    lh r3,8(r0)         # 21
    sh r4,12(r0)        # 22
    lb r5,16(r0)        # 23
    sb r6,20(r0)        # 24
    lui r7,100          # 25
# branch operations
    beq r7,r8,label1    # 26    dpl = -26 * 4 = -104 = -104 + 2^16 = 65432
    bne r8,r9,label2    # 27    dpl = (36-27) * 4 = 9 * 4 = 36
    blt r10,r11,label1  # 28    dpl = -28 * 4 = -112 = -112 + 2^16 = 65424
    bge r12,r13,label2  # 29    dpl = (36-29) * 4 = 7 * 4 = 28
    bltu r14,r15,label1 # 30    dpl = -30 * 4 = -120 = -120 + 2^16 = 65416
    bgeu r16,r17,label2 # 31    dpl = (36-31) * 4 = 5 * 4 = 20
# jump operations
    j label1            # 32    jmpAddr = 0
    jal label2          # 33    jmpAddr = 36 * 4 = 144
    jr r1               # 34
    jalr r2             # 35
label2: