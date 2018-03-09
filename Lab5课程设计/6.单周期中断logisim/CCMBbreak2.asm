# U201514559 ÖÜÃúê» CS1503°à
# 5 XOR Òì»ò
# 8 SLTIU Ð¡ÓÚÁ¢¼´ÊýÖÃ 1(ÎÞ·ûºÅ)
# 6 SH ´æ´¢°ë×Ö
# 1 BLEZ Ð¡ÓÚµÈÓÚ 0 ×ªÒÆ

.text

j myccmb
###################################################################
#break1
#保护现场

addi $sp, $sp, -4 #入栈
sw $s1, 0($sp)
addi $sp, $sp, -4 #入栈
sw $a0, 0($sp)
addi $sp, $sp, -4 #入栈
sw $v0, 0($sp)
addi $sp, $sp, -4 #EPC入栈
sw $30, 0($sp)	#实际上不�?30号寄存器，当�?测到sw�?$30时，替换为EPC入栈

mfc0 $0,$0#�?中断

addi $s1,$zero,1     #算术右移测试 

sll $s1, $s1, 28   #逻辑左移31�? 

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex

mtc0 $0,$0#关中�?


#恢复现场
lw $30, 0($sp) #EPC出栈
addi $sp, $sp, 4 #实际上不�?30号寄存器，当�?测到lw�?$30时，替换为EPC入栈
lw $v0, 0($sp) #出栈
addi $sp, $sp, 4
lw $a0, 0($sp) #出栈
addi $sp, $sp, 4 
lw $s1, 0($sp) #出栈
addi $sp, $sp, 4 


mfc0 $0,$0#�?中断中断返回
eret#中断返回

###################################################################
#break2

#保护现场

addi $sp, $sp, -4 #入栈
sw $s1, 0($sp)
addi $sp, $sp, -4 #入栈
sw $a0, 0($sp)
addi $sp, $sp, -4 #入栈
sw $v0, 0($sp)
addi $sp, $sp, -4 #EPC入栈
sw $30, 0($sp)	#实际上不�?30号寄存器，当�?测到sw�?$30时，替换为EPC入栈


mfc0 $0,$0#�?中断

addi $s1,$zero,2     #算术右移测试 
sll $s1, $s1, 28   #逻辑左移31�? $s1=0x10000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    #$s1=0X10000000-->0XF0000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    #0XF0000000-->0XFF000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex

mtc0 $0,$0#关中�?

#恢复现场
lw $30, 0($sp) #EPC出栈
addi $sp, $sp, 4 #实际上不�?30号寄存器，当�?测到lw�?$30时，替换为EPC入栈
lw $v0, 0($sp) #出栈
addi $sp, $sp, 4
lw $a0, 0($sp) #出栈
addi $sp, $sp, 4 
lw $s1, 0($sp) #出栈
addi $sp, $sp, 4 


mfc0 $0,$0#�?中断中断返回
eret#中断返回

###################################################################
#break3

#保护现场

addi $sp, $sp, -4 #入栈
sw $s1, 0($sp)
addi $sp, $sp, -4 #入栈
sw $a0, 0($sp)
addi $sp, $sp, -4 #入栈
sw $v0, 0($sp)
addi $sp, $sp, -4 #EPC入栈
sw $30, 0($sp)	#实际上不�?30号寄存器，当�?测到sw�?$30时，替换为EPC入栈

mfc0 $0,$0#�?中断

addi $s1,$zero,3     #算术右移测试 
sll $s1, $s1, 28   #逻辑左移31�? $s1=0x10000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    #$s1=0X10000000-->0XF0000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    #0XF0000000-->0XFF000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex

mtc0 $0,$0#关中�?

#恢复现场

lw $30, 0($sp) #EPC出栈
addi $sp, $sp, 4 #实际上不�?30号寄存器，当�?测到lw�?$30时，替换为EPC入栈
lw $v0, 0($sp) #出栈
addi $sp, $sp, 4
lw $a0, 0($sp) #出栈
addi $sp, $sp, 4 
lw $s1, 0($sp) #出栈
addi $sp, $sp, 4 

mfc0 $0,$0#�?中断中断返回
eret#中断返回
###################################################################

myccmb:
	addi $sp,$0,0x2ffc #����SPָ��
	addi $s0,$zero,1  #s0¼Ä´æÆ÷ÖÃ1
	addi $s1,$zero,1  #s1¼Ä´æÆ÷ÖÃ1
	addi $s2,$zero,0xffffffff  #s2¼Ä´æÆ÷ÖÃ0xffffffff
	xor $a0, $s0, $s1 #s0Óës1Òì»ò£º1 xor 1 = 0 ¸³Öµ¸øa0
	sltiu $a1, $a0, 1 #a0 < 1 ,a1ÖÃ1
	xor $a1, $a1, $s2 #s2Óëa1Òì»ò£¬½á¹ûÎªffffffff xor 00000001 = fffffffe
	sh $a1, 0($zero) #°Ña1°ë×Ö±£´æÔÚÊý¾Ý´æ´¢Æ÷ÖÐ£¬¼´fffe±£´æÔÚ0ºÅÎ»ÖÃ
	blez $a0, Next1   #a0 <= 0£¬×ªÒÆµ½Next1

Next1:
	addi $v0,$zero,1  #v0¼Ä´æÆ÷ÖÃ1
	addi $a0,$zero,8  #a0¼Ä´æÆ÷ÖÃ8
	syscall           #display 8
	addi $v0,$zero,10
	syscall