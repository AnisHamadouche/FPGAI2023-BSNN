module dtt_tb ();

parameter TEST_VECTOR = 1;
reg CLK, nRES, start;

wire spike;
reg [4:0] input_vector;


dtt #(
    .DTT_WIDTH(5)
) DUT (
    .CLK(CLK),
    .nRES(nRES),
    .input_vector(input_vector),
    .start(start),
    .spike(spike)
);

initial begin
    nRES = 0;
    CLK = 0;
    input_vector = '0;
    start = 0;
    #3
    nRES = 1;
    #2
    input_vector = TEST_VECTOR;
    #2
    start = 1;
    #2
    start = 0;
    #100
    $finish;
end

always begin
    #1 CLK = ~CLK;
end

always @(posedge CLK) begin
    $display("Time %0t spike %0b start %0b", ($time-1)/2, spike, start);
end

endmodule