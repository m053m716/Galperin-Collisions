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
%
% Output
%  s - Smoothed (savitzky-golay 3rd-order filter, 1-second window) rate
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
pars.KaiserShape = 38;
pars.Normalization = 'maxmed';
pars.Order = 3;
pars.WLen_Seconds = 2;

fn = fieldnames(pars);

for iV = 1:2:numel(varargin)
   idx = strcmpi(fn,varargin{iV});
   if sum(idx) == 1
      pars.(fn{idx}) = varargin{iV+1};
   end
end


if numel(t) == 1
   fs = t;
else
   fs = round(1./nanmean(diff(t(~isinf(t)))));
end

wlen = round(fs * pars.WLen_Seconds);
if rem(wlen,2)==0
   wlen = wlen + 1; % Must be odd-valued window length (samples)
end

s = sgolayfilt(abs(y),pars.Order,wlen,kaiser(wlen,pars.KaiserShape),1);

switch lower(pars.Normalization)
   case 'max'
      s = s./max(abs(s));
      return;
   case 'maxmed'
      s = s./max(abs(s)) - median(s./max(abs(s)));
      return;
   case 'none'
      return;
   otherwise
      warning('Unrecognized value for "Normalization": %s (no normalization performed)',pars.Normalization);
      return;
end

end