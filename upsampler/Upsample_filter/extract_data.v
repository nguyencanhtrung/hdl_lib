`timescale 1ns/1ps

module extract_data #(
	parameter N = 32,
	parameter start_bit = N-2,
	parameter stop_bit = 0
)
(
	input [N-1:0] din,
	output [start_bit-stop_bit+1:0] dout
);
	assign dout = {din[N-1], din[start_bit:stop_bit]};
endmodule