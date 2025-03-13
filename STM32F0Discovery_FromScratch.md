# STM32F0Discovery: Programming from Scratch
### Isaac Wilkie

The overal goal of this project is to familiaize myself with a microtontrollers internal functioning by writing a simple LED Blinky program with minimal software abstractions.

Project Specific Goals: 
- No Integrated Development Environment (IDE)
- Use only open source tools
- Develop custom software abstractions including header files and drivers
- Create a minimal development environment within the linux terminal that supports streamlined binary creation and basic debugging functionality
- Blink an LED at 1 Hz
  
Exceptions: 
- code may be written in Assembly language; however, the final binaries will undergo thorough analysis
- Microcontroller programming will utilize a programmer, the St-link V2. This aspect may be pursued as a future project.

#### Overview of Open Source Tools Used: 
- GNU arm-none-eabi-binutils                https://archlinux.org/packages/extra/x86_64/arm-none-eabi-binutils/
- stlink open-source package                https://github.com/stlink-org/stlink?tab=readme-ov-file
- hex2bin                                   https://github.com/algodesigner/hex2bin
- Documentation: 
    * RM0091 Reference Manual               --> STM32F0x8 MCU
    * PM0215 Programming Manual             --> STM32F0 Cortex-M0 processor
    * ARMv6-M Architecture Reference Manual --> Cortex-M0 architecture  
    * UM1525 User Manual                    --> STM32F0Discovery kit 
    * GNU as                                --> GNU assembler user guide
    * GNU ld                                --> GNU linker user guide

#### Picking a Microcontroller

I have some experience in 8-bit microcontrollers including Atmel ATTiny85 and various small PIC's. Therefore, I will pick a larger and more widly used ARM 32-bit architecture. My final pick was a STM32F0Discovery development board. This board contains a STM32F051 microcontroller which itself contains a Cortex-M0+ Core. I picked a development board to minimize hardware design to focus on software. I picked this particular unit because it was inexpensive and well documented. 

#### Development Environment Tools

The next step of any project is picking the tools that will be used.
GNU is the obvious choice, it is a very large open source linux based project with lots of history and support. It also contains MAKE, which can be used for easy binary creation.
GNU's binutils contain a supported assembler, linker, and various other helpful tools.
GNU binutils need to be configured to be a cross compiler for ARM Cortex-M0+. Within the installation documentation, in the section "Host, Build, and Target Specification", it details the naming convention for cross compiler targets: _cpu-company-system._ luckily for me, someone else has compiled ARM binutils for me, so installation onto an ArchLinux distribution is trivial: 
```
sudo pacman -S arm-none-eabi-binutils
```
"arm" specifies the CPU <br>
"none" means no specific company/vender <br>
"eabi" specified as Embedded Application Binary Interface (as opposed to an OS) <br>

I want a final binary file. The GNU assembler and linker will only create an elf or hex file. binutils contains a tool 'objcopy' which can convert from an elf to bin file. However, within the objcopy documentation it states, "When objcopy generates a raw binary file, it will essentially produce a memory dump of the contents of the input object file. All symbols and relocation information will be discarded." This will not be satisfactory to my application, as I need to place sections of code in specific address locations using the linker, and those addresses cannot be discarded. 

Therefore, I used another open source tool called hex2bin. This tool will keep the specfic address locations generated on the hex file by the linker. Installing was done by building from github: 
```
git clone https://github.com/algodesigner/hex2bin
cd hex2bin
make
cd ..
rm -rf hex2bin
```
The binary file was automatically copied to /usr/bin by the makefile so it will be seen by the system $PATH. The build files can be deleted. 

#### Starting Test Code

Now is the time to start writing code for the microcontroller (MCU). The absolute minimum code needed for the MCU is a RESET vector. Upon powering on or hard reset, the MCU hardware pulls data from the reset vector location in memory and loads it into the Program Counter (PC). The PC is now pointing at the first instruction it will execute. <br>
Other features I would like to test are: section linking to different areas of the address memory space, basic assembler syntax, and proper assembling of instructions into the correct machine code. <br>
Below is the contents of the file Blinky.asm
```
  .thumb

  .section .text.program
_start:
  mov   R0, #9
  B     _start

  .section .data
  .word 0x41424344

  .section .text.vector
  .word     _start + 1
```
Notes on the GNU as assembler syntax and struction: 
- the '.' character indicates an assembler directive
- .section indicates a named section which will be combined by the linker
- there are at least 3 sections: .text, .data, and .bss as describted in the GNU as documentation section 4.1
#### Explaining the code
###### .thumb  
The assembler needs to know what it is assembling. PM0215 section 1.4 states, "The Cortex®-M0 processor implements the Arm®v6-M architecture, which is based on the 16-bit Thumb® instruction set and includes Thumb-2 technology". This means that the assembler needs to use 16-bit thumb encoding, characterized by the .thumb directive.
###### _start:
The GNU as, like all assemblers, uses labels to easily keep track of relative addresses. _start represents the absolute address of the next instruction in memory. This address is actually not given until the linker places all the object files and sections together, in which case it can be found and implimented. I amed it _start for clarity. It is the start of my program.
###### .word
I inputted an additional section to test and analyze the placement of data. The .word directive places whatever is next to it directly into memory at that location, which will be determined by the section location denoted by the linker. 0x41424344 will translate to ABCD in ascii.
###### .section .text.vector
A section created to be placed at the location of the reset vector by the linker. inputting a word pointing to the _start label will load the PC upon reset with the address of _start, executing the correct instructions. However, according to PM0215 section 2.13, "On reset, the processor loads the PC with the value of the reset vector, which is at address 0x00000004. Bit[0] of the value is loaded into the EPSR T-bit at reset and must be 1". This means the least significant bit (LSB) needs to be 1 no matter what the address of _start. I implimented this by having the assembler add 1 to the _start address.   


