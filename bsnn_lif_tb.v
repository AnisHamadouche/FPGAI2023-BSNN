`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2023 12:06:20
// Design Name: 
// Module Name: snn_lif_tb
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

module snn_lif_tb();

reg clk;
reg nrst;
reg [3:0] spike_in;
wire spike_out;

snn_lif LIF0(
    .CLK(clk),
    .nRST(nrst),
    .spike_in(spike_in),
    .spike_out(spike_out),
    .weight0(1'd0),
    .weight1(1'd1'),
    .weight2(1'd0),
    .weight3(1'd1)
);

    initial begin
        clk = 1'd0;
        nrst = 1'd0;
        spike_in = 4'b0000;  
        
        //Active reset phase
        #200; nrst = 1'd1;
        #200; nrst = 1'd0;
        #200; nrst = 1'd1;   
        
        //test case
        while(1) begin
            #1000; spike_in[0] = 1'd1;  #100; spike_in[0] = 1'd0;
            #1000; spike_in[1] = 1'd1;  #100; spike_in[1] = 1'd0;
            #1000; spike_in[0] = 1'd1;  #100; spike_in[0] = 1'd0;
            #1000; spike_in[0] = 1'd1;  #100; spike_in[0] = 1'd0;
            #1000; spike_in[0] = 1'd1;  #100; spike_in[0] = 1'd0;
            #1000; spike_in[2] = 1'd1;  #100; spike_in[2] = 1'd0;
            #1000; spike_in[3] = 1'd1;  #100; spike_in[3] = 1'd0;
        end              
    end
    
    //Clock synthetic generation
    always begin
        #50; clk = ~clk;
    end
    
   

endmodule
