
`timescale 1ns / 1ps
module routing_tb ();

reg clk;
reg nrst;
reg start; 
reg [3:0] input_vector [4:0];
reg [3:0] weights [15:0];
wire [3:0] output_vector [4:0];
wire finish;

snn snn_DUT(
    .CLK(clk),
    .nRST(nrst),
    .start(start), 
    .input_vector(input_vector), 
    .weights(weights), 
    .output_vector(output_vector), 
    .finish(finish)
);

    initial begin
        clk = 1'd0;
        nrst = 1'd0;
        input_vector = 0;  
        weights = 0; 
        //Active reset phase
        #200; nrst = 1'd1;
        #200; nrst = 1'd0;
        #200; nrst = 1'd1;   
        
        //test case
            #200; 
                input_vector  = {4'b0001,     4'b0010,    4'b0100,    4'b1000   }; 
                weights       = {16'h1111,    16'h2222,   16'h3333,   16'h4444  }; 
            #200; 
            start = 1; 
            @(finish); 
            #200; 
            
            
            #10000; 
            $finish; 
    end
    
    //Clock synthetic generation
    always begin
        #50; clk = ~clk;
    end
endmodule