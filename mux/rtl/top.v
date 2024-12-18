module mux16to1 (
	input wire [15:0] data_in,
	input wire [3:0] sel,
	input wire en,
	output reg y
);

always @(*) begin
	y = (!en) ? 1'b0 : data_in[sel];
end

endmodule

