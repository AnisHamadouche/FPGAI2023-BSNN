`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2023 11:40:27 AM
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

module snn_dense_layer # (parameter NEURON_NB=4, IN_SIZE=4, WIDTH = 4)(
    input clk,
    input layer_en,
    input reset,
    input signed [0:IN_SIZE-1] in_data,
    input signed[WIDTH-1:0][0:NEURON_NB-1][0:IN_SIZE-1] weights ,
    input signed[WIDTH-1:0][0:NEURON_NB-1] biases ,
    output signed[WIDTH + 1-1:0][0:NEURON_NB-1] neuron_out ,
    output layer_done
    );
    
    reg [0:NEURON_NB-1] neuron_done;
    reg done = 0;
    
    neuron #(.IN_SIZE(IN_SIZE), .WIDTH(WIDTH)) dense_neuron[0:NEURON_NB-1] (.clk(clk), .en(layer_en), .reset(reset), 
                                                                            .in_data(in_data), .weight(weights), .bias(biases), 
                                                                            .neuron_out(neuron_out), .neuron_done(neuron_done)); // Neuron submodules
    always @(posedge clk) begin
        if(neuron_done == "1") begin //All neurons done
            done <= 1;
        end
    end
    
    assign layer_done = done;

    
endmodule