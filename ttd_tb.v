module ttd_tb ();

parameter TEST_VECTOR = 1;
reg CLK, nRES, start;
reg [3:0] spikes;

wire finish;
wire [4:0] output_vectors [3:0];

ttd #(
    .TTD_WIDTH(5),
    .N_NEURONS(4)
    ) DUT (
    .CLK(CLK),
    .nRES(nRES),
    .start(start),
    .spikes(spikes),
    .output_vectors(output_vectors),
    .finish(finish)
);

initial begin
    nRES = 0;
    CLK = 0;
    spikes = '0;
    start = 0;
    #3
    nRES = 1;
    #4
    start = 1;
    #2
    start = 0;
    #6
    spikes[0] = 1;
    #2
    spikes[0] = 0;
    #130
    #2
    start = 1;
    #2
    start = 0;
    #20
    spikes = 4'b1111;
    #2
    spikes = 4'b0000;
    #20
    $finish;
end

always begin
    #1 CLK = ~CLK;
end

always @(posedge CLK) begin
    $display("Time %0t spike %0b start %0b finish %0b output_vector %d", ($time-1)/2, spikes[0], start, finish, output_vectors[0]);
end

endmodule