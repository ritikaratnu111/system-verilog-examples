// -----------------------------
// Design Name	:	shift_register
//File Name	:	shift_register_tb
//Function	:	test bench for shift register
//Author	:	Ritika Ratnu
// ---------------------------------

import pkg::*;

`timescale 1ns / 1ns

module shift_register_tb;

//WIRES
reg CLK,RST,SHIFT_REG_IN_VALID;
reg [SAMPLE_WIDTH-1:0] SHIFT_REG_IN;
reg [SAMPLE_WIDTH-1:0] SHIFT_REG_OUT [FILTER_TAPS-1:0];

//UUT
shift_register uut(
	.CLK(CLK),
	.RST(RST),
	.SHIFT_REG_IN_VALID(SHIFT_REG_IN_VALID),
	.SHIFT_REG_IN(SHIFT_REG_IN),
	.SHIFT_REG_OUT(SHIFT_REG_OUT)
);

// CLOCK
always begin
    #10 CLK = ~CLK;
end

// TESTCASE
initial begin
	CLK=0;
	RST=1;
	SHIFT_REG_IN_VALID=0;
	SHIFT_REG_IN=10'h0;
	
	#20 RST=0;

	#30 SHIFT_REG_IN_VALID=1;
	#30 SHIFT_REG_IN=10'h1;
	#60 SHIFT_REG_IN_VALID=0;


	#100 SHIFT_REG_IN_VALID=1;
	#100 SHIFT_REG_IN=10'h2;
	#130 SHIFT_REG_IN_VALID=0;


	#180 SHIFT_REG_IN_VALID=1;
	#180 SHIFT_REG_IN=10'h3;
	#210 SHIFT_REG_IN_VALID=0;

end

endmodule
