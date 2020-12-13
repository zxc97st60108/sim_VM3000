
module vm3000(
           input wire inter_clk,
           input wire PDMclk,
           input wire SW,
           output wire LED_clk,
           output wire LED_pdm,
           output wire pdm_signal
       );

wire [2:0]  pidx;		//pattern addr



//TODO: control module
sysctrl ctrl_m(
            .inter_clk(inter_clk),
            .pdm_clk(PDMclk),
            .LED_clk(LED_clk),
            .pidx(pidx)
        );



prom prom_m(
         .inter_clk(inter_clk),
         .clk(PDMclk),
         .pidx(pidx),
         .SW(SW),
         .LED_pdm(LED_pdm),
         .out_pattern(pdm_signal)
     );

endmodule
