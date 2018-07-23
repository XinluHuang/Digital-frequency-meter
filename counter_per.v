module counter_per(clk_1k,cin,cout,data,Rst_n);
input clk_1k;//测量在信号半个周期内，时钟计数的大小，以此反推频率
input cin;
input Rst_n;
output cout;
output reg [23:0] data;
integer cnt;
integer num;
reg [3:0] a;
parameter n=25000;

initial cnt=0;

always@(posedge clk_1k or posedge cin or negedge Rst_n)begin
if(!Rst_n) cnt=0;

else if(cin)begin
cnt=n/cnt;a=cnt%10;cnt=cnt/10;data[3:0]=a;
a=cnt%10;cnt=cnt/10;data[7:4]=a;
a=cnt%10;cnt=cnt/10;data[11:8]=a;
a=cnt%10;cnt=cnt/10;data[15:12]=a;
a=cnt%10;cnt=cnt/10;data[19:16]=a;
a=cnt%10;cnt=cnt/10;data[23:20]=a;
cnt<=0;
end

else cnt<=cnt+1;
end

endmodule 