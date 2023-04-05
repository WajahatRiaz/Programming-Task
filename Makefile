all: build run clean

.PHONNY: all

build:
	@riscv32-unknown-elf-gcc -march=rv32g -mabi=ilp32 -nostdlib -nostartfiles -T linkerscript.ld programming_task_3.S -o test.out

run:
	@spike -d --log-commits --isa=rv32g $(which pk) test.out

clean:
	@-rm *.log
	@-rm *.out
	@clear

