function printTaggedParameters(tag,m,M,u_i,v_i,u_f,v_f,N)
%PRINTTAGGEDPARAMETERS Print "tagged" parameters to Command Window
%
%  utils.printTaggedParameters(tag,m,M,u_i,v_i,u_f,v_f,N)
%
% Inputs
%  tag   - String to "tag" these parameters
%  m     - Small mass (kg)
%  M     - Large mass (kg)
%  u_i   - Initial velocity of small mass just before collision (m/s)
%  v_i   - Initial velocity of large mass just before collision (m/s)
%  u_f   - Final velocity options of small mass just after collision (m/s)
%  v_f   - Final velocity options of large mass just after collision (m/s)
%  N     - (Optional) number of collisions this update pertains to.
%
% Output
%  Prints the formatted values to the Command Window.
%
% See also: Contents, main.m, tabulate_num_collisions

if nargin > 7
   tag = sprintf('%s: %d -> %d',tag,N,N+1);
end
s_tag = sprintf('--- [BEGIN | %s] --------------------------',tag);
n = numel(s_tag);
str = sprintf('\\t\\t\\t| <strong>`%%3s:`</strong>%%%ds| \\n',n - 9);
fprintf(1,'\t\t\t%s\n',s_tag);
fprintf(1,'\t\t\t|%s|\n',repmat(' ',1,n-2));
fprintf(1,str,'m',sprintf('%6.2f (kg) ',m));
fprintf(1,str,'M',sprintf('%6.2f (kg) ',M));
fprintf(1,str,'u_i',sprintf('%6.2f (m/s) ',u_i));
fprintf(1,str,'v_i',sprintf('%6.2f (m/s) ',v_i));
fprintf(1,str,'u_f',sprintf('%8.2f (m/s) ',u_f));
fprintf(1,str,'v_f',sprintf('%8.2f (m/s) ',v_f));
fprintf(1,'\t\t\t|%s|\n',repmat(' ',1,n-2));
fprintf(1,'\t\t\t---------------------------- [END | %s] ---\n',tag);

end