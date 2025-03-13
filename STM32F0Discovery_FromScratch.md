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
"arm" specifies the CPU
"none" means no specific company/vender
"eabi" specified as Embedded Application Binary Interface (as opposed to an OS)

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





