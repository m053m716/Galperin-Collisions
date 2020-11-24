function [N,THETA] = numCollisions(m1,m2)
%NUMCOLLISIONS Returns total number of collisions based on the masses
%
%  [N,THETA] = numCollisions(m1,m2);
%
% Inputs
%  m1 - Mass of "small object" (scalar)
%  m2 - Mass or array of masses of "large object(s)"
%
% Output
%  N     - Integer number of collisions the same size as input `m2`
%  THETA - Angle between the two masses when scaled onto unit circle (rad)
%
% See also: main.m

if any(m2 < m1)
   error('First mass must be smaller than any other mass.');
end
THETA = atan(sqrt(m1)./sqrt(m2));
N = floor(pi./THETA);
N(m1==m2) = 3; % First object hits 2nd, completely conserving momentum so it stops
               % Second object hits the wall bounces back, completely
               % conserving momentum it stops and the first object moves in
               % the opposite direction it started. This results in 3 total
               % collisions.
[N,iSort] = sort(N,'descend');
THETA = THETA(iSort);

end