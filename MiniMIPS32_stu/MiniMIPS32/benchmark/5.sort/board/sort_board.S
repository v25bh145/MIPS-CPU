#################################################################################
#������ʵ�ִӵ�ַ0x10000000��ʼ��8���ֵĽ�������
#################################################################################			

  .set noat
  .set noreorder
  .globl main

 .data
testdata: .word -25, -30, 16, 24, -64, 35, 42, 66
ansdata:  .word 66, 42, 35, 24, 16, -25, -30, -64

 .text
main:
 la $s0,testdata  	//#$s0=0x10000000 (0010103c 00001026)
 ori $s1,$s0,0x1C   //#$s1=0x1000001C  1c001136
sort_loop:
//if(s3 < s4) swap(s4, s3) => 把大的往上换 
 lw $s3,0($s0)          //取s0给s3  0000138e
 lw $s4,0($s1)          //取s1给s4  0000348e
 slt $t0,$s3,$s4        //s3与s4比较，如果s3<s4则t0置1 2a407402
 beq $t0,$0,sort_next   //若t0等于0则跳转，否则继续   02000011
 //swap(s3, s4)
 sw $s3, 0($s1)         //将s3存入s1  000033ae
 sw $s4, 0($s0)         //将s4存入s0  000014ae
sort_next:
 addiu $s1, $s1, -4   //s1自减-4  fcff3126
 bne $s0, $s1, sort_loop    //s0 != s1 => 执行loop  (f8ff1116 )
 
 addiu $s0,$s0,4     //s0自增4   04001026  
 la $t0,testdata	    //#$t0=0x10000000  0010083c 00000825
 ori $t1,$zero,0x1C     //t1=0x0000001c   1c000934
 addu $s1,$t0,$t1     //s1=0x1000001C   21880901
 bne $s0, $s1, sort_loop    //s0!=s1 => 执行loop    f2ff1116



 la $s0,testdata	//#$s0=0x10000000 (0010103c 00001026)
 lw $t0,  0($s0)  0000088e
 lw $t1,  4($s0)  0400098e
 lw $t2,  8($s0)  08000a8e
 lw $t3, 12($s0)  0c000b8e
 lw $t4, 16($s0)  10000c8e
 lw $t5, 20($s0)  14000d8e
 lw $t6, 24($s0)  18000e8e
 lw $t7, 28($s0)  1c000f8e

 la $v0, ansdata  0010023c 20004224
 lw $s0,  0($v0)  0000508c
 lw $s1,  4($v0)  0400518c
 lw $s2,  8($v0)  0800528c
 lw $s3, 12($v0)  0c00538c
 lw $s4, 16($v0)  1000548c
 lw $s5, 20($v0)  1400558c
 lw $s6, 24($v0)  1800568c
 lw $s7, 28($v0)  1c00578c
 
 ori $a0, $zero, 1  01000434
 li $a1, 0x80040000	#0x80004000Ϊ�̵Ʒ��ʵ�ַ    0480053c
 li $a2, 0x80000000	#0x80000000Ϊ��Ʒ��ʵ�ַ   0080063c
 bne $t0, $s0, ERROR  09001015
 bne $t1, $s1, ERROR    08003115
 bne $t2, $s2, ERROR    07005215
 bne $t3, $s3, ERROR  06007315
 bne $t4, $s4, ERROR  05009415
 bne $t5, $s5, ERROR  0400b515
 bne $t6, $s6, ERROR  0300d615
 bne $t7, $s7, ERROR    0200f715

sort_end:
 sw $a0, 0($a1) 0000a4ac
 j sort_end     30000008

ERROR:
 sw $a0, 0($a2) 0000c4ac
 j ERROR  32000008
