// ---------------------------------
// Design Name  :   parallel_fir
// File Name    :   parallel_fir.sv
// Function      :   Compute N-point FIR using N MAC units
// Author        :   Ritika Ratnu
// --------------------------------

import pkg::*;

module parallel_fir(
    input                       CLK,
    input                       RST,
    input                       DATA_IN_VALID,
    input [SAMPLE_WIDTH-1:0]    DATA_IN,
    output                      DATA_OUT_VALID,
    output [SAMPLE_WIDTH-1:0]   DATA_OUT
);

// WIRES
logic [SAMPLE_WIDTH-1:0] AU_DATA_IN [FILTER_TAPS-1:0];
logic [SAMPLE_WIDTH-1:0] FIR_COEFF [FILTER_TAPS-1:0];
wire [RESULT_WIDTH-1:0] AU_DATA_OUT;
wire FSM_OUT_VALID;

// SHIFT REGISTER
shift_register SHIFT_REGISTER_1(
    .CLK(CLK),
    .RST(RST),
    .SHIFT_REG_IN_VALID(DATA_IN_VALID),
    .SHIFT_REG_IN(DATA_IN),
    .SHIFT_REG_OUT(AU_DATA_IN)
);

// FIR COEFFICIENTS FROM ASYNCHRONOUS ROM
arom FIR_COEFF(
    .AROM_OUT(FIR_COEFF)
);

// ARITHMETIC UNIT WITH MACS
arithmetic_unit AU1(
    .AU_DATA_IN(AU_DATA_IN),
    .AU_COEFF_IN(FIR_COEFF),
    .AU_DATA_OUT(AU_DATA_OUT)
);

// FSM FOR DATA_OUT_VALID
fsm FSM1(
    .CLK(CLK),
    .RST(RST),
    .FSM_IN_VALID(DATA_IN_VALID),
    .FSM_OUT_VALID(FSM_OUT_VALID)
);

//OUTPUT REGISTER
always @(posedge CLK) begin
    if (RST) begin
        DATA_OUT <= 0;
    end else begin
        if (FSM_OUT_VALID) begin
            OUTPUT_REGISTER_OUT <= AU_DATA_OUT;
        end else begin
            OUTPUT_REGISTER_OUT <- 0;
        end
    end
end

DATA_OUT_VALID <= FSM_OUT_VALID;

endmodule;
