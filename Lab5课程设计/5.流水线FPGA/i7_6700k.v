module i7_6700k(clk_in,RST,pro_reset,in_addr,choose,leds,SEG,AN
    );
	input clk_in;
	input RST;
	input [2:0]pro_reset;
	input [11:0]in_addr;
    input choose;
	output [15:0]leds;
	output [7:0]SEG;
    output [7:0]AN;
    //如果�?要添加模块或修改信号，请同步更改wire声明、wire连接、模块声明三个部�?
    //此处�?始为连接每个模块input和output的wire声明

	//controller
	wire [5:0]op;
	wire [5:0]func;//in
	wire Syscall;
	wire [3:0]ALUOP;
	wire jr,jal,j,bne,beq;
	wire [1:0]EXTOP;
	wire Memwrite,MemToReg,Regwrite,ALUsrc,RegDst;

	//ALU
	wire [31:0]X;
    wire [31:0]Y;
    wire [3:0]OP;//in
    wire OF;
    wire CF;
    wire EQ;
    wire [31:0]R;
    wire [31:0]R2;

    //extender
    wire [31:0] ROM_D;//in
	wire [31:0] d4;
	wire [31:0] d5;
	wire [31:0] d7;

	//IS
	wire [9:0] address; //in
	wire [31:0] data_out;

	//DS
	wire 	str,	//信号?1时同步写? 
			clk, 	//信号：时?
			clr;	//信号?1时异步清?
	wire	[1:0]mode;	//信号?0时字访问?1时字节访?
    wire    [11:0]extra_addr;
	wire	[11:0] d_address;	//地址：输?
	wire	[31:0] data_in;	//数据：输?
	wire	[31:0] d_data_out;	//数据：输?
    wire    [31:0]extra_dout;

	//PC
	wire [31:0]pc_in;
    wire halt;
    wire rst;
    wire pc_clk;//in
    wire [31:0] pc_out;

    //regfile
    wire r_clk, WE;//write enable control
	wire [4:0] rW, rA, rB;//register addr
	wire [31:0] W;//data to rW //in
	wire [31:0] A, B;//data from rA,rB

	//cpu_choose
    wire [31:0] PC,RegFile_E,index,RF_A,ALU_R,RAM_D;//deleted ROM_D
    wire S,correct_b;
//    wire [1:0] EXTOP;//in
    wire [4:0] out0,out1,out2,out3,out4;
    wire [31:0] out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,SyscallOut;
    
    //operating_parameter
    wire o_rst;
    wire o_clk;
//    wire halt;
//    wire j;
//    wire jal;
//    wire jr;
//    wire bne;
    wire blez;
//    wire beq;
//    wire correct_b; //in
    wire [31:0]total;
    wire [31:0]conditional;
    wire [31:0]unconditional;
    wire [31:0]conditional_success;

    //divider
    wire clk_in;//system clock, reset button
	wire clk_out;



    //构建数据通路
    //controller input
//    wire [5:0]OP;
//    wire [5:0]func;
    assign op = data_out[31:26];
    assign func = data_out[5:0];

    //ALU input
    assign X = A;
    assign Y = out6;
    assign OP = ALUOP;

    //IS input
    assign address = pc_out[9:0];

    //DS input
    assign str = Memwrite;
    assign clk = clk_out;
    assign clr = RST;
    assign mode = 0;//只使用字访问
    assign d_address = R[9:0];
    assign data_in = out12;

    //PC input;
    assign pc_clk = clk_out;
    assign halt = ((data_out==0)|((RF_A==10)&Syscall))&~RST;
    assign rst = RST;
    assign pc_in = out11;

    //regfile input
    assign r_clk = clk_out;
    assign WE = Regwrite;
    assign rW = out4;
    assign rA = out1;
    assign rB = out3;
    assign W = out8;

    //change_type input
    wire [31:0]chose_out;
    wire [11:0]RAM_addr;
    assign extra_addr = RAM_addr;

    //cpu choose
    assign ROM_D = data_out;
    assign PC = pc_out;
    assign RegFile_E = B;
    assign index[25:0] = data_out[25:0];
    assign index[31:26] = 0;
    assign RF_A = A;
    assign ALU_R = R;
    assign RAM_D = d_data_out;
    assign S = (EXTOP == 2);
    assign correct_b = (EQ&beq)|(~EQ&bne);
    assign sh = 0;

    //operating_parameter
    assign o_rst = RST;
    assign o_clk = clk_out;
    assign blez = 0;

    //模块引用
    divider m_divider(clk_in, choose,clk_out);
	controller m_controller(op,func,Syscall,ALUOP,jr,jal,j,bne,beq,EXTOP,Memwrite,MemToReg,Regwrite,ALUsrc,RegDst);
	ALU m_ALU(X,Y,OP,OF,CF,EQ,R,R2);
//	extender m_extender(ROM_D,d4,d5,d7);
	IS m_IS(address, data_out);
	DS_2ways m_DS(str, clk, RST, mode, d_address, extra_addr, data_in, d_data_out, extra_dout);
	pc m_pc(pc_clk,halt,RST,pc_in,pc_out);
	regfile m_regfile(r_clk, WE, rW, rA, rB, W, A, B);
	cpu_choose m_cpuchoose(clk_out,ROM_D,PC,RegFile_E,index,RF_A,ALU_R,RAM_D,
	S,Syscall,RegDst,jal,correct_b,j,jr,ALUsrc,sh,MemToReg,EXTOP,
	out0,out1,out2,out3,out4,
    out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,SyscallOut
    );
    operating_parameter m_op(RST,clk_out,halt,total,conditional,unconditional,
    conditional_success,j,jal,jr,blez,beq,bne,correct_b);
    led m_led(RST,pro_reset,in_addr,leds);
	change_type m_ct(clk_out,SyscallOut,extra_dout,PC,total,unconditional,conditional,conditional_success,pro_reset,in_addr,chose_out,RAM_addr);
	display m_display(clk_in,chose_out,SEG,AN);
endmodule