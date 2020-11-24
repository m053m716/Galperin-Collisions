function nu = energy(m,v)
%ENERGY Compute the kinetic energy given masses and velocities.
%
%  nu = physics.energy(m,v);
%
% Inputs
%  m  : Vector of masses in collision
%  v  : Vector of velocities in collision
%
% Output
%  nu : Vector of energies (same size as m)
%
% See also: Contents, main.m, run_collision, physics.momentum
nu = 0.5.*m.*v.^2;
end