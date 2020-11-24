function v2 = final_velocity(m1,v1,m2,RHO)
%FINAL_VELOCITY Compute final velocity given 2 masses with 1 known final velocity and the system momentum and energy
%
%  v2 = physics.final_velocity(m1,v1,m2,RHO)
%
% Inputs
%  m1  - First mass, for which final velocity is known (kg)
%  v1  - Velocity of first mass (m/s)
%  m2  - Second mass, for which final velocity is to be computed (kg)
%  RHO - Initialy system momentum (kg*m/s)
%
% Output
%  v1  - Final velocity of second mass (m/s)
%
% See also: Contents, physics.energy, physics.momentum, run_collision,
%           main.m

v2 = (RHO - m1.*v1)./m2;

end