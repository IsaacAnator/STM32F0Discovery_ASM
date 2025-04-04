  .include "stm32f0xx.s"

  .section .text.program      @ this is a test comment
_start:
init:
  @; enable AHB clock (Read-Modifty-Write)
  LDR R0, RCC                 @ Store the memory address in R0
  LDR R2, [R0, #AHBENR]       @ Store Data pointed to by R0 to R2
  MOV R1, #1
  LSL R1, R1, #19             @ Make a bitmask in R2 
  ORR R1, R2, R1              @ Set clock enable bit
  STR R1, [R0, #AHBENR]       @ Store correct value back in memory

main:
    B   main 

  .align 2                    @ Any PC offset needs to be word-aligned
Literal_Pool:
RCC:
  .word RCC_Adr


  .section .data
  .word 0x41424344

  .section .text.vector
  .word     _start + 1


