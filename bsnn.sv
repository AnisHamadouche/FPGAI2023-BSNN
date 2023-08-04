/* 
*  Spinking Binary Neural Network Tile
*  Input-Vector should come from the Switch-Matrix 
*  Weights should be configuration latches
*  output vector should go to the switch-matrix
* 
*/

module bsnn #(
    parameter N_NEURONS = 4,
    parameter WEIGHT_WIDTH = 1,
    parameter DTT_WIDTH = 5,
    parameter TTD_WIDTH = 5
    )(
    input wire CLK,
    input wire nRST,
    input wire start,
    input wire [DTT_WIDTH-1:0] input_vector [N_NEURONS-1:0],
    input wire [WEIGHT_WIDTH-1:0] weights [(N_NEURONS * 4)-1:0],
    output wire [TTD_WIDTH-1:0] output_vector [N_NEURONS-1:0],
    output wire finish
);
/*

*/

wire spike_out0, spike_out1, spike_out2, spike_out3; 
wire spike0, spike1, spike2, spike3; 
wire finish0, finish1, finish2, finish3; 
wire [3:0] spikes_in; 


assign spikes_in = {spike3, spike2, spike1, spike0}; 

bsnn_lif NRN0 (
    .CLK(CLK),
    .nRST(start),
    .spike_in(spikes_in),
    .spike_out(spike_out0),
    .weight0(weights[0]),
    .weight1(weights[1]),
    .weight2(weights[2]),
    .weight3(weights[3])
);

bsnn_lif NRN1 (
    .CLK(CLK),
    .nRST(start),
    .spike_in(spikes_in),
    .spike_out(spike_out1),
    .weight0(weights[4]),
    .weight1(weights[5]),
    .weight2(weights[6]),
    .weight3(weights[7])
);


bsnn_lif NRN2 (
    .CLK(CLK),
    .nRST(start),
    .spike_in(spikes_in),
    .spike_out(spike_out2),
    .weight0(weights[8]),
    .weight1(weights[9]),
    .weight2(weights[10]),
    .weight3(weights[11])
);


bsnn_lif NRN3 (
    .CLK(CLK),
    .nRST(start),
    .spike_in(spikes_in),
    .spike_out(spike_out2),
    .weight0(weights[12]),
    .weight1(weights[13]),
    .weight2(weights[14]),
    .weight3(weights[15])
);




dtt dtt0(
    .CLK(CLK),
    .nRES(nRST),
    .input_vector(input_vector[0]),
    .start(start),
    .spike(spike0)
);


dtt dtt1(
    .CLK(CLK),
    .nRES(nRST),
    .input_vector(input_vector[1]),
    .start(start),
    .spike(spike1)
);

dtt dtt2(
    .CLK(CLK),
    .nRES(nRST),
    .input_vector(input_vector[2]),
    .start(start),
    .spike(spike2)
);

dtt dtt3(
    .CLK(CLK),
    .nRES(nRST),
    .input_vector(input_vector[3]),
    .start(start),
    .spike(spike3)
);


ttd ttd0(
    .CLK(CLK),
    .nRES(nRST),
    .start(start),
    .spikes({spike_out0, spike_out1, spike_out2, spike_out3}),
    .output_vectors(output_vector),
    .finish(finish)
);
/*
ttd ttd1(
    .CLK(CLK),
    .nRES(nRST),
    .start(start),
    .spikes(spike_out1),
    .output_vectors(output_vector[1]),
    .finish(finish)
);
ttd ttd2(
    .CLK(CLK),
    .nRES(nRST),
    .start(start),
    .spikes(spike_out2),
    .output_vectors(output_vector[2]),
    .finish(finish)
);
ttd ttd3(
    .CLK(CLK),
    .nRES(nRST),
    .start(start),
    .spikes(spike_out3),
    .output_vectors(output_vector[3]),
    .finish(finish)
);
*/

endmodule
