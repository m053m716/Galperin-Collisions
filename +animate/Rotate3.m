function R = Rotate3(u,theta)
%ROTATE3 Return 3-D rotation matrix
%
% See: https://en.wikipedia.org/wiki/Rotation_matrix#Rotation_matrix_from_axis_and_angle
%
% Inputs
%  u     - 3-element axis [ux, uy, uz] about which we will be rotating.
%  theta - The number of radians to rotate.
%
% Output
%  R     - Rotation matrix, so that any point rotating about the axis that
%           is attached to the rotating rigid body can be 
%
% See also: Contents, main.m

% Outer-product:
if isrow(u)
   o = u' * u;
else
   o = u * u';
end
   
R = cos(theta) * eye(3) + ...
    sin(theta) * animate.VectorCrossMatrix(u) + ...
    (1 - cos(theta)) * o;

end