`timescale 1ns/1ns
module registerfile_tb;

localparam N = 4;

logic clk;
logic rst_n;
logic write_en;
logic [3:0] write_addr;
logic [7:0] data_in;
logic [3:0] read_addr1;
logic [3:0] read_addr2;
logic [7:0] data_out1;
logic [7:0] data_out2;

registerfile uut(.clk(clk),.rst_n(rst_n),.write_en(write_en),.write_addr(write_addr),.data_in(data_in),
.read_addr1(read_addr1),.read_addr2(read_addr2),.data_out1(data_out1),.data_out2(data_out2));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst_n = 0;
        write_en = 0;
        write_addr = 0;
        data_in = 0;
        read_addr1 = 0;
        read_addr2 = 0;
        
        #10;
        rst_n = 1;
        #10;

        // Write some data to registers
		write_en = 1;
        write_addr = 5;     
        data_in = 8'b11110000; 
        #10;
        write_addr = 10;     
        data_in = 8'b11111111;
        #10;
        
        write_en = 0;    
        
        // Read back from the registers
        read_addr1 = 5;     
        read_addr2 = 10;    
        #10;
        

        rst_n = 0;
        #10;
        rst_n = 1;
        #10;
		
        read_addr1 = 5;
        read_addr2 = 10;
        #10;

        $stop;
    end

    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b write_en=%b write_addr=%b data_in=%b read_addr1=%b read_addr2=%b data_out1=%b data_out2=%b", 
                 $time, clk, rst_n, write_en, write_addr, data_in, read_addr1, read_addr2, data_out1, data_out2);
    end

endmodule