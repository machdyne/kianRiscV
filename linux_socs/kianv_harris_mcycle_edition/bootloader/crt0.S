.text
.global _start
.type _start, @function
addi x1, zero, 0
addi x2, zero, 0
addi x3, zero, 0
addi x4, zero, 0
addi x5, zero, 0
addi x6, zero, 0
addi x7, zero, 0
addi x8, zero, 0
addi x9, zero, 0
addi x10, zero, 0
addi x11, zero, 0
addi x12, zero, 0
addi x13, zero, 0
addi x14, zero, 0
addi x15, zero, 0
addi x16, zero, 0
addi x17, zero, 0
addi x18, zero, 0
addi x19, zero, 0
addi x20, zero, 0
addi x21, zero, 0
addi x22, zero, 0
addi x23, zero, 0
addi x24, zero, 0
addi x25, zero, 0
addi x26, zero, 0
addi x27, zero, 0
addi x28, zero, 0
addi x29, zero, 0
addi x30, zero, 0
addi x31, zero, 0

lui sp, %hi(__stacktop);
addi sp, sp, %lo(__stacktop);
la a0, _sbss
la a1, _ebss
bge a0, a1, end_init_bss
loop_init_bss:
addi a0, a0, 4
sw zero, -4(a0)
blt a0, a1, loop_init_bss
end_init_bss:

la a0, _sidata
la a1, _sdata
la a2, _edata
bge a1, a2, end_init_data
loop_init_data:

lw a3, 0(a0)
addi a0, a0, 4
addi a1, a1, 4
sw a3, -4(a1)
blt a1, a2, loop_init_data
end_init_data:
call main
loop:
j loop
.balign 4


