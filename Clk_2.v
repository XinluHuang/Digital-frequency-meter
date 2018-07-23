module Clk_2(clk_50m,clk_2);
input clk_50m;
output reg clk_2;
integer cnt;//定义计数器寄存器

//计数器计数进程
always@(posedge clk_50m)
if(cnt == 49999999)begin
cnt<=0;clk_2=~clk_2;
end
else
cnt<=cnt+1;

endmodule 