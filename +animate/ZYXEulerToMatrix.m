function [Rx, Ry, Rz, M] = ZYXEulerToMatrix (e)
%ZYXEulerToMatrix Calculates the rotation matrix from ZYX Euler Angles
%
%  [Rx,Ry,Rz,M] = animate.ZYXEulerToMatrix(e);
%
% Inputs
%  e - Euler angle ([Z, Y, X])
%
% Output
%  Rx - Rotation matrix for x-plane
%  Ry - Rotation matrix for y-plane
%  Rz - ROtation matrix for z-plane
%
% See also: Contents, main.m

z = e(1);
y = e(2);
x = e(3);

sz = sin (z);
cz = cos (z);
sy = sin (y);
cy = cos (y);
sx = sin (x);
cx = cos (x);

Rx = [
1,  0,   0;
0, cx, -sx;
0, sx,  cx;
];

Ry = [
 cy, 0, sy;
  0, 1,  0;
-sy, 0, cy
];

Rz = [
cz, -sz, 0;
sz,  cz, 0;
 0,   0, 1;
];

% % Rx * Ry * Rz
% M = [
%          cy * cz,        - cy * sz,    +sy;
% sz*cx + sx*sy*cz, cz*cx - sx*sy*sz, -sx*cy;
% sz*sx - cx*sy*cz, cz*sx + cx*sy*sz,  cx*cy;
% ];
% 
% % Rz' * Ry' * Rx'
% M = [
%         cz * cy, -cz*sy*sx + sz* cx, cz*sy*cx + sz*sx;
% -sz*cy, - sz*sy*sx + cz*cx, sz*sy*cx + cz*sx;
% sy, -cy*sx, cy*cx;
% ];
% 
% % Rx' * Ry' * Rz'
% M = [
% cy*cz, cy*sz, -sy;
% -cx*sz+sx*sy*cz, cx*cz+sx*sy*sz, sx*cy;
% sx*sz+cx*sy*cz, -sx*cz+cx*sy*sz, cx*cy;
% ];

M = Rz * Ry * Rx;

end
