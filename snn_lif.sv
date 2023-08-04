module snn_lif#(parameter WEIGHT_WIDTH = 4'd4)(
    //--- Global control lines
    input wire CLK,
    input wire nRST,
    //--- LIF input and output
    input wire [3:0] spike_in,
    output wire spike_out,
    //Weights from configuration matrix
    input wire signed [WEIGHT_WIDTH-'d1:0] weight0,
    input wire signed [WEIGHT_WIDTH-'d1:0] weight1,
    input wire signed [WEIGHT_WIDTH-'d1:0] weight2,
    input wire signed [WEIGHT_WIDTH-'d1:0] weight3
);

localparam MID_VAL0 = 0, SNN_RST_VAL = 'd0; //('d1 << 5);

reg signed [5:0] snn_cnt_internal;
wire signed [5:0] sum_cnt [3:0];

reg cnt_msb;
wire [2:0] snn_leak0;

assign sum_cnt[0] = spike_in[0] ? (weight0[3] ? {weight0[3], 2'b11, weight0[2:0]} : {2'd00, weight0}) : MID_VAL0;
assign sum_cnt[1] = spike_in[1] ? (weight1[3] ? {weight1[3], 2'b11, weight1[2:0]} : {2'd00, weight1}) : MID_VAL0;
assign sum_cnt[2] = spike_in[2] ? (weight2[3] ? {weight2[3], 2'b11, weight2[2:0]} : {2'd00, weight2}) : MID_VAL0;
assign sum_cnt[3] = spike_in[3] ? (weight3[3] ? {weight3[3], 2'b11, weight3[2:0]} : {2'd00, weight3}) : MID_VAL0;
assign snn_leak0 = 3'b000;

assign spike_out = snn_cnt_internal[5] && !cnt_msb;

always@(posedge CLK) begin
    if(!nRST) begin
        snn_cnt_internal <= SNN_RST_VAL;
        cnt_msb <= 1'b0;
    end else begin
        if(!spike_out) begin
            snn_cnt_internal <= snn_cnt_internal + sum_cnt[0] + sum_cnt[1] + sum_cnt[2] + sum_cnt[3] - {3'd0, snn_leak0};
        end else begin
            snn_cnt_internal <= SNN_RST_VAL;
        end  
        cnt_msb <= snn_cnt_internal[5];
    end
end

endmodule
