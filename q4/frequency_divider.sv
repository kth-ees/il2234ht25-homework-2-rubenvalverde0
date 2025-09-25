module frequency_divider (input logic clk,
                          input logic rst_n,
                          output logic divider_out);
  
    logic co1,co2,co3,co4;
    logic [15:0] pi;
    logic tff_q; 
    logic load_signal;

    parameter [15:0] value_18 = 65536 - 18;
    parameter [15:0] value_866 = 65536 - 866;

    assign pi = tff_q ? value_866 : value_18;

    upcnt4 c1 (.PI(pi[3:0]),.clk(clk),.rst_n(rst_n),.cnt(1'b1),.ld(load_signal),.Ci(1'b1),.PO(),.CO(co1));
    upcnt4 c2 (.PI(pi[7:4]),.clk(clk),.rst_n(rst_n),.cnt(1'b1),.ld(load_signal),.Ci(co1),.PO(),.CO(co2));
    upcnt4 c3 (.PI(pi[11:8]),.clk(clk),.rst_n(rst_n),.cnt(1'b1),.ld(load_signal),.Ci(co2),.PO(),.CO(co3));
    upcnt4 c4 (.PI(pi[15:12]),.clk(clk),.rst_n(rst_n),.cnt(1'b1),.ld(load_signal),.Ci(co3),.PO(),.CO(co4));

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tff_q <= 1'b0;
        end else if (load_signal) begin
            tff_q <= ~tff_q;  
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            load_signal <= 1'b1;
        end else begin
            load_signal <= co4; 
        end
    end

    assign divider_out = load_signal;
endmodule