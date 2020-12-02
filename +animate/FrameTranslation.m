function F = FrameTranslation(d)
%FRAMETRANSLATION Returns formatted array for Frame Translation matrix
%
%  F = animate.FrameTranslation(d);
%
% Inputs
%  d - Movement part, which is a 3-D vector wherein the the
%                 components correspond to movement in along the axis
%                 corresponding to the ordering given in the second input
%                 argument
%
% Output
%  F - Translation matrix
%
%  See explanation in animate.VectorCrossMatrix for why this might be
%  useful.
%
% See also: Contents, main.m, animate.VectorCrossMatrix

% Here we store the result
F = eye(4);

% Set the translation part:
F(1:3, 4) = d;


end
