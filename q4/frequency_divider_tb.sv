`timescale 1ns/1ns
module frequency_divider_tb;

logic clk;
logic rst_n;
logic divider_out;
logic [15:0] p_out;

frequency_divider uut(.clk(clk),.rst_n(rst_n),.divider_out(divider_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0; 
        #12 rst_n = 1'b1;
        #10000 $stop;
    end
    
    initial begin
        $monitor("Time=%0t |  divider_out=%b", 
                 $time, divider_out);
    end

endmodule