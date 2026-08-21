SRCS = sum.c

CC = riscv64-elf-gcc
CCFLAGS_COMMON = -Wall -Og -fverbose-asm -fno-toplevel-reorder

ASSEMBLER = $(CPU_EXERCISE_ROOT)/project/assembler/build/src/assembler.out

ifeq ($(CC),riscv64-elf-gcc)
	CCFLAGS = -march=rv32im -mabi=ilp32 -nostdlib $(CCFLAGS_COMMON)
else
	CCFLAGS = --target=riscv32-unknown-elf -march=rv32i -mabi=ilp32 -fno-builtin -ffreestanding -fno-integrated-as $(CCFLAGS_COMMON)
endif

all:
	$(CC) $(CCFLAGS) -S $(SRCS) -o $(SRCS:.c=.s)
	$(ASSEMBLER) $(SRCS:.c=.s) > IMEM.dat
