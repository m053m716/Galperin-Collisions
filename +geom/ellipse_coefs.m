function [p,r,f] = ellipse_coefs(m,M,u,V)
%ELLIPSE_COEFS Returns corresponding polynomial coefficients for an ellipse.
%
%  p = geom.ellipse_coefs(m,M,u,V);
%  [p,r,f] = geom.ellipse_coefs(m,M,u,V);
%
% Inputs
%  m   - Small mass (kg)
%  M   - Large mass (kg)
%  u   - Current velocity of small mass, just before impact (m/s)
%  v   - Current velocity of large mass, just before impact (m/s)
%  V   - Very initial velocity of large mass, prior to any impact (m/s)
%
% Output
%  p : Polynomial coefficients in quadratic polynomial :
%       m(1)*v(1)^2 + m(2)*v(2)^2 + ... + m(end)*v(end)^2 = NU
%  r : Roots corresponding to `p`
%  f : Evaluation function for polynomial expression as function of v(1).
%
% See also: main.m, run_collision, tabulate_num_collisions

a =  m(1)/2 * (1 - m(1)/m(2));
b = -m(1)*RHO;
c =  RHO^2/(2*m(2)) - NU;

% Quadratic polynomial form
p = [a, b, c];
r = roots(p);
f = @(v1)polyval(p,v1);

end