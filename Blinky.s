  .include "stm32f0xx.s"

  .section .text.program                 @ this is a test comment
_start:
init:
                                         @ enable AHB clock (Read-Modifty-Write)
  ldr r0, RCC                            @ Store the memory address in R0
  ldr r1, [r0, #AHBENR]                  @ (READ) Store Data pointed to by R0 to R1
  mov r7, #1
  lsl r7, r7, #IOPCEN                    @ logical shift left: Make a bitmask in R7
  orr r1, r7, r1                         @ (MODIFY)
  str r1, [r0, #AHBENR]                  @ (WRITE)

                                         @ Set GPIO_C mode to output (Read-Modifty-Write)
  ldr r0, GPIOC                          @ Store the memory address in R0
  ldr r1, [r0, #MODER]                   @ (READ) Store Data pointed to by R0 to R1 
  mov r7, #0b01                          @ Set as General purpose output
  lsl r7, r7, #OUTPUT                    @ logical shift left: Make a bitmask in R7  
  orr r1, r7, r1                         @ (MODFIY)
  str r1, [r0, #MODER]                   @ (WRITE)

                                         @ Set port output type
  ldr r1, [r0, #OTYPER]                  @ (READ) Store Data pointed to by R0 to R1 
  mov r7, #0b00                          @ set as Push-Pull
  lsl r7, r7, #BIT8                      @ logical shift left: Make a bitmask in R7
  orr r1, r7, r1                         @ (MODFIY)
  str r1, [r0, #OTYPER]                  @ (WRITE)

                                         @ Set port speed
  ldr r1, [r0, #OSPEEDR]                 @ (READ) Store Data pointed to by R0 to R1 
  mov r7, #0b00                          @ set as low speed
  lsl r7, r7, #BIT16                     @ logical shift left: Make a bitmask in R7
  orr r1, r7, r1                         @ (MODFIY)
  str r1, [r0, #OSPEEDR]                 @ (WRITE)

                                         @ Set pullup/pulldown register
  ldr r1, [r0, #PUPDR]                   @ (READ) Store Data pointed to by R0 to R1 
  mov r7, #0b00                          @ set as low speed
  lsl r7, r7, #BIT16                     @ logical shift left: Make a bitmask in R7
  orr r1, r7, r1                         @ (MODFIY)
  str r1, [r0, #PUPDR]                   @ (WRITE)

                                         @ Set initial LED value
  ldr r1, [r0, #BSRR]                    @ (READ) Store Data pointed to by R0 to R1 
  mov r7, #0b1                           @ set initial value to HIGH
  lsl r7, r7, #BIT8                      @ logical shift left: Make a bitmask in R7
  orr r1, r7, r1                         @ (MODFIY)
  str r1, [r0, #BSRR]                    @ (WRITE)

main: 
    b   main 

  .align 2                       @ Any PC offset needs to be word-aligned
Literal_Pool:
RCC:
  .word RCC_Adr
GPIOC:
  .word GPIOC_Adr 

  .section .data
  .word 0x41424344

  .section .text.vector
  .word     _start + 1

@ vim: set filetype=arm :
