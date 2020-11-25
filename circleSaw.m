function [Y,X] = circleSaw(THETA,N)
%CIRCLESAW Saw wave constrained by unit-circle
%
%  [Y,X] = circleSaw(THETA,N)
%
% Inputs
%  THETA  - Scalar or array of angles of saw peaks in square-root mass
%            state-space.
%  N      - Number of collisions. Same number of elements as THETA.
%
% Output
%  Y      - Cell array of vectors. 
%              v1 * sqrt(m1)
%  X      - Cell array of vectors corresponding to Y.
%              v2 * sqrt(m2)
%
% See also: main.m

if numel(THETA)~=numel(N)
   error('THETA and N must have same number of elements.');
end

if numel(THETA) > 1
   Y = cell(numel(THETA),1);
   X = cell(numel(THETA),1);
   for ii = 1:numel(THETA)
      [Y{ii},X{ii}] = circleSaw(THETA(ii),N(ii));
   end
   return;
end

index = 1;
Y = zeros((N-1)*2,1);
X = -ones((N-1)*2,1);
opts = optimset(optimset('fminbnd'), ...
   'Display','off', ...
   'TolX',1e-7, ...
   'MaxIter',1500, ...
   'MaxFunEvals',1500 ...
   ... 'PlotFcns',{@optimplotfval} ...
   );
while index < ((N-1)*2)
   index = index + 1;
   [Y(index),X(index)] = compute(X(index-1),Y(index-1),THETA,opts);
   index = index + 1;
   Y(index) = -Y(index-1);
   X(index) = X(index-1);
end

   function [y,x] = compute(x0,y0,theta,opts)
      %COMPUTE Helper function to compute intersect with circle
      
      m = -cot(theta);
      y_line = @(x)f(x,m,x0,y0);
      fun = @(x)(1 - (x^2 + y_line(x)^2))^2;
      x = fminbnd(fun, x0, 1.05, opts);
      y = y_line(x);
   end

   function y = f(x,m,x0,y0)
      %F Helper function to solve using point-slope equation
      y = y0 + m*(x - x0);
   end


end