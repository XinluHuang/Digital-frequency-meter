module Clk_500(clk_50m,clk_500);
input clk_50m;
output reg clk_500;
integer cnt=0;

always@(posedge clk_50m)
if(cnt == 49_999)begin
cnt<=0;
clk_500<=~clk_500;
end
else
cnt <= cnt +1;

endmodule 