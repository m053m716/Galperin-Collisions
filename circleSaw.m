function [Y,X,cIndex] = circleSaw(THETA,N,n)
%CIRCLESAW Saw wave constrained by unit-circle
%
%  [Y,X] = circleSaw(THETA,N)
%  [Y,X,cIndex] = circleSaw(THETA,N,n)
%
% Inputs
%  THETA  - Scalar or array of angles of saw peaks in square-root mass
%            state-space.
%  N      - Number of collisions. Same number of elements as THETA.
%  n      - (Optional) number of samples in range [-1 1] (x; default: 1000)
%
% Output
%  Y      - Vector or array of state-space y-values indicating the combined
%              velocity and square-root mass of the small mass (m1), for
%              each state-space value on the closed interval x in [-1 1].
%              -> If THETA is an array, then columns of Y correspond to
%                 each element of THETA.
%  x      - State-space value for the large mass (m2), in the range [-1 1].
%  cIndex - Collision indices. If multiple THETA values, then this is
%              returned as cell array with one cell per THETA value.
%
% See also: main.m

if nargin < 3
   n = 10000;
end

if numel(THETA)~=numel(N)
   error('THETA and N must have same number of elements.');
end

if numel(THETA) > 1
   Y = nan(n,numel(THETA));
   cIndex = cell(size(THETA));
   for ii = 1:numel(THETA)
      [Y(:,ii),X(:,ii),cIndex{ii}] = circleSaw(THETA(ii),N(ii),n);
   end
   return;
end

X = linspace(-1,1.05,n).';
Y = nan(n,1);
opts = optimset(optimset('fsolve'),'Display','off');
idx = 1;
Y(idx) = 0; % Always starts at zero.
cIndex = [1; nan(N-1,1)]; % System always starts with a collision
for k = 1:(N-1)
   [ypt,xpt,tmp_idx] = ...
      computeIntersection(-Y(idx),X(idx:end),THETA);
   idx = tmp_idx + cIndex(k) - 1;
   vec = (cIndex(k)+1):idx;
   X(vec) = xpt;
   Y(vec) = ypt;
   cIndex(k+1) = idx;
end
X(X >= 1) = nan;

   function [ys,xs,index] = computeIntersection(y0,xx,theta0)
      %COMPUTEINTERSECTION Helper function to compute intersect with circle
      m = -cot(theta0);
      x0 = xx(1);
      y_line = m.*(xx - x0) + y0;
      y_circ = -cos(xx.*(pi/2));
      
      index = find(y_line <= y_circ,1,'first');
      
      phi = atan2(y_circ(index),xx(index));
      yf = sin(phi);
      xf = cos(phi);
      
      xs = linspace(x0,xf,index);
      ys = interp1([x0,xf],[y0,yf],xs,'linear');
      xs(1) = [];
      ys(1) = [];
   end

end