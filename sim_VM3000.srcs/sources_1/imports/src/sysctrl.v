module sysctrl(
		   input wire rst,
           input wire pdm_clk,
           output wire LED_clk,
           output reg [2:0] pidx	//memory_idx
       );


//pidx   給pattern計數用的
always @(posedge pdm_clk or posedge rst) begin
	if(rst) pidx <= 1'b0;
	else if(pidx < 3'd7)
	pidx <= pidx + 1'b1;
	else if(pidx == 3'd7)
	pidx <= 3'd0;
end
	 
assign LED_clk = pdm_clk;

endmodule
