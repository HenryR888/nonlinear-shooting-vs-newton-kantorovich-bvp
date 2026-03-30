
% We Implement the Shooting Method, using the bisection method to update
% our shooting parameter. 

clear; clc; close all;

% params: 
L = 20; % we use a finite large approximation for our right Boundary Condition
eps = 1e-6; % since we have a singularity at r=0, we initialise at 1x10^-6
tol = 1e-8; % tolerance for updating shooting param with bisection
maxIter = 100; % maximum number of iterations
alpha = 0.0; % define alpha

% define our first order system of ODEs: 
function dYdr = ode(r, Y, alpha)
    v  = Y(1); 
    w = Y(2);

    dYdr = zeros(2,1);
    dYdr(1) = w;
    dYdr(2) = -(1/r)*w + v - 2*v^3 + alpha*v^4;
end

% solve ODE and compute the value of v at  endpoint: 
function v = param_error(p, L, eps, alpha)
    [~, Y] = ode45(@(r,Y) ode(r, Y, alpha), [eps L], [p; 0]);
    v = Y(end,1); 
end

% left and right values for shooting param p for bisection method
p_left  = 1.0;
p_right = 3.0;

% Compute residuals at the endpoints
v_left  = param_error(p_left, L, eps, alpha);
v_right = param_error(p_right, L, eps, alpha);

% use the bisection method to find the value of the shooting param p: 
for k = 1:maxIter
    p_mid = 0.5*(p_left + p_right);
    v_mid = param_error(p_mid, L, eps, alpha);

    fprintf('iteration = %d, p = %.12f, v(p) = %.12e\n', k, p_mid, v_mid);

    if abs(v_mid) < tol
        break;
    end

    if v_left * v_mid < 0
        p_right = p_mid;
        v_right = v_mid;
    else
        p_left = p_mid;
        v_left = v_mid;
    end
end

% set the final shooting param: 
p_final = p_mid;
fprintf('\nApproximate Final Shooting Parameter: p = %.12f\n', p_final);

% solve the system using our final shooting param to plot: 
[r, Y] = ode45(@(r,Y) ode(r, Y, alpha), [eps L], [p_final; 0]);

% get all v values output: 
v = Y(:,1);

% Plot solution:
figure;
plot(r, v, 'LineWidth', 2);
xlabel('r');
ylabel('v(r)');
title('Non-linear Shooting Method One-Node Solution with $\alpha = 0$, and $p = 2.356370492159$', 'Interpreter', 'latex');
grid on;


