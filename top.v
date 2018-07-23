module top(clk,Rst_n,dig,sel,led);
input clk;	//50m晶振
output reg led; //led灯
input Rst_n;	//复位键
output reg [7:0] dig;	//数码管abcdefgh
output reg [5:0] sel;	//6位数码管位选
reg [23:0]data;//要显示的数
reg kilo;	//低位量程溢出,

initial begin
sel=6'b111110;
led=0;
kilo=0;
end


//由50m晶振分频而来的各种时钟
wire clk_1k;
Clk_1k(.clk_50m(clk),.clk_1k(clk_1k));
wire clk_2;
Clk_2(.clk_50m(clk),.clk_2(clk_2));
wire clk_2k;
Clk_2k(.clk_50m(clk),.clk_2k(clk_2k));
wire clk_t;
Clk_test(.clk_50m(clk),.clk_t(clk_t));

//reg<=wire需要定时更新

wire out;//溢出判断
wire out2,out3;//暂时没用
wire [23:0] data1;	
wire [23:0] data2;
wire [23:0] data3;
counter_fre(.clk_2(clk_2),.cin(clk_t),.cout(out),.data(data1),.Rst_n(Rst_n));//测频低量程 10~999kHz
counter_fre(.clk_2(clk_2k),.cin(clk_t),.cout(out2),.data(data2),.Rst_n(Rst_n));//测频高量程 1MHz~99MHz
counter_per(.clk_1k(clk_1k),.cin(clk_t),.cout(out3),.data(data3),.Rst_n(Rst_n));//测周期 <10Hz

//低量程溢出,状态改变,亮灯表示
always@(posedge out)begin
kilo=1;
led=1;
end


always@(posedge clk)begin
if(!kilo)begin
if(data<10) data<=data3;
else data<=data1;
end
else data<=data2;//高量程
end


//6位共阳极数码管LG3661BH,低电平有效,0为要显示的管
reg [3:0] num=0;
always@(posedge clk_1k or negedge Rst_n)
if(!Rst_n)begin
sel<=6'b111111;//复位按下,全都不亮
end
else begin
case(sel)
6'b011111:begin
sel<=6'b111110;num<=data[3:0];
end
6'b111110:begin
sel<=6'b111101;num<=data[7:4];
end
6'b111101:begin
sel<=6'b111011;num<=data[11:8];
end
6'b111011:begin
sel<=6'b110111;num<=data[15:12];
end
6'b110111:begin
sel<=6'b101111;num<=data[19:16];
end
6'b101111:begin
sel<=6'b011111;num<=data[23:20];
end
default:begin
sel<=6'b111110;num<=data[3:0];
end
endcase
end



//数码管显示
always@(posedge clk)
case(num)
4'h0:dig=8'b11000000;
4'h1:dig=8'b11111001;
4'h2:dig=8'b10100100;
4'h3:dig=8'b10110000;
4'h4:dig=8'b10011001;
4'h5:dig=8'b10010010;
4'h6:dig=8'b10000010;
4'h7:dig=8'b11111000;
4'h8:dig=8'b10000000;
4'h9:dig=8'b10010000;
default:dig=8'b11111111;
endcase

endmodule 