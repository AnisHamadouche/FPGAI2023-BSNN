module ttd (
    parameter TTD_WIDTH = 5,
    parameter N_NEURONS = 4
)(
    input wire CLK,
    input wire nRES,
    input wire start,
    input wire [N_NEURONS-1:0] spikes,
    output reg [TTD_WIDTH:0] output_vectors [N_NEURONS-1:0],
    output reg finish
);

reg [TTD_WIDTH] cnt;
wire early_finish;
wire [N_NEURONS-1:0] output_vector_avail;

// allow a early finish (all neurons spiked)
genvar i;
generate
    for (i=0; i<N_NEURONS; i=i+1) begin
        output_vector_avail[i] = |output_vectors[i];
    end
endgenerate
assign early_finish = &output_vector_avail;

// control logic
always @(posedge CLK) begin
    if (!nRES) begin
        finish <= 1;
    end
    else begin
        if (start) begin
            finish <= 0;
        end
        else if (early_finish | &cnt) begin
            finish <= 1;
        end
    end
end

// counter logic
always @(posedge CLK) begin
    if (!nRES) begin
        cnt <= '0;
    end
    if (start) begin
        cnt <= '0 ? finish : cnt + 1;
    end
end

// output vectors
genvar i;
generate
    for (i=0; i<N_NEURONS; i=i+1) begin
        always @(posedge CLK) begin
            if (!nRES) begin
                output_vectors[i] <= '0;
            end
            else begin
                if (start & finish) begin
                    output_vector <= '0;
                end
                else if (spike[i]) begin
                    output_vector[i] <= cnt;
                end
            end
        end
    end
endgenerate

endmodule