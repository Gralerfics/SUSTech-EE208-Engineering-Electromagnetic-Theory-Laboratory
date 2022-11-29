%% Definitions
% Charges
Q_1 = Charge(5e-9, Point([-2, 0]));
Q_2 = Charge(-5e-9, Point([2, 0]));
% Viewport
range_size = 8;
range_samples = 50;
x_range = linspace(-range_size / 2, range_size / 2, range_samples);
y_range = linspace(-range_size / 2, range_size / 2, range_samples);
[x_mesh, y_mesh] = meshgrid(x_range, y_range);

%% Potential Distribution
V = Q_1.EvalPotentialField(x_mesh, y_mesh) + Q_2.EvalPotentialField(x_mesh, y_mesh);

figure(1);
mesh(x_mesh, y_mesh, V);
zlim([-250, 250]);
title("Two Opposite Point Charges - Potential Distribution (王卓扬, 12112907)");
xlabel("x (m)"), ylabel("y (m)"), zlabel("V (V)");

%% Contours Distribution
V_min = -4.8;
V_max = 4.8;
V_samples = 21;
V_eq = linspace(V_min, V_max, V_samples) .^ 3;
V_eq(intersect(find(abs(V_eq) > 0), find(abs(V_eq) < 1))) = [];

figure(2);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
title("Two Opposite Point Charges - Contours Distribution (王卓扬, 12112907)");
xlabel("x (m)"), ylabel("y (m)");

%% Equipotential Lines and Streamlines Distributions (Smooth Continuous Curves)
[E_x, E_y] = gradient(-V);

angle_samples = 2 * (2) + 3 + 1;
angle_dist = 0.01;
angle_half = linspace(-pi / 3.5, pi / 3.5, angle_samples + 2);
angle_half = angle_half([1, 3 : end - 2, end]);
angle_half_x_s = angle_dist * cos(angle_half);
angle_half_y_s = angle_dist * sin(angle_half);
angle_half_i = linspace(-pi / 2.1, pi / 2.1, angle_samples);
angle_half_x_s_i = angle_dist * cos(angle_half_i);
angle_half_y_s_i = angle_dist * sin(angle_half_i);

figure(3);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
streamline(x_mesh, y_mesh, E_x, E_y, -angle_half_x_s + Q_1.p.x, -angle_half_y_s + Q_1.p.y);
streamline(x_mesh, y_mesh, E_x, E_y, angle_half_x_s_i + Q_1.p.x, angle_half_y_s_i + Q_1.p.y);
streamline(x_mesh, y_mesh, -E_x, -E_y, angle_half_x_s + Q_2.p.x, angle_half_y_s + Q_2.p.y);
title(["Two Opposite Point Charges - Equipotential Lines and Streamlines Distributions", "(Smooth Continuous Curves) (王卓扬, 12112907)"]);
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
axis([-3, 3, -3, 3]);
title(["Two Opposite Point Charges - Equipotential Lines and Streamlines Distributions", "(Normalized Arrowheads) (王卓扬, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)");
