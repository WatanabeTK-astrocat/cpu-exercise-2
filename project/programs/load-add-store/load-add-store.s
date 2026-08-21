main:
    li  a0,3        # 0
    li  a1,2        # 1
    add a2,a0,a1    # 2
    sub a3,a0,a1    # 3
    sw  a2,16(zero) # 4
    sw  a3,20(zero) # 5
