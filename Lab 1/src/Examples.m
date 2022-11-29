clear;                                                % 清空内存中的所有变量
clc;                                                  % 清空命令窗口中的内容
k=9e9;                                               % 设置静电力衡量
Q=1e-9;                                              % 设置点电荷的电量
xm=0.05;                                             % 设置场域中x方向的范围
ym=0.05;                                             % 设置场域中y方向的范围
x=linspace(-xm,xm,20);                                  % 将x轴等分成20等份
y=linspace(-ym,ym,20);                                  % 将y轴等分成20等份
[X,Y]=meshgrid(x,y);                                    % 形成场域中各点的坐标
R=sqrt(X.^2+Y.^2);                                     % 计算场域中各点到点电荷的距离（到坐标原点的距离）
V=k*Q./R;                                            % 计算场域中各点的电位
mesh(X,Y,V);                                           % 绘制出电位的分布图
figure(1);
hold on;
title('真空中单个点电荷电场的电位分布图','fontsize',20);    % 绘出图形标题(注意符号均应为半角英文字符)
xlabel('X轴(单位: m)','fontsize',20);                       % 绘出X轴标注(注意符号均应为半角英文字符)
ylabel('Y轴(单位: m)','fontsize',20);                       % 绘出Y轴标注(注意符号均应为半角英文字符)

Vmin=200;                                          % 设定等位线族的最小电位值
Vmax=2000;                                         % 设定等位线族的最大电位值
Veq=linspace(Vmin,Vmax,10);                           % 设定10条等位线的电位值
figure(2);
contour(X,Y,V,Veq);                                    % 绘制10条等势线
grid on                                             % 形成网格
hold on                                             % 保持图形
plot(0,0,'o', 'MarkerSize',12)                            % 在原点处画出点电荷
title('真空中单个点电荷电场的等电位线', 'fontsize', 20);    % 给出图形标题
xlabel('X轴(单位: m)', 'fontsize', 20);                     % 给出X轴标注
ylabel('Y轴(单位: m)', 'fontsize', 20);                     % 给出Y轴标注

[Ex,Ey]=gradient(-V);                                 % 计算场域各点的电场强度的两个分量
del_theta=20;                                      % 设置相邻电力线间的角度差；
theta=(0:del_theta:360).*pi/180;                       % 生成电力线的弧度值；
xs=0.004*cos(theta);                                 % 生成电力线起点的x轴坐标；
ys=0.004*sin(theta);                                 % 生成电力线起点的y轴坐标；
streamline(X,Y,Ex,Ey,xs,ys)                             % 生成电力线；
figure(3);
grid on                                            % 形成网格
hold on                                            % 保持图形
contour(X,Y,V,Veq);                                   % 绘制10条等势线
plot(0,0,'o', 'MarkerSize',12)                           % 在原点处画出点电荷
title('真空中单个点电荷电场的等电位线和电力线（用光滑连续曲线表示）', 'fontsize', 12);                                               % 给出图形标题
xlabel('X轴(单位: m)', 'fontsize', 12);                    % 给出X轴标注
ylabel('Y轴(单位: m)', 'fontsize', 12);                    % 给出Y轴标注

E=sqrt(Ex.^2+Ey.^2);                        % 计算场域各点的电场强度的幅值
Ex=Ex./E;                                
Ey=Ey./E;                              % 归一化电场强度值（即使各点场强幅值为1）
figure(4);
quiver(X,Y,Ex,Ey);                           % 用归一化箭头表示场域各点电场强度的方向
hold on;
contour(X,Y,V,Veq);                          % 绘制等势线
title('真空中单个点电荷电场的等电位线和电力线（用归一化箭头表示）', 'fontsize', 12);                                       
      % 给出图形标题
xlabel('X轴(单位: m)', 'fontsize', 12);           % 给出X轴标注
ylabel('Y轴(单位: m)', 'fontsize', 12);           % 给出Y轴标注
