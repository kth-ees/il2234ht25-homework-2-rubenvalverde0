module shift_register #(parameter N=4)
                      (input logic clk,
                       input logic rst_n,
                       input logic serial_parallel,
                       input logic load_enable,
                       input logic serial_in,
                       input logic [N-1:0] parallel_in,
                       output logic [N-1:0] parallel_out,
                       output logic serial_out
);

    logic [N-1:0] regs;
    assign parallel_out = regs;
    assign serial_out = regs[N-1];
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
                for (int i = 0; i < N; i++) begin
                    regs[i] <= '0;
                end
        end else if (load_enable) begin
            if (serial_parallel) begin
                for (int i = 0; i < N; i++) begin
                    regs <= parallel_in;
                end
            end else if (!serial_parallel) begin
                regs <= {regs[N-2:0], serial_in};
            end
        end
    end        
endmodule
