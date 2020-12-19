module vm3000(
           input wire PDMclk,
           //input wire SW,
		   //input wire rst,
           output wire LED_clk,
           output wire LED_pdm,
           output wire pdm_signal
       );

//wire [2:0]  pidx;		//pattern addr

//TODO: control module

sysctrl ctrl_m(
            .pdm_clk(PDMclk),
            .LED_clk(LED_clk)
            //.pidx(pidx),
			//.rst(rst)
        );

prom prom_m(
         .clk(PDMclk),
         //.pidx(pidx),
         //.SW(SW),
         //.rst(rst),
         .LED_pdm(LED_pdm),
         .out_pattern(pdm_signal)
     );

endmodule
