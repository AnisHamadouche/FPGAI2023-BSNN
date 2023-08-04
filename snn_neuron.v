`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2023 11:42:33 AM
// Design Name: 
// Module Name: snn_neuron
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


module neuron #(parameter IN_SIZE=4, WIDTH = 4)(
    input clk,
    input en,
    input reset,
    input signed [0:IN_SIZE-1] in_data,
    input signed[WIDTH-1:0][0:IN_SIZE-1] weight,
    input signed[WIDTH-1:0] bias,
    output signed[WIDTH + 1-1:0] neuron_out,
    output neuron_done
    );
    
    integer addr = 0;
    reg done = 0;
    
    reg signed [4*WIDTH-1:0] product = 0;
    reg signed [4*WIDTH-1:0] out = 0;
    
    always @(posedge clk) begin
        if(reset) begin 
            done <= 0;
            addr <= 0;
        end
        else if(en) begin
//            if (IN_SIZE == 1) begin
//                product <= in_data[0]*weight[addr]; //Calculate weighted input
//            end
            if(addr < IN_SIZE-1) begin
                product <= in_data[addr]*weight[addr]; //Calculate weighted input
                out <= out+product; //Sum each weighted input
               
            end
            if(addr == IN_SIZE-1) begin //Neuron output available
                done <= 1;
            end else begin
                addr <= addr + 1'b1;
                done <= 0;
            end
        end
    end
    
    assign neuron_out = out + bias; //Add bias
    assign neuron_done = done;
    
endmodule
