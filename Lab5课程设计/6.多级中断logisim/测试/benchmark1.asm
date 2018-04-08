#v2.0 raw
.text
addi $sp,$0,0x2ffc #设置SP指针 
addi $a0,$0,0
loop_add:
  add    $a0,$a0,1       
  addi   $v0,$0,34
  syscall
j loop_add
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
sw $30, 0($sp)	#实际上不是30号寄存器，当检测到sw且$30时，替换为EPC入栈

mfc0 $0,$0#开中断

addi $s1,$zero,1     #算术右移测试 

sll $s1, $s1, 28   #逻辑左移31位 

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

mtc0 $0,$0#关中断


#恢复现场
lw $30, 0($sp) #EPC出栈
addi $sp, $sp, 4 #实际上不是30号寄存器，当检测到lw且$30时，替换为EPC入栈
lw $v0, 0($sp) #出栈
addi $sp, $sp, 4
lw $a0, 0($sp) #出栈
addi $sp, $sp, 4 
lw $s1, 0($sp) #出栈
addi $sp, $sp, 4 


mfc0 $0,$0#开中断中断返回
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
sw $30, 0($sp)	#实际上不是30号寄存器，当检测到sw且$30时，替换为EPC入栈


mfc0 $0,$0#开中断

addi $s1,$zero,2     #算术右移测试 
sll $s1, $s1, 28   #逻辑左移31位 $s1=0x10000000

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

mtc0 $0,$0#关中断

#恢复现场
lw $30, 0($sp) #EPC出栈
addi $sp, $sp, 4 #实际上不是30号寄存器，当检测到lw且$30时，替换为EPC入栈
lw $v0, 0($sp) #出栈
addi $sp, $sp, 4
lw $a0, 0($sp) #出栈
addi $sp, $sp, 4 
lw $s1, 0($sp) #出栈
addi $sp, $sp, 4 


mfc0 $0,$0#开中断中断返回
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
sw $30, 0($sp)	#实际上不是30号寄存器，当检测到sw且$30时，替换为EPC入栈

mfc0 $0,$0#开中断

addi $s1,$zero,3     #算术右移测试 
sll $s1, $s1, 28   #逻辑左移31位 $s1=0x10000000

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

mtc0 $0,$0#关中断

#恢复现场

lw $30, 0($sp) #EPC出栈
addi $sp, $sp, 4 #实际上不是30号寄存器，当检测到lw且$30时，替换为EPC入栈
lw $v0, 0($sp) #出栈
addi $sp, $sp, 4
lw $a0, 0($sp) #出栈
addi $sp, $sp, 4 
lw $s1, 0($sp) #出栈
addi $sp, $sp, 4 

mfc0 $0,$0#开中断中断返回
eret#中断返回