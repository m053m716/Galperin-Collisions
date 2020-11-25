function [audioData,fs,tSample] = writeCollisionSounds(t,fname,fs,w)
%WRITECOLLISIONSOUNDS Make files with "collision sounds" 
%
%  writeCollisionSounds(t,fname,fs);
%  -> Auto-saves sounds
%
%  [audioData,fs,tSample] = writeCollisionSounds(t);
%  -> Doesn't auto-save any sounds, returns them to workspace
%
% Inputs
%  t     - Numeric vector (or cell of numeric vectors) where each element is 
%           the inter-collision-interval.
%  fname - Filename of audio file to convolve with collision-generated
%           pulse train. If empty, it uses a default vector that is
%           designed to mimic "impulse" sounds with a triangular shape and
%           "suppression" just-outside the impulse.
%  fs    - (Optional) sample rate for the disk file (Default: 44.1-kHz)
%  w     - (Optional) bandwidth of noise background (Default: 0)
%
% Output
%  audioData - Time-series data, which may have noise superimposed, but is
%                 essentially a pulse-train version of the collision events
%                 as they would be spaced in time from the collision model,
%                 possibly convolved with some waveform of interest that is
%                 represented at each collision impulse.
%  fs        - Sample rate of audio time-series
%  tSample   - Sample times of each element in the time-series.
%
% See also: Contents, main.m

switch nargin
   case 1
      % Read in the sound to use for collisions
      [data,fname,fs] = parseAudioData('vector');
      w = default.noise('audio');
   case 2
      % Read in the sound to use for collisions
      [data,fname,fs] = parseAudioData(fname);
      w = default.noise('audio');
   otherwise
      [data,fname] = parseAudioData(fname,fs);
      if nargin < 4
         w = default.noise('audio');
      end
end

if iscell(t)
   audioData = cell(numel(t),1);
   for ii = 1:numel(t)
      if nargout > 0 
         [audioData{ii},fs] = writeCollisionSounds(t{ii},fname,fs,w);
      else
         writeCollisionSounds(t{ii},fname,fs,w);
      end
   end
   return;
end

t(isinf(t)) = []; % Remove infinite elements
tc = cumsum(t);
tMax = max(tc) + 0.05*max(tc);
tMin = -0.05*max(tc);

tSample = (tMin:(1/fs):tMax)';
audioData = zeros(size(tSample));

% Insert collision instants to audio data
for ii = 1:numel(tc)
   [~,idx] = min(abs(tSample - tc(ii)));
   audioData(idx) = 1;
end

% Add process noise if desired
if isnumeric(w)
   noise_str = sprintf('%s-w',strrep(num2str(w),'.','-'));
else
   noise_str = sprintf('%s-noise',w);
   w = default.noise(w);
end
audioData = audioData + randn(size(audioData)).*w;

% Convolve with `data` to get sounds of collision
audioData = conv(audioData,data,'same');
audioData = audioData ./ max(abs(audioData)); % Make sure it is scaled

if nargout > 0
   return;
end

[~,fname_short,~] = fileparts(fname);

fname_out = sprintf('%d-Collisions_%d-seconds_%s-sound_%s',...
   numel(t),round(tMax-tMin),...
   fname_short,...
   noise_str);
if exist(fullfile(pwd,'audio'),'dir')==0
   mkdir(fullfile(pwd,'audio'));
end
audiowrite(fullfile(pwd,'audio',[fname_out '.wav']),audioData,fs,...
   'Title',strrep(fname_out,'_',' in '),...
   'Artist','Nigel',...
   'Comment','See Also: Galperin''s Law');

   function fname = parseAudioName(fname)
      [p,f,e] = fileparts(fname);
      if isempty(e)
         e = '.wav';
      end
      fname = fullfile(p,[f e]);      
   end

   function [data,fname,fs] = parseAudioData(fname,fs)
      if isempty(fname)
         fname = 'vector';
         data = default.waveform(fname);
         fs = default.fs('audio');
      elseif isnumeric(fname)
         data = fname;
         fs = default.fs('audio');
         fname = 'custom-vector';
         audiowrite(fullfile(pwd,[fname '.wav']),data,fs,...
            'Title','Custom-Waveform','Artist','Nigel');
      elseif strcmpi(fname,'vector')
         fname = 'vector';
         data = default.waveform(fname);
         fs = default.fs('audio');
      else
         fname = parseAudioName(fname);
         [data,fs_audio] = audioread(fname);
         if nargin > 1
            data = resample(data,fs,fs_audio);
         else
            fs = fs_audio;
         end
      end
   end

end