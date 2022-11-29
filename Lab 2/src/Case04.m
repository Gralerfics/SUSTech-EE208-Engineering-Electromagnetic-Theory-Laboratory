clear;
clc;

%% Definitions
% Parameters
rho = 1e-9; % [C/m]
segments = 100;
% Viewport
range_size_x = 4;
range_size_y = 3;
range_sampling_rate = 50;
range_vec_x = linspace(-range_size_x / 2, range_size_x / 2, range_size_x * range_sampling_rate);
range_vec_y = linspace(-range_size_y / 2, range_size_y / 2, range_size_y * range_sampling_rate);
[mesh_x, mesh_y] = meshgrid(range_vec_x, range_vec_y);

%% Potential Distribution
val_range = [1, 5 : 5 : 100];
val_rms = [];
i = 0;
for segments = val_range
    disp(segments);
    i = i + 1;
    V_diff = Constants.k .* rho .* ...
            log((1 - mesh_x + sqrt((1 - mesh_x) .* (1 - mesh_x) + mesh_y .* mesh_y)) ...
            ./ (-1 - mesh_x + sqrt((-1 - mesh_x) .* (-1 - mesh_x) + mesh_y .* mesh_y)));
    charges_len = 2 / segments;
    charges_q = rho * charges_len;
    for i = 0 : (segments - 1)
        V_diff = V_diff - Charge(charges_q, Point([-1 + charges_len / 2 + charges_len * i, 0])).EvalPotentialField(mesh_x, mesh_y);
    end
    val_rms = [val_rms, rms(V_diff(:))];
end

%% Plotting
figure(1);
grid on, axis equal;
plot(val_range, val_rms, '-x', 'lineWidth', 1.0);
xlim([0, 100]);
title(["Difference - RMS Curve (Wang Zhuoyang, 12112907)"]);
xlabel("Segments"), ylabel("RMS (V)");
saveas(1, "../fig/rms.png");
