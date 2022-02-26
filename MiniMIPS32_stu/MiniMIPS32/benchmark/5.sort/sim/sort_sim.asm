
build/sort_sim:     file format elf32-tradlittlemips
build/sort_sim


Disassembly of section .text:

00000000 <main>:
   0:	3c101000 	lui	s0,0x1000
   4:	26100000 	addiu	s0,s0,0
   8:	3611001c 	ori	s1,s0,0x1c

0000000c <sort_loop>:
sort_loop():
   c:	8e130000 	lw	s3,0(s0)
  10:	8e340000 	lw	s4,0(s1)
  14:	0274402a 	slt	t0,s3,s4
  18:	11000002 	beqz	t0,24 <sort_next>
  1c:	ae330000 	sw	s3,0(s1)
  20:	ae140000 	sw	s4,0(s0)

00000024 <sort_next>:
sort_next():
  24:	2631fffc 	addiu	s1,s1,-4
  28:	1611fff8 	bne	s0,s1,c <sort_loop>
  2c:	26100004 	addiu	s0,s0,4
  30:	3c081000 	lui	t0,0x1000
  34:	25080000 	addiu	t0,t0,0
  38:	3409001c 	li	t1,0x1c
  3c:	01098821 	addu	s1,t0,t1
  40:	1611fff2 	bne	s0,s1,c <sort_loop>
  44:	3c101000 	lui	s0,0x1000
  48:	26100000 	addiu	s0,s0,0
  4c:	8e080000 	lw	t0,0(s0)
  50:	8e090004 	lw	t1,4(s0)
  54:	8e0a0008 	lw	t2,8(s0)
  58:	8e0b000c 	lw	t3,12(s0)
  5c:	8e0c0010 	lw	t4,16(s0)
  60:	8e0d0014 	lw	t5,20(s0)
  64:	8e0e0018 	lw	t6,24(s0)
  68:	8e0f001c 	lw	t7,28(s0)

0000006c <sort_end>:
sort_end():
  6c:	0800001b 	j	6c <sort_end>

Disassembly of section .data:

10000000 <testdata>:
testdata():
10000000:	ffffffe7 	0xffffffe7
10000004:	ffffffe2 	0xffffffe2
10000008:	00000010 	mfhi	zero
1000000c:	00000018 	mult	zero,zero
10000010:	ffffffc0 	0xffffffc0
10000014:	00000023 	negu	zero,zero
10000018:	0000002a 	slt	zero,zero,zero
1000001c:	00000042 	srl	zero,zero,0x1

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	001bff00 	sll	ra,k1,0x1c
	...
