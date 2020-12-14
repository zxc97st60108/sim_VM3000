module sysctrl(
           input wire pdm_clk,
           output wire LED_clk,
           output reg [2:0] pidx	//memory_idx
       );
parameter Idle  =  0;
parameter Shift =  1;
// `include "Param.v"

reg CS, NS;
reg cnt_en;

//? current state register
always@(posedge pdm_clk ) begin

    CS<=NS;
end

//? next state logic          change mode
always@(*) begin
    case(CS)
        Idle: begin
            if(pdm_clk)
                NS=Shift;
            else
                NS=Idle;
        end
        Shift: begin
            NS=Shift;
        end
        default: begin
            NS=Idle;
        end
    endcase
end


//output logic
always@(*) begin
    case(CS)
        Idle: begin
            // RW = 1'b0;
            cnt_en = 1'b0;
            // bsy = 1'b0;
            // pidx = 3'd0;
        end
        Shift://enable pidx
        begin
            // RW =  1'b1 ;  //小於46875
            cnt_en = 1'b1;
            // bsy = 1'b1;
            // pidx = 6'd0;
        end
        default: begin
            // RW = 1'b0;
            cnt_en = 1'b0;
            // bsy = 1'b0;
        end
    endcase
end

//pidx   給pattern計數用的
always @(posedge pdm_clk ) begin
    if(CS == Idle) begin
        pidx <= 3'd0;
    end
    else if(pidx == 3'd7 )       //if pidx == 32 then reset 0     pidx[4]&pidx[3]&pidx[2]&pidx[1]&pidx[0] | ctrl[1]
    begin
        pidx <= 3'd0;
    end
    else if(cnt_en) begin
        pidx <= pidx + 1'b1;
    end
end


assign LED_clk = pdm_clk;

endmodule
