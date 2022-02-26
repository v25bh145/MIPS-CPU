
build/sort_board:     file format elf32-tradlittlemips
build/sort_board


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
  6c:	3c021000 	lui	v0,0x1000
  70:	24420020 	addiu	v0,v0,32
  74:	8c500000 	lw	s0,0(v0)
  78:	8c510004 	lw	s1,4(v0)
  7c:	8c520008 	lw	s2,8(v0)
  80:	8c53000c 	lw	s3,12(v0)
  84:	8c540010 	lw	s4,16(v0)
  88:	8c550014 	lw	s5,20(v0)
  8c:	8c560018 	lw	s6,24(v0)
  90:	8c57001c 	lw	s7,28(v0)
  94:	34040001 	li	a0,0x1
  98:	3c058004 	lui	a1,0x8004
  9c:	3c068000 	lui	a2,0x8000
  a0:	15100009 	bne	t0,s0,c8 <ERROR>
  a4:	15310008 	bne	t1,s1,c8 <ERROR>
  a8:	15520007 	bne	t2,s2,c8 <ERROR>
  ac:	15730006 	bne	t3,s3,c8 <ERROR>
  b0:	15940005 	bne	t4,s4,c8 <ERROR>
  b4:	15b50004 	bne	t5,s5,c8 <ERROR>
  b8:	15d60003 	bne	t6,s6,c8 <ERROR>
  bc:	15f70002 	bne	t7,s7,c8 <ERROR>

000000c0 <sort_end>:
sort_end():
  c0:	aca40000 	sw	a0,0(a1)
  c4:	08000030 	j	c0 <sort_end>

000000c8 <ERROR>:
ERROR():
  c8:	acc40000 	sw	a0,0(a2)
  cc:	08000032 	j	c8 <ERROR>

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

10000020 <ansdata>:
ansdata():
10000020:	00000042 	srl	zero,zero,0x1
10000024:	0000002a 	slt	zero,zero,zero
10000028:	00000023 	negu	zero,zero
1000002c:	00000018 	mult	zero,zero
10000030:	00000010 	mfhi	zero
10000034:	ffffffe7 	0xffffffe7
10000038:	ffffffe2 	0xffffffe2
1000003c:	ffffffc0 	0xffffffc0

Disassembly of section .reginfo:

00000000 <.reginfo>:
   0:	00ffff74 	0xffff74
	...
