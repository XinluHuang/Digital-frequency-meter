module counter(clk,cin,cout,num,Rst_n);//m15
input clk;//时钟
input cin;//待测量信号
input Rst_n;//复位键
output reg cout=0;//进位
output reg [3:0] num=0;//输出要显示数字,BCD码

always@(posedge cin or posedge clk or negedge Rst_n)
if(!Rst_n) num=0;
else if(clk) num=0;//一个周期内，有半个周期clk==0,故用0.5hz,周期2s,半周期1s
else if(cin)begin
if(num==9) begin num<=0;cout<=1;end
else begin num<=num+1;cout<=0;end
end

endmodule 