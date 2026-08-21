main:               # IF  ID  EX  MEM WB
    li  a0,3        # 0   1   2   3   4
    li  a1,2        # 1   2   3   4   5
    add a2,a0,a1    # 2   3   4   5   6
    sub a3,a0,a1    # 3   4   5   6   7
    sw  a2,16(zero) # 4   5   6   7   8
    sw  a3,20(zero) # 5   6   7   8   9
