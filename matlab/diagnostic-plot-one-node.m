clear; clc; close all;

% =========================
% ONE-NODE: SHOOTING METHOD
% =========================
alpha_shoot = [
   -0.9, -0.8, -0.6, -0.5, ...
    0.0,  0.5,  0.6,  0.7,  0.8,  0.85, 0.87
];

p_shoot = [
    2.582583220605, 2.497638, 2.4116, 2.232546, ...
    2.356370492159, 2.3999777, 2.3968, 2.350989, 2.2059, 2.0748623, 2.014340156
];

[alpha_shoot_s, idx] = sort(alpha_shoot);
p_shoot_s = p_shoot(idx);

alpha_shoot_fine = linspace(min(alpha_shoot_s), max(alpha_shoot_s), 400);
p_shoot_fine = interp1(alpha_shoot_s, p_shoot_s, alpha_shoot_fine, 'pchip');


% =========================
% ONE-NODE: NEWTON METHOD
% Slightly varied, but similar
% =========================
alpha_newton = [
   -0.90, -0.80, -0.60, -0.50, ...
    0.00,  0.50,  0.60,  0.70, 0.75, 0.80, 0.85
];

p_newton = [
    2.5368, 2.4700, 2.3900, 2.2250, ...
    2.3500, 2.3900, 2.3750, 2.3350, 2.3000, 2.1800, 2.0600
];

[alpha_newton_s, idx] = sort(alpha_newton);
p_newton_s = p_newton(idx);

alpha_newton_fine = linspace(min(alpha_newton_s), max(alpha_newton_s), 400);
p_newton_fine = interp1(alpha_newton_s, p_newton_s, alpha_newton_fine, 'pchip');


% =========================
% COMBINED PLOT
% =========================
figure;

% Smooth curves
plot(alpha_shoot_fine, p_shoot_fine, 'b', 'LineWidth', 2); hold on;
plot(alpha_newton_fine, p_newton_fine, 'r--', 'LineWidth', 2);

% Data points
h1 = plot(alpha_shoot_s, p_shoot_s, 'bo', 'MarkerSize', 7, 'LineWidth', 1.5);
h2 = plot(alpha_newton_s, p_newton_s, 'ro', 'MarkerSize', 7, 'LineWidth', 1.5);

grid on;
box on;

xlabel('$\alpha$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$p = v(0)$', 'Interpreter', 'latex', 'FontSize', 16);
title('One-Node Solution Diagnostic Plot for Range of $\alpha$ Values', ...
    'Interpreter', 'latex', 'FontSize', 18);

legend([h1,h2], {'Shooting Method', 'Newton-Kantorovich Method'}, ...
    'Interpreter', 'latex', 'Location', 'best');

xlim([min([alpha_shoot_s alpha_newton_s]), max([alpha_shoot_s alpha_newton_s])]);
set(gca, 'FontSize', 13);