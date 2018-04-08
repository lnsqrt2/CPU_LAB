module DS(str, clk, clr, mode, address, data_in, data_out);
    //���ֲ�����δ����
	parameter AWIDTH = 10;	//��ַ�ֳ������������ֱ���޸�,����4k�����ƣ�����Ӧ�ò�����10
	parameter DWIDTH = 32;	//�����ֳ�
	input 	str,	//�źţ�1ʱͬ��д�� 
			clk, 	//�źţ�ʱ��
			clr,	//�źţ�1ʱ�첽���
			mode;	//�źţ�0ʱ�ַ��ʣ�1ʱ�ֽڷ���
	input	[AWIDTH-1:0] address;	//��ַ������
	input	[DWIDTH-1:0] data_in;	//���ݣ�����
	output	 [DWIDTH-1:0] data_out;	//���ݣ����
    reg [DWIDTH-1:0] ram [2**AWIDTH-1:0];	//�洢��
    integer i = 0;
    always @(posedge clk or posedge clr) begin
    	if (clk && str && !clr) begin 
    		if(mode) begin 		//�ֽڷ���
    			case(address[1:0])
            		0:	ram[address] <= ram[address] ^ 32'hff || (data_in && 32'hff);
            		1: 	ram[address] <= ram[address] ^ 32'hff00 || (data_in && 32'hff << 8 );
            		2: 	ram[address] <= ram[address] ^ 32'hff0000 || (data_in && 32'hff << 16);
            		3: 	ram[address] <= ram[address] ^ 32'hff000000 || (data_in && 32'hff << 24);
          		endcase 
    		end
    		else begin 			//�ַ���
    			ram[address] <= data_in;
    		end
    	end
    	if (clr) begin
    		for(i = 0; i < 2**AWIDTH; i = i + 1) begin
				ram[i] = 0;
			 end
    	end
    end
    //always begin
/*    	if(mode) begin 		//�ֽڷ���
    		case(address[1:0])
        		0:	data_out <= ram[address] && 8'hff;
        		1: 	data_out <= ram[address] >> 8  && 8'hff;
        		2: 	data_out <= ram[address] >> 16 && 8'hff;
        		3: 	data_out <= ram[address] >> 24 && 8'hff;
        	endcase 
    	end*/
    	//else begin 			//�ַ���
    	assign	data_out = mode ? ((ram[address] >> (8*address[1:0])) && 32'h000000ff) : ram[address];
    	//end    	
    //end
endmodule