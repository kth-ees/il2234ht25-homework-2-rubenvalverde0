module LFSR_6bit (
  input  logic clk, rst_n,
  input  logic sel,
  input  logic [5:0] parallel_in,
  output logic [5:0] parallel_out
);

	logic [5:0] regs;
	assign parallel_out = regs;	

	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			regs <= '0;
		end else begin
			if (sel) begin
				regs <= parallel_in;
			end else if (!sel) begin
				regs[0] <= regs[5];
				regs[1] <= regs[5] ^ regs[0];
				regs[2] <= regs[1];
				regs[3] <= regs[5] ^ regs[2];
				regs[4] <= regs[3];
				regs[5] <= regs[4];
			end
		end
	end
endmodule
