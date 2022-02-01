// -------------------------------------
// Design Name		:	parallel_fir
// File Name		:	shift_register.sv
// Function 		:	Shift current N inputs when a new input arrives
// Author		:	Ritika Ratnu
// -----------------------------------------

import pkg::*;

module shift_register(
	input				CLK,
	input				RST,
	input 				SHIFT_REG_IN_VALID,
	input [SAMPLE_WIDTH-1:0]	SHIFT_REG_IN,
	output reg [SAMPLE_WIDTH-1:0]	SHIFT_REG_OUT [FILTER_TAPS-1:0]
); 

//WIRES
//reg [SAMPLE_WIDTH-1:0] SHIFT_REG_TEMP [FILTER_TAPS-1:0];

integer i;

// SHIFT REGISTER
always @(posedge CLK) begin
	if (RST) begin

		for (i=0; i<FILTER_TAPS; i++)
			SHIFT_REG_OUT[i] <= 0;
	end else begin
		if (SHIFT_REG_IN_VALID) begin
			SHIFT_REG_OUT[FILTER_TAPS-1] <= SHIFT_REG_IN;
			for (i=0; i<FILTER_TAPS-1; i++)
				SHIFT_REG_OUT[i] <= SHIFT_REG_OUT[i+1];
		end
	end
end


endmodule
