module i7_test();
	reg clk,RST;
	reg [2:0]pro_reset;
	reg [11:0]in_addr;
	wire [15:0]leds;
	wire [7:0]SEG;
    wire [7:0]AN;
    initial begin
    	clk = 0;
    	RST = 0;
    	pro_reset = 0;
    	in_addr = 0;
//    	$monitor("At time %t, ocnt = %d", $time, clk);
//    	$dumpfile("counter_test.vcd");
//		$dumpvars(0, i7test);
    end
    always #5 clk = ~clk;
	i7_6700k i7test(clk,RST,pro_reset,in_addr,leds,SEG,AN);
endmodule