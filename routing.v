module snn #(
    parameter N_NEURONS = 4,
    parameter WEIGHT_WIDTH = 4,
    parameter DTT_WIDTH = 5,
    parameter TTD_WIDTH = 5
    )(
    input wire CLK,
    input wire nRST,
    input wire start,
    input wire [N_NEURONS-1:0] input_vector [DTT_WIDTH-1:0],
    input wire [N_NEURONS-1:0] weights [(WEIGHT_WIDTH * 4)-1:0],
    output wire [N_NEURONS-1:0] output_vector [TTD_WIDTH-1:0],
    output wire finish
);
/*

*/

snn_lif NRN0 (
    .CLK(CLK),
    .nRST(local_rst),
    .spike_in(),
    .spike_out(),
    .weight0(),
    .weight1(),
    .weight2(),
    .weight3()
);



endmodule