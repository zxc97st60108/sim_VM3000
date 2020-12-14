module prom(

           input wire inter_clk,
           input wire clk,
           input wire [2:0] pidx,
           input wire SW,
           output wire LED_pdm,
           output reg out_pattern
       );
// parameter pattern = 8'b0101_1010; //1
reg [7:0] pattern;

always @(posedge inter_clk) begin
    pattern <= SW ? 8'b0101_1010 : 8'b1111_1111;
end

always @(posedge clk) begin
    case (pidx)
        3'b000:
            out_pattern <= pattern[0];
        3'b001:
            out_pattern <= pattern[1];
        3'b010:
            out_pattern <= pattern[2];
        3'b011:
            out_pattern <= pattern[3];
        3'b100:
            out_pattern <= pattern[4];
        3'b101:
            out_pattern <= pattern[5];
        3'b110:
            out_pattern <= pattern[6];
        3'b111:
            out_pattern <= pattern[7];
    endcase
end

assign LED_pdm = out_pattern;

endmodule

