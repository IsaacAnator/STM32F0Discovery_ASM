  .thumb

  .section .text.program
_start:
  mov   R0, #9
  B     _start

  .section .data
  .word 0x41424344

  .section .text.vector
  .word     _start + 1


