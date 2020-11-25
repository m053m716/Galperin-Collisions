function data = waveform(type)
%WAVEFORM Return default waveform for convolution with pulse train
%
%  data = default.waveform()
%  data = default.waveform('type');
%
% Inputs
%  type - (Optional): If not specified, returns fixed vector specified in
%           this script. Can be:
%              * 'vector' : (same as not giving arg)
%              * 'file'   : Currently: 'Collision.wav'
%
% Output
%  data - Waveform for convolution with audio pulse train.
%
% See also: Contents, main.m, writeCollisionSounds

data = [-0.5; 0.5; 1.0; 0.5; -0.5];
if nargin < 1
   return;
end
switch lower(type)
   case 'vector'
      return;
   case 'file'
      data = 'Collision.wav';
   otherwise
      warning('`type` ("%s") not recognized. Returning `vector` type.');
      return;
end


end