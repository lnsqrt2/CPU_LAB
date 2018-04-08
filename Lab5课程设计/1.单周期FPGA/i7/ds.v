module DS(str, clk, clr, mode, address, data_in, data_out);
    //半字操作还未测试
	parameter AWIDTH = 10;	//地址字长，在这里可以直接修改,由于4k的限制，这里应该不超过10
	parameter DWIDTH = 32;	//数据字长
	input 	str,	//信号：1时同步写入 
			clk, 	//信号：时钟
			clr,	//信号：1时异步清空
			mode;	//信号：0时字访问，1时字节访问
	input	[AWIDTH-1:0] address;	//地址：输入
	input	[DWIDTH-1:0] data_in;	//数据：输入
	output	 [DWIDTH-1:0] data_out;	//数据：输出
    reg [DWIDTH-1:0] ram [2**AWIDTH-1:0];	//存储器
    integer i = 0;
    always @(posedge clk or posedge clr) begin
    	if (clk && str && !clr) begin 
    		if(mode) begin 		//字节访问
    			case(address[1:0])
            		0:	ram[address] <= ram[address] ^ 32'hff || (data_in && 32'hff);
            		1: 	ram[address] <= ram[address] ^ 32'hff00 || (data_in && 32'hff << 8 );
            		2: 	ram[address] <= ram[address] ^ 32'hff0000 || (data_in && 32'hff << 16);
            		3: 	ram[address] <= ram[address] ^ 32'hff000000 || (data_in && 32'hff << 24);
          		endcase 
    		end
    		else begin 			//字访问
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
/*    	if(mode) begin 		//字节访问
    		case(address[1:0])
        		0:	data_out <= ram[address] && 8'hff;
        		1: 	data_out <= ram[address] >> 8  && 8'hff;
        		2: 	data_out <= ram[address] >> 16 && 8'hff;
        		3: 	data_out <= ram[address] >> 24 && 8'hff;
        	endcase 
    	end*/
    	//else begin 			//字访问
    	assign	data_out = mode ? ((ram[address] >> (8*address[1:0])) && 32'h000000ff) : ram[address];
    	//end    	
    //end
endmodule