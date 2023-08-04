module ttd #(
    parameter TTD_WIDTH = 5,
    parameter N_NEURONS = 4
)(
    input wire CLK,
    input wire nRES,
    input wire start,
    input wire [N_NEURONS-1:0] spikes,
    output reg [TTD_WIDTH-1:0] output_vectors [N_NEURONS-1:0],
    output reg finish
);

reg [TTD_WIDTH-1:0] cnt;
wire early_finish;
wire [N_NEURONS-1:0] output_vector_avail;

// allow a early finish (all neurons spiked)
genvar i;
generate
    for (i=0; i<N_NEURONS; i=i+1) begin
        assign output_vector_avail[i] = |(output_vectors[i]);
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
        else if (early_finish | (&cnt)) begin
            finish <= 1;
        end
    end
end

// counter logic
always @(posedge CLK) begin
    if (!nRES) begin
        cnt <= '0;
    end
    else begin
        cnt <= finish ? '0 : cnt + 1;
    end
end

// output vectors
always @(posedge CLK) begin
    if (!nRES) begin
        output_vectors[0] <= '0;
    end
    else begin
        if (start & finish) begin
            output_vectors[0] <= '0;
        end
        else if (spikes[0]) begin
            output_vectors[0] <= cnt;
        end
    end
end
always @(posedge CLK) begin
    if (!nRES) begin
        output_vectors[1] <= '0;
    end
    else begin
        if (start & finish) begin
            output_vectors[1] <= '0;
        end
        else if (spikes[1]) begin
            output_vectors[1] <= cnt;
        end
    end
end
always @(posedge CLK) begin
    if (!nRES) begin
        output_vectors[2] <= '0;
    end
    else begin
        if (start & finish) begin
            output_vectors[2] <= '0;
        end
        else if (spikes[2]) begin
            output_vectors[2] <= cnt;
        end
    end
end
always @(posedge CLK) begin
    if (!nRES) begin
        output_vectors[3] <= '0;
    end
    else begin
        if (start & finish) begin
            output_vectors[3] <= '0;
        end
        else if (spikes[3]) begin
            output_vectors[3] <= cnt;
        end
    end
end

always @(posedge CLK) $display("Time %0t cnt %d", ($time-1)/2, cnt);

endmodule