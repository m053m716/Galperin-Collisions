function w = noise(type)
%NOISE Return default noise-bandwidth for a given type of noise process
%
%  w = default.noise();
%     -> Default value is unit-bandwidth (w == 1).
%
%  w = default.noise(type);
%
% Inputs
%  type - Optional; 'audio' | 
%
% Output
%  w    - Noise bandwidth; the number of standard-deviations for a Gaussian
%           zero-mean process.
%
% See also: Contents, main.m, writeCollisionSounds

w = 1;
if nargin < 1
   return;
end

switch lower(type)
   case {'audio','sound','process'}
      w = 0; % Zero-noise process
      return;
   case {'low','quiet'}
      w = 0.015;
   case {'medium','moderate'}
      w = 0.05;
   case {'high','loud'}
      w = 0.08;
   otherwise
      warning('Unexpected `type` ("%s"); returning unit bandwidth.',type);
      return;
end
   

end