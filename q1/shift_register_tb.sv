`timescale 1ns/1ns

module shift_register_tb;
    localparam N = 4;

    logic clk;
    logic rst_n;
    logic serial_parallel;
    logic load_enable;
    logic serial_in;
    logic [N-1:0] parallel_in;
    logic [N-1:0] parallel_out;
    logic serial_out;

    shift_register uut(.clk(clk),.rst_n(rst_n),.serial_parallel(serial_parallel),
    .load_enable(load_enable),.serial_in(serial_in),.parallel_in(parallel_in),.parallel_out(parallel_out),
    .serial_out(serial_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0; serial_parallel = 1'b0; load_enable = 1'b0; parallel_in = 4'b0000; serial_in = 1'b0;
        #12 rst_n = 1'b1;
        #10 load_enable = 1'b1; serial_in = 1'b1;
        #50 load_enable = 1'b0; serial_in = 1'b0;
        #10 load_enable = 1'b1; serial_parallel = 1'b1;parallel_in = 4'b1100;
        #30 $stop;
    end
    
    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b load_enable=%b serial_parallel=%b serial_in=%b parallel_in=%b serial_out=%b parallel_out=%b", 
                 $time, clk, rst_n, load_enable, serial_parallel, serial_in, parallel_in, serial_out, parallel_out);
    end


endmodule