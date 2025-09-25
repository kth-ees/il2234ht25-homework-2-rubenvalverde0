`timescale 1ns/1ns

module up_down_counter_tb;
    localparam N = 4;

    logic clk;
    logic rst_n;
    logic up_down;
    logic load;
    logic [N-1:0] input_load;
    logic [N-1:0] count_out;
    logic carry_out;

    up_down_counter uut(.clk(clk),.rst_n(rst_n),.up_down(up_down),
    .load(load),.input_load(input_load),.count_out(count_out),.carry_out(carry_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0; up_down = 1'b1; load = 1'b0; input_load = 1'b0000; 
        #12 rst_n = 1'b1;
        #180 load = 1'b1; input_load = 4'b1100;
	    #10 load = 1'b0; 
        #50 load = 1'b1; up_down = 1'b0; input_load = 4'b0011;
	    #10 load = 1'b0;
        #50 $stop;
    end
    
    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b up_down=%b load=%b input_load=%b count_out=%b carry_out=%b", 
                 $time, clk, rst_n, up_down, load, input_load, count_out, carry_out);
    end


endmodule