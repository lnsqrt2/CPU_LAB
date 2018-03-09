# U201514559 周铭昊 CS1503班
# 5 XOR 异或
# 8 SLTIU 小于立即数置 1(无符号)
# 6 SH 存储半字
# 1 BLEZ 小于等于 0 转移

.text
	addi $s0,$zero,1  #s0寄存器置1
	addi $s1,$zero,1  #s1寄存器置1
	addi $s2,$zero,0xffffffff  #s2寄存器置0xffffffff
	xor $a0, $s0, $s1 #s0与s1异或：1 xor 1 = 0 赋值给a0
	sltiu $a1, $a0, 1 #a0 < 1 ,a1置1
	xor $a1, $a1, $s2 #s2与a1异或，结果为ffffffff xor 00000001 = fffffffe
	sh $a1, 0($zero) #把a1半字保存在数据存储器中，即fffe保存在0号位置
	blez $a0, Next1   #a0 <= 0，转移到Next1

Next1:
	addi $v0,$zero,1  #v0寄存器置1
	addi $a0,$zero,8  #a0寄存器置8
	syscall           #display 8
	addi $v0,$zero,10
	syscall

	
