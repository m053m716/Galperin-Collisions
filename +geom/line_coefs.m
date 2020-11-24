function p = line_coefs(m,v,k)
%LINE_COEFS Returns corresponding polynomial coefficients for a line.
%
%  p = geom.line_coefs(m,v);
%  p = geom.line_coefs(m,v,k);
%
% Inputs
%  m : Vector of masses
%  v : Vector of velocities
%  k : (Optional; default: 2) Index of mass/velocity pair to use in
%           left-hand side of expression.
%
% Output
%  p : Polynomial coefficients, in quadratic polynomial form. 
%       They represent the conservation of momentum:
%
%       m(1)*v(1) + m(2)*v(2) + ... + m(end)*v(end) = TOTAL_MOMENTUM;
%        -> v(k) = -1*SUM(m(i)v(i)/m(k)), such that i ~= k
%
% See also: main.m, run_collision, tabulate_num_collisions

if nargin < 3
   k = 2;
end

% Quadratic polynomial form
p = [0, m(1)/m(k), -sum(physics.momentum(m,v))/m(k)];
end