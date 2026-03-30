clear; clc; close all;

% =========================
% SHOOTING METHOD DATA
% =========================
alpha_shoot = [
    0.89, ...
   -5.0, -5.5, -13, -35.5, -130.5, -300.5, -1110.5, -6715.5, -11715.5, -20715.5
];

p_shoot = [
    1.939729205905, ...
    1.016909713073, 0.99155210, 0.801999553306, 0.602, ...
    0.402095, 0.307428, 0.200356642648, 0.1103919, 0.096, 0.078001
];

[alpha_shoot_s, idx] = sort(alpha_shoot);
p_shoot_s = p_shoot(idx);

mask = alpha_shoot_s >= -50;
alpha_shoot_f = alpha_shoot_s(mask);
p_shoot_f = p_shoot_s(mask);

alpha_shoot_fine = linspace(min(alpha_shoot_f), max(alpha_shoot_f), 400);
p_shoot_fine = interp1(alpha_shoot_f, p_shoot_f, alpha_shoot_fine, 'pchip');


% =========================
% NEWTON METHOD DATA
% =========================
alpha_newton = [
    0.87, ...
   -5.0, -5.5, -13, -35.0, -130.5, -300.5, -1110.5, -6715.5, -11715.5, -20715.5
];

p_newton = [
    1.97579, ...
    1.016909713073, 0.99155210, 0.801999553306, 0.603827, ...
    0.402095, 0.307428, 0.200356642648, 0.1103919, 0.096, 0.078001
];

[alpha_newton_s, idx] = sort(alpha_newton);
p_newton_s = p_newton(idx);

mask = alpha_newton_s >= -50;
alpha_newton_f = alpha_newton_s(mask);
p_newton_f = p_newton_s(mask);

alpha_newton_fine = linspace(min(alpha_newton_f), max(alpha_newton_f), 400);
p_newton_fine = interp1(alpha_newton_f, p_newton_f, alpha_newton_fine, 'pchip');


% =========================
% COMBINED PLOT
% =========================
figure;

% Smooth curves (no legend)
plot(alpha_shoot_fine, p_shoot_fine, 'b', 'LineWidth', 2); hold on;
plot(alpha_newton_fine, p_newton_fine, 'r--', 'LineWidth', 2);

% Data points (legend entries)
h1 = plot(alpha_shoot_f, p_shoot_f, 'bo', 'MarkerSize', 7, 'LineWidth', 1.5);
h2 = plot(alpha_newton_f, p_newton_f, 'ro', 'MarkerSize', 7, 'LineWidth', 1.5);

grid on;
box on;

xlabel('$\alpha$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$p = v(0)$', 'Interpreter', 'latex', 'FontSize', 16);

title('Monotonic Solution Diagnostic Plot for Range of $\alpha$ Values', ...
    'Interpreter', 'latex', 'FontSize', 18);

legend([h1, h2], {'Shooting Method', 'Newton-Kantorovich Method'}, ...
    'Interpreter', 'latex', 'Location', 'best');

xlim([min(alpha_shoot_f), max(alpha_shoot_f)]);
set(gca, 'FontSize', 13);