# U201514559 ����� CS1503��
# 5 XOR ���
# 8 SLTIU С���������� 1(�޷���)
# 6 SH �洢����
# 1 BLEZ С�ڵ��� 0 ת��

.text
	addi $s0,$zero,1  #s0�Ĵ�����1
	addi $s1,$zero,1  #s1�Ĵ�����1
	addi $s2,$zero,0xffffffff  #s2�Ĵ�����0xffffffff
	xor $a0, $s0, $s1 #s0��s1���1 xor 1 = 0 ��ֵ��a0
	sltiu $a1, $a0, 1 #a0 < 1 ,a1��1
	xor $a1, $a1, $s2 #s2��a1��򣬽��Ϊffffffff xor 00000001 = fffffffe
	sh $a1, 0($zero) #��a1���ֱ��������ݴ洢���У���fffe������0��λ��
	blez $a0, Next1   #a0 <= 0��ת�Ƶ�Next1

Next1:
	addi $v0,$zero,1  #v0�Ĵ�����1
	addi $a0,$zero,8  #a0�Ĵ�����8
	syscall           #display 8
	addi $v0,$zero,10
	syscall

	
