%% Clear
clear;
clc;

%% Initialization
% Basic Parameters
m = 0.02;
q = 0.016;
dt = 0.001;
T = 20;
E = [0, 0, 0];
B = [0, 0, 8];
% Particles
n = 16;
k = 0 : n - 1;
v = 0.1 * sin(k' * pi / 8) * [1, 0, 0] + 0.1 * cos(k' * pi / 8) * [0, 1, 0] + ones(n, 1) * [0, 0, 10];
r = zeros(n, 3);
% Recording
R = zeros(1, n * 3); % [x_0, x_1, ..., x_(n-1), y_0, ..., y_(n-1), z_0, ... , z_(n-1); ...]

%% Simulation
B_hat = [0, -B(3), B(2); B(3), 0, -B(1); -B(2), B(1), 0];
for i = 0 : dt : T
    F = q * (E - v * B_hat'); % F = q * (E + v x B)
    v = v + F / m * dt;
    r = r + v * dt;
    R = [R; reshape(r, 1, n * 3)];
end

%% Plotting
figure(1);
hold on, grid on;
plot3(R(:, 1 : n), R(:, n + 1 : n * 2), R(:, n * 2 + 1 : n * 3));
title(["Particle Motion Trajectories (dt = " + dt + "s, T = " + T + "s)", "(Wang Zhuoyang, 12112907)"]);
xlabel("x (m)"), ylabel("y (m)"), zlabel("z (m)");
