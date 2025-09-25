`timescale 1ns/1ns

module LFSR_6bit_tb;

    logic clk, rst_n;
    logic sel;
    logic [5:0] parallel_in;
    logic [5:0] parallel_out;

    LFSR_6bit uut(.clk(clk),.rst_n(rst_n),.sel(sel),.parallel_in(parallel_in),.parallel_out(parallel_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0; sel = 1'b0; parallel_in = 6'b000000; 
        #12 rst_n = 1'b1;
        #10 sel = 1'b1; parallel_in = 6'b111000;
	    #10 sel = 1'b0; 
        #50 $stop;
    end
    
    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b sel=%b parallel_in=%b parallel_out=%b", 
                 $time, clk, rst_n, sel, parallel_in, parallel_out);
    end

endmodule