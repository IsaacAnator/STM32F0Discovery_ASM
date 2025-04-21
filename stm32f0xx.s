.thumb

@; Bit Masks
  .equ BIT0,  (1 << 0)
  .equ BIT1,  (1 << 1)
  .equ BIT2,  (1 << 2)
  .equ BIT3,  (1 << 3)
  .equ BIT4,  (1 << 4)
  .equ BIT5,  (1 << 5)
  .equ BIT6,  (1 << 6)
  .equ BIT7,  (1 << 7)
  .equ BIT8,  (1 << 8)
  .equ BIT9,  (1 << 9)
  .equ BIT10, (1 << 10)
  .equ BIT11, (1 << 11)
  .equ BIT12, (1 << 12)
  .equ BIT13, (1 << 13)
  .equ BIT14, (1 << 14)
  .equ BIT15, (1 << 15)
  .equ BIT16, (1 << 16)
  .equ BIT17, (1 << 17)
  .equ BIT18, (1 << 18)
  .equ BIT19, (1 << 19)
  .equ BIT20, (1 << 20)
  .equ BIT21, (1 << 21)
  .equ BIT22, (1 << 22)
  .equ BIT23, (1 << 23)
  .equ BIT24, (1 << 24)
  .equ BIT25, (1 << 25)
  .equ BIT26, (1 << 26)
  .equ BIT27, (1 << 27)
  .equ BIT28, (1 << 28)
  .equ BIT29, (1 << 29)
  .equ BIT30, (1 << 30)
  .equ BIT31, (1 << 31)

@; Reset and Clock Control (RCC)
.equ RCC_Adr,         0x40021000
.equ AHBENR,          0x14  

.equ IOPCEN,          BIT19

@; GPIO Port C
.equ GPIOC_Adr,       0x48000800
.equ MODER,           0x00
.equ OTYPER,          0x04
.equ OSPEEDR,         0x08
.equ PUPDR,           0x0C
.equ BSRR,            0x18

.equ OUTPUT,					BIT16

.equ GPIOC_BSP9,      BIT8
.equ GPIOC_BRP9,      BIT24


