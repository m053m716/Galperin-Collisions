function printIndentedCount(N,nDash,nTab,tag)
%PRINTINDENTEDCOUNT Print count with fixed number dashes in box and/or tabs
%
%  utils.printIndentedCount(N);
%  utils.printIndentedCount(N,nDash);
%  utils.printIndentedCount(N,nDash,nTab);
%  utils.printIndentedCount(N,nDash,nTab,tag);
%
% Inputs
%  N     - Total count of collisions
%  nDash - Number of dashes in delimiter box for formatted print output
%           (def: 41)
%  nTab  - Total number of tabs for indented spacing.
%           (def:  2)
%  tag   - String or char array "tag" to prepend prior to "N = x" part.
%           def:  '')
%
% Output
%  Prints count to Command Window.
%
% See also: Contents, main.m

if nargin < 4
   tag = '';
end

if nargin < 3
   nTab = 2;
end

if nargin < 2
   nDash = 41;
end
tab_str = sprintf(repmat('\t',1,nTab));
fprintf(1,'\n%s%s\n',tab_str,repmat('-',1,nDash)); % Print ---------
halfDash = nDash - floor(nDash/2);
str = sprintf('%s<strong>%s%%+%ds</strong>\\n',...
   repmat('\t',1,nTab),tag,halfDash);
fprintf(1,str,sprintf('N = %d',N));                % Print   N = %d
fprintf(1,'%s%s\n',tab_str,repmat('-',1,nDash));   % Print ---------

end