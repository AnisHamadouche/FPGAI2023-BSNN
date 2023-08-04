`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2023 11:37:18
// Design Name: 
// Module Name: snn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// calculation
module bsnn_lif#(parameter WEIGHT_WIDTH = 1)(
    //--- Global control lines
    input wire CLK,
    input wire nRST,
    //--- LIF input and output
    input wire [3:0] spike_in,
    output wire spike_out,
    //Weights from configuration matrix
    input wire weight0,
    input wire weight1,
    input wire weight2,
    input wire weight3
);

localparam MID_VAL0 = 0, SNN_RST_VAL = 1'b0; //('d1 << 5);

reg [1:0] snn_cnt_internal;
wire sum_cnt [3:0];

reg cnt_msb;
wire snn_leak0;

assign sum_cnt[0] = spike_in[0] ? weight0 : MID_VAL0;
assign sum_cnt[1] = spike_in[1] ? weight1 : MID_VAL0;
assign sum_cnt[2] = spike_in[2] ? weight2 : MID_VAL0;
assign sum_cnt[3] = spike_in[3] ? weight3 : MID_VAL0;
assign snn_leak0 = 1'b0;

assign spike_out = snn_cnt_internal[1] && !cnt_msb;

always@(posedge CLK) begin
    if(!nRST) begin
        snn_cnt_internal <= SNN_RST_VAL;
        cnt_msb <= 1'b0;
    end else begin
        if(!spike_out) begin
            snn_cnt_internal <= snn_cnt_internal + {1'b0, sum_cnt[0]} + {1'b0, sum_cnt[1]} + {1'b0, sum_cnt[2]} + {1'b0, sum_cnt[3]} - {1'b0, snn_leak0};
        end else begin
            snn_cnt_internal <= SNN_RST_VAL;
        end  
        assign {cout, cnt_msb} <= snn_cnt_internal[1];

    end
end

endmodule

