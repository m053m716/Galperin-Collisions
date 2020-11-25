function s = getSmoothedRate(y,t,varargin)
%GETSMOOTHEDRATE Return smoothed rate for time-series y of noisy impulses
%
%  s = getSmoothedRate(y,t);
%  s = getSmoothedRate(y,fs);
%  s = getSmoothedRate(y,fs,'Name',value,...);
%
% Inputs
%  y - Amplitude values of (noisy) impulse sequence, for rate estimation.
%
%  AND EITHER:
%  t  - Time values of each sample
%  fs - Single scalar value corresponding to sample rate
%
%  varargin - Optional 'Name',value input argument pairs:
%              * 'Normalization': 'maxmed' (def) | 'max' | 'none'
%              * 'N_Levels': Number of "halvings" of filter order
%              * 'WLen_Seconds': Initial filter length.
%
% Output
%  s - Smoothed estimate using 'N_Levels' averaged forward and backward
%        convolutions with rectangle of length `WLen_Seconds / level`
%
% See also: Contents, main.m, writeCollisionSounds, plotSeries

if iscell(y)
   s = cell(size(y));
   if (numel(t) == numel(y)) && ~iscell(t)
      for ii = 1:numel(y)
         s{ii} = getSmoothedRate(y{ii},t(ii),varargin{:});
      end
   else
      for ii = 1:numel(y)
         s{ii} = getSmoothedRate(y{ii},t{ii},varargin{:});
      end
   end   
   return;
end

pars = struct;
pars.Normalization = 'maxmed';
pars.N_Levels = 30;
pars.WLen_Seconds = 2;

fn = fieldnames(pars);

for iV = 1:2:numel(varargin)
   idx = strcmpi(fn,varargin{iV});
   if sum(idx) == 1
      pars.(fn{idx}) = varargin{iV+1};
   end
end

% Was it times or sample rate that was given?
if numel(t) == 1
   fs = t;
%    t = 0:(1/fs):((numel(y)-1)/fs);
else
   fs = round(1./nanmean(diff(t(~isinf(t)))));
end

wlen = round(fs * pars.WLen_Seconds);
s = rectWindowSmooth(y,wlen,pars.N_Levels);

switch lower(pars.Normalization)
   case 'max'
      s = s./max(abs(s));
   case 'maxmed'
      s = s./max(abs(s)) - median(s./max(abs(s)));
   case 'none'
      % Do nothing
   otherwise
      warning('Unrecognized value for "Normalization": %s (no normalization performed)',pars.Normalization);
      % Do nothing
end

% Remove edge-effect parts:
iStart = round(wlen / pars.N_Levels);
iStop = numel(s) - iStart + 1;
s(1:iStart) = nan;
s(iStop:end) = nan;

end