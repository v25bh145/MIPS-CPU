   .org 0x0
   .set noat
   .set noreorder
   .globl main

   .text
main:
   lui $s0, 0x1122		#$s0 = 0x1122
   ori $s0, $s0, 0x3344		#$s0 = 0x11223344
   lui $s1, 0xABCD		#$s1 = 0xABCD
   addiu $s1, $s1, 0x78EF	#$s1 = 0xABCD78EF
   addiu $s2, $zero, 0xFF56 	#$s2 = 0xFF56
   
   

