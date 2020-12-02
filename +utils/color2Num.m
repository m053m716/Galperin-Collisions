function rgb = color2Num(color,errorOnUnknown,def)
%COLOR2NUM Return color triplet with values in range [0,1]
%
%  rgb = utils.colorToNum(color);
%  -> Parses cases like 'k' or 'black' and returns corresponding color
%     triple on range [0, 1] (i.e. [0,0,0] for black).
%
%  rgb = utils.colorToNum(color,false);
%  -> Throws warning instead of error on unknown color
%
%  rgb = utils.colorToNum(color,false,def);
%  -> Sets "unknown" color value default to the triple in def. Default is
%        [0,0,0]
%
% Inputs
%  color - Character array or string. If this is given as an array, it will
%           return the result for each, giving the default color triple on
%           a mismatch unless throwErrorOnUnknownName is explicitly set.
%
%  errorOnUnknown - Default: true | set to false to only give warning and
%              automatically return the "default" value for unknown color
%              strings.
%
%  def - Default: [0,0,0] | Default color triple that is assigned when the
%                             string cannot be matched.
%
% Output
%  rgb - RGB triple, or array of such triples if array input given.
%
% See also: Contents

MIS_STR = 'Unexpected color (as %s): <strong>%s</strong>';

if nargin < 2
   errorOnUnknown = true;
   isExplicit = false;
else
   isExplicit = true;
end

if nargin < 3
   def = [0,0,0]; % DEFAULT value for mismatch
end

if iscell(color) || isstring(color)
   rgb = nan(numel(color),3);
   for ii = 1:numel(color)
      rgb(ii,:) = utils.color2Num(color,errorOnUnknown && isExplicit,def);
   end
   return;
end
   
try
   if startsWith(color,'#') % Then convert hex code
      rgb = utils.hex2rgb(color,1);
      return;
   end
catch
   if contains(color,'#') % If startsWith isn't on that version try contains
      rgb = utils.hex2rgb(color,1);
      return;
   end
end

switch lower(color)
   case {'red','r'}
      rgb = [1, 0, 0];
   case {'magenta','m'}
      rgb = [1, 0, 1];
   case {'yellow','y'}
      rgb = [1, 1, 0];
   case {'green','g'}
      rgb = [0, 1, 0];
   case {'cyan','c'}
      rgb = [0, 1, 1];
   case {'black','k'}
      rgb = [0, 0, 0];
   case {'blue','b'}
      rgb = [0, 0, 1];
   case {'white','w'}
      rgb = [1, 1, 1];
   case 'none'
      rgb = [0, 0, 0];
   otherwise
      rgb = utils.hex2rgb(color,1);
      if isempty(rgb)      
         c = class(color);
         if errorOnUnknown
            error(['utils:' mfilename ':UnknownCase'],MIS_STR,c,color);
         else
            warning(MIS_STR,c,color);
            rgb = def;
         end
      end
end

end