module i9_7980XE(clk_in,RST,pro_reset,in_addr,choose,leds,SEG,AN
    );
	input clk_in;
	input RST;
	input [2:0]pro_reset;
	input [11:0]in_addr;
    input choose;
	output [15:0]leds;
	output [7:0]SEG;
    output [7:0]AN;

	//DIV
    wire clk_in;//system clock, reset button
	wire clk_out;

	//PC
	wire pause;
	wire [31:0] pc_in;
	wire [31:0] pc_out;

	//IS
	wire [9:0] address;
	wire [31:0] data_out;

	//IF_ID
	wire [31:0] p_in;
	wire [31:0] p_out;
	//i_in=data_out
	wire [31:0] i_out;

	//DEC
	wire [5:0]op1;
	wire [4:0]25_21;
	wire [4:0]20_16;
	wire [4:0]15_11;
	wire [4:0]10_6;
	wire [5:0]func1;
	wire [15:0] 15_0;
	wire [31:0] index1;

	//CONT
	wire [3:0]ALUOP1;
	wire [1:0]EXTOP;
	wire jr1,jal1,j1,bne1,beq1,blez1,sh1,Syscall1;
	wire Memwrite1,MemToReg1,Regwrite1,ALUsrc1,RegDst1;

	//EXT
	wire [31:0] ext_out1;

	//REGF
	wire WB;
	wire [4:0]RW,ra1,rb1;
	wire [31:0] w_RB,A1,B1;

	//ID_EX
	wire unlock;
	;

	assign unlock = (~LOCK);
	assign pause = (~LOCK) & (~loaduse);
	assign p_in = pc_out+1;

    DIV m_DIV(clk_in,choose,clk_out);
    PC m_PC(clk_out,pause,RST,pc_in,pc_out);
    IS m_IS(address, data_out);
    IF_ID m_IFID(clk_out,RST,pause,p_in,p_out,data_out,i_out);
    DEC m_DEC(i_out,op1,25_21,20_16,15_11,10_6,func1,15_0,index1);
    CONT m_CONT(op1,func1,Syscall1,ALUOP1,jr1,jal1,j1,bne1,beq1,blez1,EXTOP,Memwrite1,MemToReg1,Regwrite1,ALUsrc1,RegDst1,sh1);
    EXT m_EXT(15_0,10_6,ext_out1,EXTOP);
    REGF m_REGF(clk_out, WB, RW, ra1, rb1, w_RB, A1, B1);
    ID_EX m_IDEX(clk_out,RST,unlock,p_out,p_out1,
    ALUsrc1,ALUsrc,MemToReg_in,MemToReg_out,
    MemWrite_in,MemWrite_out,blez_in,blez_out,beq_in,beq_out,
    bne_in,bne_out,j_in,j_out,jal_in,jal_out,jr_in,jr_out,
    syscall_in,syscall_out,ALUOP_in,ALUOP_out,sh_in,sh_out,
    Regwrite1,WE_EX,A_in,A_out,B_in,B_out,EXT_in,EXT_out,
    INDEX_in,INDEX_out,RW_in,RW_out,RA_in,RA_out,RB_in,RB_out,
    op_in,op_out,func_in,func_out);


	MUX m_MUX(p_in,NPC_out,j_bub,pc_in,
    25_21,20_16,EXTOP,
    Syscall1,ra1,
    rb1,
    15_11,RegDst,rw2,
    jal1,rw1,
    A,w_MEM,A_MEM,A_f1,
    w_RB,A_WB,A_f,
    B,B_MEM,B_f1,
    B_WB,B_f,
    ext_out,ALUsrc,Y,
    p_in2,jal2,R2,
    B2,sh2,data_in,
    R3,data3,MemToReg_WB,
    jal,p_in3);



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