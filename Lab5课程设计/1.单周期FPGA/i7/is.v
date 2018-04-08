module IS(address, data_out);
	parameter AWIDTH = 10;
	parameter DWIDTH = 32;
	input	[AWIDTH-1:0] address;	//��ַ������
	output	[DWIDTH-1:0] data_out;	//���ݣ����
    reg [DWIDTH-1:0] rom [2**AWIDTH-1:0];	//�洢��
    initial begin
        $readmemh("D:/benchmark.dat", rom);
    end
    assign data_out = rom[address];
endmodule