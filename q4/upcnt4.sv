module upcnt4 (
    input  logic [3:0] PI,
    input  logic clk,
    input  logic rst_n,
    input  logic cnt,
    input  logic ld,
    input  logic Ci,
    output logic [3:0] PO,
    output logic CO
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            PO <= 4'd0;
        end else begin
            if (ld) begin
                PO <= PI;
            end else if (cnt) begin
                PO <= Ci ? (PO + 1) : PO;
            end
        end
    end

    assign CO = cnt ? &{PO, Ci} : 1'b0;

endmodule
