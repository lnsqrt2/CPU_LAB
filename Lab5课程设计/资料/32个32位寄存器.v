module my_reg//32numbers,32bits
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
  input [(ADDR_WIDTH-1):0] src1_addr,
  input [(ADDR_WIDTH-1):0] src2_addr,
  input [(ADDR_WIDTH-1):0] dest_addr,
  input [(DATA_WIDTH-1):0] write_datas_in,
  input writeReg_L,//register write enable,negative valid;
  input writeHighEx_L,writeHighAx_L,writeLowEx_L,writeLowAx_L,
  input CLOCK,
  output reg [(DATA_WIDTH-1):0] src1_datas_out,//source register datas output
  output reg [(DATA_WIDTH-1):0] src2_datas_out
);
  reg [31:0] memory [31:0];//work unit
  
  initial //0#register initail
    begin
      memory[0][31:0]=32'b0;
    end
    
  //write register
  always@(posedge CLOCK)//positive active
    if(dest_addr != 0)//0#register can not be modefied,always 0
   begin
     if(writeReg_L==0)//negative valid
       begin 
          if(writeHighEx_L==0) 
            memory [dest_addr][31:24] <= write_datas_in[31:24];
     
          if(writeHighAx_L==0)
            memory [dest_addr][23:16] <=write_datas_in[23:16];
        
          if(writeLowEx_L==0) 
            memory [dest_addr][15:8] <= write_datas_in[15:8];
       
          if(writeLowAx_L==0)
            memory [dest_addr][7:0] <=write_datas_in[7:0];  
       end
     else 
       memory [dest_addr][31:0]<= memory [dest_addr][31:0]; 
   end
  
  //read register
  always@(src1_addr or src2_addr)
   begin
     src1_datas_out <= memory [src1_addr];
     src2_datas_out <= memory [src2_addr];
   end
   
endmodule 



