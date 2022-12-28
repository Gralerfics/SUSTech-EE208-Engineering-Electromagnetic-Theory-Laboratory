clear all                   
m=0.02;                                      %给定电荷质量；
q=1.6e-2;                                     %给定电荷电量；
dt=0.001;                                     %设定时间步长为0.001s；
t=0:dt:100;                                    %建立时间的数组；
vx=linspace(0,0,length(t));vy=vx;vz=vx;            %建立速度矢量；
vx(1)=5;                                      %给定速度矢量初始值
rx=linspace(0,0,length(t));ry=rx;rz=rx;              %给定位置矢量；
Ex=0; Ey=1; Ez=0;                             %给定电场强度矢量；
Bx=0; By=1; Bz=0;                             %给定磁通密度矢量；
Fx=linspace(0,0,length(t));Fy=Fx;Fz=Fx;            %建立力矢量；
ax=linspace(0,0,length(t));ay=ax;az=ax;             %建立加速度矢量；
for i=1:(length(t)-1)                             %计算出每一个位置点
  Fx(i)=q*Ex+q*(vy(i)*Bz-vz(i)*By);              %计算i点空间受力
 Fy(i)=q*Ey+q*(vz(i)*Bx-vx(i)*Bz);              %计算i点空间受力
 Fz(i)=q*Ez+q*(vx(i)*By-vy(i)*Bx);              %计算i点空间受力
 ax(i)=Fx(i)/m;                                %计算i点加速度
 ay(i)=Fy(i)/m;                                %计算i点加速度
 az(i)=Fz(i)/m;                                %计算i点加速度
 vx(i+1)=vx(i)+ax(i)*dt;                         %计算i+1点速度
 vy(i+1)=vy(i)+ay(i)*dt;                         %计算i+1点速度
 vz(i+1)=vz(i)+az(i)*dt;                          %计算i+1点速度
 rx(i+1)=rx(i)+vx(i)*dt;                          %计算i+1点位置
 ry(i+1)=ry(i)+vy(i)*dt;                          %计算i+1点位置
 rz(i+1)=rz(i)+vz(i)*dt;                          %计算i+1点位置
end

figure
plot3(rx,ry,rz);                                  %绘图
hold on
grid;
title('带电粒子在电磁场中的运动轨迹');            % 给出图形标题
xlabel('X轴', 'fontsize', 12);                       % X轴标注
ylabel('Y轴', 'fontsize', 12);                       % Y轴标注
zlabel('Z轴', 'fontsize', 12);                        % Z轴标注
