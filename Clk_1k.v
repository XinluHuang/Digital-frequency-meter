module Clk_1k(clk_50m,clk_1k);
input clk_50m;
output reg clk_1k;
integer cnt=0;

always@(posedge clk_50m)
if(cnt == 24999)begin
cnt<=0;
clk_1k<=~clk_1k;
end
else
cnt <= cnt +1;

endmodule 