%% Definitions
% Charges
Q_1 = Charge(1e-9, Point([-0.01, 0]));
Q_2 = Charge(1e-9, Point([0.01, 0]));
% Viewport
range_size = 0.1;
range_samples = 80;
x_range = linspace(-range_size / 2, range_size / 2, range_samples);
y_range = linspace(-range_size / 2, range_size / 2, range_samples);
[x_mesh, y_mesh] = meshgrid(x_range, y_range);

%% Potential Distribution
V = Q_1.EvalPotentialField(x_mesh, y_mesh) + Q_2.EvalPotentialField(x_mesh, y_mesh);

figure(1);
mesh(x_mesh, y_mesh, V);
title("Two Identical Point Charges - Potential Distribution (王卓扬, 12112907)");
xlabel("x (m)"), ylabel("y (m)"), zlabel("V (V)");

%% Contours Distribution
V_min = 320;
V_max = 3000;
V_samples = 20;
V_eq = linspace(V_min, V_max, V_samples);

figure(2);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
title("Two Identical Point Charges - Contours Distribution (王卓扬, 12112907)");
xlabel("x (m)"), ylabel("y (m)");

%% Equipotential Lines and Streamlines Distributions (Smooth Continuous Curves)
[E_x, E_y] = gradient(-V);

angle_samples = 4 * (2) + 4 + 1;
angle_dist = 0.0001;
angle = linspace(0, 2 * pi, angle_samples);
angle_x_s = angle_dist * cos(angle);
angle_y_s = angle_dist * sin(angle);

figure(3);
hold on;
grid on;
axis equal;
contour(x_mesh, y_mesh, V, V_eq);
streamline(x_mesh, y_mesh, E_x, E_y, angle_x_s + Q_1.p.x, angle_y_s + Q_1.p.y);
streamline(x_mesh, y_mesh, E_x, E_y, angle_x_s + Q_2.p.x, angle_y_s + Q_2.p.y);
title(["Two Identical Point Charges - Equipotential Lines and Streamlines Distributions", "(Smooth Continuous Curves) (王卓扬, 12112907)"]);
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
axis([-0.02, 0.02, -0.02, 0.02]);
title(["Two Identical Point Charges - Equipotential Lines and Streamlines Distributions", "(Normalized Arrowheads) (王卓扬, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)");
