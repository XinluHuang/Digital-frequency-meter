module Clk_1(clk_50m,clk_1);
input clk_50m;
output reg clk_1;
integer cnt;
always@(posedge clk_50m)
if(cnt == 24_999_999)
begin cnt<=0;clk_1=~clk_1;end
else cnt<=cnt+1;
endmodule 