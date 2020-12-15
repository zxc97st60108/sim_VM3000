`include "pdm.v"
`include "sysctrl.v"
`include "prom.v"

module tb;

reg pdmclk;
reg SW;
wire pdm_signal;
reg rst;
wire led0;
wire led1;

vm3000 pdm(
           .PDMclk(pdmclk),
		   .SW(SW),
           .LED_clk(led0),
           .LED_pdm(led1),
           .rst(rst),
           .pdm_signal(pdm_signal)
       );

initial begin
    pdmclk = 0;
	rst = 0;
	SW = 1;
    forever begin
        #333
         pdmclk = 1;
        $display("pdm_signal = %b , led0 = %b , led1 = %b , rst = %b\n", pdm_signal , led0 , led1 , rst);
        #333
         pdmclk = 0;
        $display("pdm_signal = %b , led0 = %b , led1 = %b , rst = %b\n", pdm_signal , led0 , led1 , rst);
    end
end

initial begin
	#10000 rst = 1;
	#10100 rst = 0;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
	#1000000 $finish;
end

endmodule
