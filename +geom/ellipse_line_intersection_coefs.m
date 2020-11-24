function [p,r,f] = ellipse_line_intersection_coefs(p_e,p_line)
%ELLIPSE_LINE_INTERSECTION_COEFS Return coefficients for polynomial of intersection of ellipse by some line
%
%  p = geom.ellipse_line_intersection_coefs(p_e,p_line);
%  [p,r,f] = geom.ellipse_line_intersection_coefs(p_e,p_line);
%
% Inputs
%  p_e      - Polynomial coefficients for quadratic representation of
%              ellipse, which will be intersected by some line. 
%              See also:
%                 geom.ellipse_coefs.
%  p_line   - Polynomial coefficients of the line under consideration
%
% Output
%  p        - Polynomial coefficients for the system of the line
%              intersecting the ellipse.
%  r        - Roots of the polynomial equation described by `p`
%              Note: If the line intersects the ellipse, then there will be
%                       real-valued roots of the polynomial; if they are
%                       tangent, there will only be one intersection and
%                       therefore only one root (polynomial will only have
%                       one non-zero term). If they do not intersect, then
%                       roots will be imaginary and the polynomial has
%                       terms that are all the same sign.
%  f        - Polynomial function handle.
%
% See also: Contents, main.m, geom.ellipse_coefs

if iscolumn(p_line)
   p_line = p_line.';
end

switch numel(p_line)
   case 1
      p_line = [0 0 p_line]; % Assumes a constant
   case 2
      p_line = [0 p_line];
   case 3 % Then do nothing
      
   otherwise
      error('p_line must contain at least 1 element (assumed to be a constant)');
end

p = p_e - p_line;
r = roots(p);
f = @(v)polyval(p,v);
end