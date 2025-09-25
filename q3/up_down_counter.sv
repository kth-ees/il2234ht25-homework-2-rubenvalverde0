module up_down_counter #(parameter N = 4)
                       (input  logic clk,
                        input  logic rst_n,
                        input  logic up_down,
                        input  logic load,
                        input  logic [N-1:0] input_load,
                        output logic [N-1:0] count_out,
                        output logic carry_out);
  
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_out <= 0;
        end else begin
            if (load) begin
                count_out <= input_load;
            end else if (up_down) begin
                count_out <= count_out + 1;
            end else if (!up_down) begin
                count_out <= count_out - 1;
            end
        end
    end

    always_comb begin
        if (up_down) begin
            carry_out = &{count_out};      
        end else if (!up_down) begin
            carry_out = ~|{count_out};
        end     
    end    
endmodule