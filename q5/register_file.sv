module registerfile (input logic clk,
                     input logic rst_n,
                     input logic write_en,
                     input logic [3:0] write_addr,
                     input logic [7:0] data_in,
                     input logic [3:0] read_addr1,
                     input logic [3:0] read_addr2,
                     output logic [7:0] data_out1,
                     output logic [7:0] data_out2
                     );

    parameter DATA_WIDTH = 8;  
    parameter NUM_REGS = 16;                     
    logic [DATA_WIDTH-1:0] regs [NUM_REGS];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < NUM_REGS; i++) begin
                regs[i] <= '0;
            end
        end else if (write_en) begin
            regs[write_addr] <= data_in;
        end
        data_out1 <= regs[read_addr1];
        data_out2 <= regs[read_addr2];
    end   
endmodule