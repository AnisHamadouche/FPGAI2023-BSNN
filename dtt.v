module dtt #(
    parameter DTT_WIDTH = 5
)(
    input wire CLK,
    input wire nRES,
    input wire [DTT_WIDTH-1:0] input_vector,
    input wire start,
    output wire spike
);

reg [DTT_WIDTH-1:0] state;

always @(posedge CLK) begin
    if (!nRES) begin
        state <= '0;
    end
    else if (start) begin
        state <= input_vector;
    end
    else if (state == 0)
        spike <= state;
    else begin
        state <= state - 1;
    end
end

assign spike = (state == 1);

endmodule