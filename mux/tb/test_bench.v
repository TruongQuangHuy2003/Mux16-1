`timescale 1ns/1ps
module test_bench;
	reg [15:0] data_in;
	reg [3:0] sel;
	reg en;
	wire y;
	
	mux16to1 uut(
		.data_in(data_in),
		.sel(sel),
		.en(en),
		.y(y)
	);

	integer i = 0;

	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);
		
		$display("-------------------------------------------------------------------------------");
		$display("------------------------TESTBENCH FOR MULTIPLEXER 16:1-------------------------");
		$display("-------------------------------------------------------------------------------");
		
		for (i = 0; i < 16; i = i + 1) begin
			en = 0;
			data_in = $random % 65535;
			sel = i;
			#1;
			check_result(1'b0);
			#10; 
		end

		for (i = 0; i < 16; i = i + 1) begin
			en = 1;
			data_in = $random % 65535;
			sel = i;
			#1;
			check_result(calc_expected(data_in,sel,en));
			#10;
		end

		for (i = 0; i < 20; i = i+ 1) begin
			en = $random % 2;
			data_in = $random % 65535;
			sel = $random % 16;
			#1;
			check_result(calc_expected(data_in,sel,en));
			#10;
		end

		#100;
		$finish;

	end

	function calc_expected (input [15:0] in, input [3:0] sel_val, input en_val);
		begin
			calc_expected = (!en_val) ? 0: in[sel_val];
		end
	endfunction


	task check_result;
		input expected_result;
		begin
			$display("At time: %t, en = 1'b%b, sel = 4'b%b, data_in = 16'b%b", $time, en, sel, data_in);
			if ( y == expected_result) begin
				$display("-------------------------------------------------------------------------------");
				$display("PASSED: expected: 1'b%b, Got: 1'b%b", expected_result, y);
				$display("-------------------------------------------------------------------------------");
			end else begin
				$display("-------------------------------------------------------------------------------");
				$display("FAILED: expected: 1'b%b, Got: 1'b%b", expected_result, y);
				$display("-------------------------------------------------------------------------------");
			end
		end
	endtask
endmodule

