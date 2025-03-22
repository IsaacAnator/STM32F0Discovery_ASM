all: Blinky.s Blinky.ld
	arm-none-eabi-as -o Blinky.o Blinky.s
	arm-none-eabi-ld -T Blinky.ld -o Blinky.elf Blinky.o
	arm-none-eabi-objcopy -O ihex Blinky.elf Blinky.hex
	hex2bin -s 0 -p 0 Blinky.hex


bin: Blinky.bin
	hexdump -C Blinky.bin

elf: Blinky.elf
	arm-none-eabi-objdump -f .text -s Blinky.elf

strip: 
	rm -f *.o
	rm -f *.elf
	rm -f *.hex

clean: 
	rm -f *.o
	rm -f *.elf
	rm -f *.bin
	rm -f *.hex
