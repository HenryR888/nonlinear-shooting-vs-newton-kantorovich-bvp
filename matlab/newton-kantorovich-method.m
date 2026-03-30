% Here we implment the Newton-Kantorovich method:

clear; clc; close all;

% params:
L = 20; % we use a finite large approximation for our right Boundary Condition      
eps = 1e-6; % since we have a singularity at r=0, we initialise at 1x10^-6
N = 2000; % number of meshpoints that we use      
tol = 1e-8; % tolerance for stopping the update on v       
maxIter = 100; % maximum number of iterations
alpha = 0.0;

% setup our mesh grid: 
r = linspace(eps, L, N)';
h = L/N;

% initial guess for our v value. 
v = 2*exp(-r);
 %v= 2*(1 - r.^2).*exp(-r);

% this is our approximation to v(0):
fprintf('Initial guess: v(0) approx. = %.12f\n', v(1));

for k = 1:maxIter

    % create our system of linear equations in matrix form Az=b, where A
    % has all of our finite difference coeffs, z is the correction values
    % that we are solving for and b is our residual vector 
    A = zeros(N, N);
    b = zeros(N, 1);
    
    % since our initial cond. is v'(0)=0, we approx this by (v2-v1)/h
    % within our linearised matrix A
    A(1,1) = -1/h;
    A(1,2) =  1/h;
    b(1)   = -(v(2) - v(1))/h;
    
    % interior points: 
    for j = 2:N-1
        rj = r(j);

        % finite difference coefficients
        a = 1/h^2 - 1/(2*h*rj); % z_(j-1) coeff
        c = 1/h^2 + 1/(2*h*rj); % z_(j+1) coeff
        z = -2/h^2 - 1 + 6*v(j)^2 - 4*alpha*v(j)^3; % z_j coeff
        
        % input the finite difference coeffs into the A matrix
        A(j,j-1) = a;
        A(j,j)   = z;
        A(j,j+1) = c;

        % residual term: 
        vdprime = (v(j+1) - 2*v(j) + v(j-1))/h^2;
        vprime  = (v(j+1) - v(j-1))/(2*h);

        % compute RHS of the NK equation: 
        Fv = vdprime + (1/rj)*vprime - v(j) + 2*v(j)^3 - alpha*v(j)^4;
        
        % enter all terms into the residual vec b: 
        b(j) = -Fv;
    end

  
    A(N,N) = 1;
    b(N)   = -v(N);

    % Solve for correction
    delta = A \ b;

    % Update
    v_new = v + delta;

    % monitor convergence
    err = max(abs(delta));
    fprintf('iteration = %d, max correction = %.12e, v(0) approx = %.12f\n', ...
            k, err, v_new(1));

    v = v_new;

    if err < tol
        break;
    end
end

fprintf('\nApproximate converged value v(0) = %.12f\n', v(1));

% Plot solution
figure;
plot(r, v, 'LineWidth', 2);
xlabel('r');
ylabel('v(r)');
title('Newton-Kantorovich Method Monotonically Decaying solution with $\alpha = 0$ and v(0) = 1.559212549029', 'Interpreter', 'latex');
grid on;