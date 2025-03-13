STM32F0Discovery: Programming from Scratch
Isaac Wilkie

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

Overview of Open Source Tools Used: 
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




