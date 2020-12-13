

`include "pdm.v"
`include "sysctrl.v"
`include "prom.v"
module tb;

reg clk;
reg pdmclk;
wire pdm_signal;
reg rst;
reg [4:0] counter;
wire led0;
wire led1;

vm3000 pdm(
           .inter_clk(clk),
           .PDMclk(pdmclk),
           .LED_clk(led0),
           .LED_pdm(led1),
           //    .rst(),
           .pdm_signal(pdm_signal)
       );

initial begin
    pdmclk = 0;
    forever begin
        #333
         pdmclk = 1;
        $display("pdm_signal = %b , led0 = %b , led1 = %b \n ", pdm_signal , led0 , led1);
        #333
         pdmclk = 0;
        $display("pdm_signal = %b , led0 = %b , led1 = %b \n ", pdm_signal , led0 , led1);
    end
end

initial begin
    clk = 0;
    forever begin
        #5
         clk = 1;
        #5
         clk = 0;
    end
end

initial begin
    #20
     rst = 1;
    #10
     rst = 0;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end

always @(posedge pdmclk or posedge rst) begin
    if(rst)
        counter = 5'b0;
    else if(counter < 5'b01111)
        counter  = counter + 1'b1;
    else if (counter == 5'b01111)
        $finish();

end



endmodule
