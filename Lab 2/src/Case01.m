clear;
clc;

%% Definitions
% Parameters
rho = 1e-9; % [C/m]
% Viewport
range_size_x = 4;
range_size_y = 3;
range_sampling_rate = 50;
range_vec_x = linspace(-range_size_x / 2, range_size_x / 2, range_size_x * range_sampling_rate);
range_vec_y = linspace(-range_size_y / 2, range_size_y / 2, range_size_y * range_sampling_rate);
[mesh_x, mesh_y] = meshgrid(range_vec_x, range_vec_y);

%% Potential Distribution
V = Constants.k .* rho .* ...
        log((1 - mesh_x + sqrt((1 - mesh_x) .* (1 - mesh_x) + mesh_y .* mesh_y)) ...
        ./ (-1 - mesh_x + sqrt((-1 - mesh_x) .* (-1 - mesh_x) + mesh_y .* mesh_y)));

figure(1);
grid on, axis equal;
mesh(mesh_x, mesh_y, V);
axis([-range_size_x / 2, range_size_x / 2, -range_size_y / 2, range_size_y / 2, 0, 100]);
title(["Integration Method - Potential Distribution", "(Wang Zhuoyang, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)"), zlabel("V (V)");
saveas(1, "../fig/int_1.png");

%% Contours Distribution
V_eq_min = 0;
V_eq_max = 70;
V_eq_sampling_num = 18;
V_eq = linspace(V_eq_min, V_eq_max, V_eq_sampling_num);

figure(2);
hold on, grid on, axis equal;
contour(mesh_x, mesh_y, V, V_eq);
title(["Integration Method - Contours Distribution", "(Wang Zhuoyang, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)");
saveas(2, "../fig/int_2.png");

%% Equipotential Lines and Streamlines Distributions
[E_x, E_y] = gradient(-V);
angles = linspace(-pi / 2, pi / 2, 3);
sp_dist = 0.05;
sp_x = [-1 - sp_dist .* cos(angles), linspace(-1, 1, 10), linspace(-1, 1, 10), 1 + sp_dist .* cos(angles)];
sp_y = [sp_dist * sin(angles), sp_dist * ones(1, 10), -sp_dist * ones(1, 10), -sp_dist * sin(angles)];

figure(3);
hold on, grid on, axis equal;
contourf(mesh_x, mesh_y, V, V_eq);
fig_sl = streamline(mesh_x, mesh_y, E_x, E_y, sp_x, sp_y);
set(fig_sl, "lineWidth", 1.0, "color", [0.1, 0.8, 0.8]);
title(["Integration Method - Equipotential Lines and Streamlines Distributions", "(Wang Zhuoyang, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)");
saveas(3, "../fig/int_3.png");
