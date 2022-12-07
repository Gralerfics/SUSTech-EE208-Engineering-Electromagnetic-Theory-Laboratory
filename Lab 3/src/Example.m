clear all
a=1; %输入电流环半径值
I=100; %输入电流环中电流值
C=I/(4*pi); %归并常数
N=50; %设定电流环分段数
ym=3; % 设置场域中 y 方向的范围
zm=3; % 设置场域中 z 方向的范围
y=linspace(-ym,ym,20); % 将 y 轴等分成 20 等份
z=linspace(-zm,zm,20); % 将 z 轴等分成 20 等份
theta0=linspace(0,2*pi,N+1); %环的圆周角分段 
theta1=theta0(1:N); 
x1=a*cos(theta1); y1=a*sin(theta1); %环各段矢量的起始坐标 y1,z1
theta2=theta0(2:N+1); 
x2=a*cos(theta2); y2=a*sin(theta2); %环各段矢量的终点坐标 y2,z2
zc=0; xc=(x2+x1)./2; yc=(y2+y1)./2; %计算环各段矢量中点的三个坐标分量
dlz=0;dlx=x2-x1;dly=y2-y1; %计算环各段矢量 dl 的三个长度分量
 NGx=20; NGy=20; %网格线数
 Hy=zeros(20);Hz=zeros(20);H=zeros(20); %建立 H 的矩阵
for i=1:NGy %循环计算各网点上的 H（x,y）值
 for j=1:NGx
 rx=0-xc; ry=y(j)-yc; rz=z(i)-zc; %计算径矢 r 的 3 个长度分量，r 在 z=0 的面上
 r3=sqrt(rx.^2+ry.^2+rz.^2).^3; %计算 r 的 3 次方
 dlXr_y=dlz.*rx-dlx.*rz; %计算叉乘 dl×r 的 y 和 z 分量，x 分量为 0
 dlXr_z=dlx.*ry-dly.*rx;
 Hy(i,j)=sum(C.*dlXr_y./r3); %把环各段产生的磁场强度分量累加
 Hz(i,j)=sum(C.*dlXr_z./r3);
 H=(Hy.^2+Hz.^2).^0.5; %计算 H 的大小
end
end
subplot(1,3,1), quiver(y,z,Hy,Hz); %画磁场强度矢量图
hold on 
axis([-3,3,-3,3]); 
plot(1,0,'ro',-1,0,'bo'), %标准线圈剖面
xlabel('y'),ylabel('z'), %修饰图形，标注坐标轴
subplot(1,3,2), mesh(y,z,H); %画磁场强度图
axis([-3,3,-3,3,0,100]) 
xlabel('y'),ylabel('z'),zlabel('H');
theta=[0 50 60 70 80 90 100 110 120 130 180].*pi/180; %设置电力线的弧度值
ys=1.1*cos(theta); %设置电力线起始圆 y 坐标
zs=1.1*sin(theta); %设置电力线起始圆 z 坐标
subplot(1,3,3), streamline(y,z,Hy,Hz,ys,zs); %从起始圆处向外绘制磁力线
streamline(y,z,-Hy,-Hz,ys,zs); %从起始圆处向内绘制磁力线
xlabel('y'),ylabel('z');
