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
    wire bub1;

	//DEC
	wire [5:0]op1;
	wire [4:0]i_25_21;
	wire [4:0]i_20_16;
	wire [4:0]i_15_11;
	wire [4:0]i_10_6;
	wire [5:0]func1;
	wire [15:0] i_15_0;
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
    wire bub2;
	wire [31:0] p_out1;
    wire ALUsrc;
    wire WE_EX;
    wire memtoreg;
    wire memwrite;
    wire blez,beq,bne;
    wire j,jr,jal_EX;
    wire [3:0] ALUOP;
    wire Syscall,sh;
    wire [31:0] A,B,ext_out,index;
    wire [4:0] rw1;//MUX use
    wire [4:0] Rd_EX,RA,RB;
    wire [5:0] op,func;

    //DISP
    wire [31:0]syscallout;

    //ALU
    wire [31:0] A_f;//MUX
    wire [31:0] Y;
    wire OF;
    wire CF;
    wire EQ;
    wire [31:0]R;
    wire [31:0]R2_alu;

    //NPC
    wire correct_b,jmp;
    wire [31:0] NPC_out;

    //JBUB
    wire j_bub;

    //HALT
    wire halt_EX;

    //EXMEM
    wire [31:0] p_in2;
    wire WE;
    wire MemToReg_M,MemWrite_M;
    wire jal2,sh2,halt_MEM;
    wire [31:0] R2;
    wire [31:0] B_f;//MUX
    wire [31:0] B2;
    wire [4:0] Rd;

    //DS
    wire    [1:0]mode;  //信号?0时字访问?1时字节访?
    wire    [11:0] extra_addr;
    wire    [11:0] d_address;
    wire    [31:0] data_in; //MUX
    wire    [31:0] d_data_out;
    wire    [31:0] extra_dout;

    //MEM_WB
    wire [31:0] p_in3;
    wire MemToReg_WB;
    wire jal;
    wire halt;
    wire [31:0] R3,data3;

    //FOR
    wire A_MEM,A_WB,B_MEM,B_WB;

    //LOAD
    wire loaduse;
    
    //MUX
    wire [31:0]w_MEM;
    
    //CACU
    wire [31:0]total;
    wire [31:0]conditional;
    wire [31:0]unconditional;
    wire [31:0]conditional_success;
    wire [31:0]lu_times;
    wire LOCK;

    //TYPE
    wire [31:0]chose_out;
    wire [11:0]RAM_addr;

    assign address = pc_out[9:0];
	assign pause = (!((~LOCK) & (~loaduse)));
	assign p_in = pc_out+1;
    assign bub1 = (j_bub||RST);
    assign bub2 = (j_bub||RST||loaduse);
    assign mode = 0;//只使用字访问
    assign d_address = R2[11:0];
    assign extra_addr = RAM_addr;



    DIV m_DIV(clk_in,choose,clk_out);
    PC m_PC(clk_out,pause,RST,pc_in,pc_out);
    IS m_IS(address, data_out);
    IF_ID m_IFID(clk_out,bub1,pause,p_in,p_out,data_out,i_out);
    DEC m_DEC(i_out,op1,i_25_21,i_20_16,i_15_11,i_10_6,func1,i_15_0,index1);
    CONT m_CONT(op1,func1,Syscall1,ALUOP1,jr1,jal1,j1,bne1,beq1,blez1,EXTOP,Memwrite1,MemToReg1,Regwrite1,ALUsrc1,RegDst1,sh1);
    EXT m_EXT(i_15_0,i_10_6,ext_out1,EXTOP);
    REGF m_REGF(clk_out, WB, RW, ra1, rb1, w_RB, A1, B1);
    ID_EX m_IDEX(clk_out,bub2,LOCK,p_out,p_out1,
    ALUsrc1,ALUsrc,MemToReg1,memtoreg,
    Memwrite1,memwrite,blez1,blez,beq1,beq,
    bne1,bne,j1,j,jal1,jal_EX,jr1,jr,
    Syscall1,Syscall,ALUOP1,ALUOP,sh1,sh,
    Regwrite1,WE_EX,A1,A,B1,B,ext_out1,ext_out,
    index1,index,rw1,Rd_EX,ra1,RA,rb1,RB,
    op1,op,func1,func);
    DISP m_DISP(clk_out,RST,Syscall,A_f,B_f,syscallout);
    ALU m_ALU(A_f,Y,ALUOP,OF,CF,EQ,R,R2_alu);
    NPC m_NPC(j,jal_EX,jr,beq,bne,blez,EQ,A_f,p_out1,ext_out,index,correct_b,NPC_out,jmp);
    JBUB m_JBUB(clk_out,RST,jmp,correct_b,j_bub);
    HALT m_HALT(A_f,Syscall,RST,halt_EX);
    EX_MEM m_EXMEM(clk_out,RST,LOCK,p_out1,p_in2,
    memtoreg,MemToReg_M,memwrite,MemWrite_M,
    jal_EX,jal2,sh,sh2,halt_EX,halt_MEM,
    WE_EX,WE,R,R2,B_f,B2,
    Rd_EX,Rd);
    DS m_DS(MemWrite_M, clk_out, RST, mode, d_address, extra_addr, data_in, d_data_out, extra_dout);
    MEM_WB m_MEMWB(clk_out,RST,LOCK,p_in2,p_in3,
    MemToReg_M,MemToReg_WB,
    jal2,jal,halt_MEM,halt,
    WE,WB,R2,R3,d_data_out,data3,
    Rd,RW);
    FORW m_FORW(Rd,RA,RB,RW,WE,WB,ALUsrc,op,func,A_MEM,A_WB,B_MEM,B_WB);
    LOAD m_LOAD(Rd_EX,ra1,rb1,WE_EX,ALUsrc1,op1,func1,memtoreg,memwrite,loaduse);
	MUX m_MUX(p_in,NPC_out,j_bub,pc_in,
    i_25_21,i_20_16,EXTOP,
    Syscall1,ra1,
    rb1,
    i_15_11,RegDst1,
    jal1,rw1,
    A,w_MEM,A_MEM,
    w_RB,A_WB,A_f,
    B,B_MEM,
    B_WB,B_f,
    ext_out,ALUsrc,Y,
    p_in2,jal2,R2,
    B2,sh2,data_in,
    R3,data3,MemToReg_WB,
    jal,p_in3);
    CACU m_CACU(RST,clk_out,halt,total,conditional,unconditional,
    conditional_success,j,jal_EX,jr,blez,beq,bne,correct_b,
    loaduse,lu_times,LOCK);
    LED m_LED(reset,pro_reset,in_addr,leds);
    TYPEC m_TYPEC(clk_out,syscallout,extra_dout,pc_out,total,unconditional,conditional,conditional_success,lu_times,pro_reset,in_addr,chose_out,RAM_addr);
    SHOW m_SHOW(clk_in,chose_out,SEG,AN);

endmodule