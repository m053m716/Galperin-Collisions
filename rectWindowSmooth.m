function s = rectWindowSmooth(y,wlen,nLevels)
%RECTWINDOWSMOOTH    Apply `rect` smoothing window to `y`
%
%  s = rectWindowSmooth(y,wlen);
%  s = rectWindowSmooth(y,wlen,nLevels);
%
% Inputs
%  y - Signal of interest to be smoothed
%  wlen - Length (samples) of smoothing window
%  nLevels - (Optional | Default: 30) Number of levels over which to smooth
%              using shorter versions of the initial smoothing window.
%
% Output
%  s - Smoothed version of `y`
%
% See also: Contents, main.m, getSmoothedRate

if nargin < 3
   nLevels = 30;
end

s = zeros(size(y));
W = round(logspace(0,log10(wlen),nLevels));
for ii = 1:nLevels
   s = s + convFilt(y,W(ii));
end

   function z = convFilt(y,wlen)
      %CONVFILT Implement forward and backward average convolution
      %
      %  s = convFilt(x,wlen);
      %
      % Inputs
      %  y    - Signal of interest
      %  wlen - Length of rect convolution window (samples)
      %
      % Output
      %  z    - Result of average convolution retaining same shape as
      %           signal of interest but averaging so that it is not biased
      %           by convolution of the rect window "leading" from the
      %           "left" or "right" edge of the sample window.
      
      h = ones(wlen,1);
      y = abs(y(:));
      z = (conv(y,h,'same') + flipud(conv(flipud(y),h,'same')))./2;
   end

end