                                      `timescale 1ns/1ps
module get_data_DUC #(parameter N = 16)
(
	input clk,
	input rst_n,
	// input channel_up,
	input [N-1:0] din_tdata,
	input din_tvalid,
	input dout_tready,
	output din_tready,
	output [N-1:0] dout_tdata,
	output dout_tvalid
);
	reg [2:0] cnt;
	reg din_tready_reg;
	reg dout_tvalid_reg;


	assign din_tready = ((cnt == 3'b001) || (cnt==3'b100)) && dout_tready;
	assign dout_tvalid = din_tready;
	assign dout_tdata = din_tdata;
	// assign dout_tvalid = (cnt != 3'b0);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			// reset
			cnt <= 3'b0;
		end
		else if (din_tvalid && dout_tready)
		begin
			cnt <= cnt + 1'b1;
			if (cnt == 3'b100) cnt <= 3'b0;
		end
		else begin
			cnt <= 3'b0;
		end
	end

	// always @(posedge clk or posedge rst_n) begin
	// 	if (!rst_n) begin
	// 		// reset
	// 		din_tready_reg <= 1'b0;
	// 	end
	// 	else begin
	// 		din_tready_reg <= din_tready;
	// 	end
	// end

	// always @(posedge clk or negedge rst_n) begin
	// 	if (!rst_n) begin
	// 		// reset
	// 		// din_tready <= 1'b0;
	// 		// dout_tvalid_reg <= 1'b0;
	// 		dout_tdata <= {N{1'b0}};
	// 	end
	// 	else begin
	// 		if (din_tready_reg)
	// 		begin
	// 			dout_tdata <= din_tdata;
	// 			// din_tready <= 1'b1;
	// 			// dout_tvalid_reg <= 1'b1;
	// 		end
	// 		// else begin
	// 		// 	dout_tvalid_reg <= 1'b0;
	// 		// 	// din_tready <= 1'b0;
	// 		// end
	// 	end
	// end
endmodule