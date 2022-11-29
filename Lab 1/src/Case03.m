%% Definitions
% Charges
Q_1 = Charge(8e-9, Point([-sqrt(3), -1]));
Q_2 = Charge(8e-9, Point([sqrt(3), -1]));
Q_3 = Charge(8e-9, Point([0, 2]));
% Viewport
range_size = 8;
range_samples = 80;
x_range = linspace(-range_size / 2, range_size / 2, range_samples);
y_range = linspace(-range_size / 2, range_size / 2, range_samples);
[x_mesh, y_mesh] = meshgrid(x_range, y_range);

%% Potential Distribution
V = Q_1.EvalPotentialField(x_mesh, y_mesh) + Q_2.EvalPotentialField(x_mesh, y_mesh) + Q_3.EvalPotentialField(x_mesh, y_mesh);

figure(1);
mesh(x_mesh, y_mesh, V);
zlim([0, 600]);
title("Three Identical Point Charges - Potential Distribution (王卓扬, 12112907)");
xlabel("x (m)"), ylabel("y (m)"), zlabel("V (V)");

%% Contours Distribution
V_min = 0;
V_max = 6.5;
V_samples = 21;
V_eq = linspace(V_min, V_max, V_samples) .^ 3;

figure(2);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
title("Three Identical Point Charges - Contours Distribution (王卓扬, 12112907)");
xlabel("x (m)"), ylabel("y (m)");

%% Equipotential Lines and Streamlines Distributions (Smooth Continuous Curves)
[E_x, E_y] = gradient(-V);

angle_samples = 4 * (1) + 4 + 1;
angle_dist = 0.1;
angle = linspace(-pi / 8, pi + pi / 8, angle_samples);
angle_u = [angle, -pi / 3.45, -pi + pi / 3.45];
angle = [angle, -pi / 2.7, -pi + pi / 2.7];

figure(3);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
streamline(x_mesh, y_mesh, E_x, E_y, angle_dist * cos(angle + pi / 3 * 2) + Q_1.p.x, angle_dist * sin(angle + pi / 3 * 2) + Q_1.p.y);
streamline(x_mesh, y_mesh, E_x, E_y, angle_dist * cos(angle - pi / 3 * 2) + Q_2.p.x, angle_dist * sin(angle - pi / 3 * 2) + Q_2.p.y);
streamline(x_mesh, y_mesh, E_x, E_y, angle_dist * cos(angle_u) + Q_3.p.x, angle_dist * sin(angle_u) + Q_3.p.y);
title(["Three Identical Point Charges - Equipotential Lines and Streamlines Distributions", "(Smooth Continuous Curves) (王卓扬, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)");

%% Equipotential Lines and Streamlines Distributions (Normalized Arrowheads)
E = sqrt(E_x .^ 2 + E_y .^ 2);
E_x_normal = E_x ./ E;
E_y_normal = E_y ./ E;

figure(4);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
quiver(x_mesh, y_mesh, E_x_normal, E_y_normal);
axis([-2.5, 2.5, -2, 3]);
title(["Three Identical Point Charges - Equipotential Lines and Streamlines Distributions", "(Normalized Arrowheads) (王卓扬, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)");
