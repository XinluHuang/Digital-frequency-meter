module Clk_2k(clk_50m,clk_2k);
input clk_50m;
output reg clk_2k;
integer cnt=0;

always@(posedge clk_50m)
if(cnt == 49999)begin
cnt<=15'd0;
clk_2k<=~clk_2k;
end
else
cnt <= cnt +1;

endmodule 