function rho = momentum(m,v)
%MOMENTUM Compute the momentum of system elements given masses and velocities.
%
%  rho = physics.momentum(m,v);
%
% Inputs
%  m   : Vector of masses in collision
%  v   : Vector of velocities in collision
%
% Output
%  rho : Vector of momentums
%
% See also: Contents, main.m, run_collision, physics.energy

rho = m.*v;
end