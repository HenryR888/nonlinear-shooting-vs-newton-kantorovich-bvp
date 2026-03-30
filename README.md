# Non-linear Boundary Value Problem — Advanced Numerical Methods

This project implements and compares two numerical methods for solving a cubic–quartic non-linear boundary value problem:

$$
\frac{d^2v}{dr^2} + \frac{1}{r}\frac{dv}{dr} - v + 2v^3 - \alpha v^4 = 0
$$

with boundary conditions:

$$
v'(0) = 0, \qquad v(\infty) = 0
$$

### Shooting Method (with bisection)
- Reformulates the BVP as an IVP with unknown initial condition $$v(0) = p $$
- Uses MATLAB’s `ode45` for integration
- Applies **bisection** to determine the correct shooting parameter

### Newton–Kantorovich Method 
- Linearises the nonlinear operator using the Fréchet derivative
- Discretises using **finite differences**
- Solves a tridiagonal linear system at each iteration

The goal is to compute and analyse two solution branches:
- monotonically decaying solutions  
- one-node solutions  

and to study how these solutions behave as the parameter \( \alpha \) varies.

---

## Objectives

The project investigates:

- Computation of:
  - **Monotonically decaying solutions**
  - **One-node solutions**
- How these solution branches evolve as \( \alpha \) varies
- A comparison of numerical methods in terms of:
  - Convergence speed,
  - Stability,
  - Sensitivity to initial guesses,
  - Dependence on domain truncation and mesh resolution.

Full details and results are documented in `project.pdf`.

---

## Attribution

The problem was provided as coursework in:

**MAM3042F – Advanced Numerical Methods**  
University of Cape Town  

Lecturer: **Dr N. V. Alexeeva**

All implementations, experiments, and analysis in this repository are my own.