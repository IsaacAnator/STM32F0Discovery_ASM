  .thumb

  .section .text.program
_start:
init:


main:
    B   main 

  .section .data
  .word 0x41424344

  .section .text.vector
  .word     _start + 1


