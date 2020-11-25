function data = fs(type)
%FS Return default waveform sample rate
%
%  data = default.waveform()
%  data = default.waveform(type);
%
% Inputs
%  type - (Optional): If not specified, returns fixed vector specified in
%           this script. Can be:
%              * 'audio' : Default (if not given)
%
% Output
%  data - Waveform for convolution with audio pulse train.
%
% See also: Contents, main.m, writeCollisionSounds

data = 44100;
if nargin < 1
   return;
end
switch lower(type)
   case {'fs','audio','sample_rate','samplerate'}
      return;
   otherwise
      warning('`type` ("%s") not recognized. Returning `vector` type.');
      return;
end


end