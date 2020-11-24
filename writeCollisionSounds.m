function [audioData,fs] = writeCollisionSounds(t,fname,fs)
%WRITECOLLISIONSOUNDS Make files with "collision sounds" 
%
%  writeCollisionSounds(t,fname,fs);
%  -> Auto-saves sounds
%
%  [audioData,fs] = writeCollisionSounds(t);
%  -> Doesn't auto-save any sounds, returns them to workspace
%
% Inputs
%  t  - Numeric vector (or cell of numeric vectors) where each element is 
%        the inter-collision-interval.
%  fs - (Optional) sample rate for the disk file (Default: 44.1-kHz)

if iscell(t)
   audioData = cell(numel(t),1);
   switch nargin
      case 1
         for ii = 1:numel(t)
            if nargout > 0 
               [audioData{ii},fs] = writeCollisionSounds(t{ii});
            else
               writeCollisionSounds(t{ii});
            end
         end
      case 2
         for ii = 1:numel(t)
            if nargout > 0
               [audioData{ii},fs] = writeCollisionSounds(t{ii},fname);
            else
               writeCollisionSounds(t{ii},fname);
            end
         end
      case 3
         for ii = 1:numel(t)
            if nargout > 0
               audioData{ii} = writeCollisionSounds(t{ii},fname,fs);
            else
               writeCollisionSounds(t{ii},fname,fs);
            end
         end
      otherwise
         error("Invalid number of arguments (requires 1-3 args)");
   end
   return;
end

switch nargin
   case 1
      % Read in the sound to use for collisions
      [data,fs] = audioread('HAMMER.WAV');
   case 2
      % Read in the sound to use for collisions
      [data,fs] = audioread(fname);
   case 3
      if isempty(fname)
         [data,fs_audio] = audioread('HAMMER.WAV');
         fs_audio = fs_audio * 4; % Just to make it "higher pitched"
      else
         [data,fs_audio] = audioread(fname);
      end
      data = resample(data,fs,fs_audio);
   otherwise
      error("Invalid number of arguments (requires 1-3 args)");
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

% Convolve with `data` to get sounds of collision
audioData = conv(audioData,0.25*data,'same');
audioData = audioData ./ max(abs(audioData)); % Make sure it is scaled

if nargout > 0
   return;
end

fname = sprintf('%d-Collisions_%d-seconds',numel(t),round(tMax-tMin));
if exist(fullfile(pwd,'audio'),'dir')==0
   mkdir(fullfile(pwd,'audio'));
end
audiowrite(fullfile(pwd,'audio',[fname '.wav']),audioData,fs,...
   'Title',strrep(fname,'_',' in '),...
   'Artist','Nigel',...
   'Comment','See Also: Galperin''s Law');

end