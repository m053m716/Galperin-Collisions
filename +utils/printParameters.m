function printParameters(m,M,u_i,v_i,u_f,v_f,N)
%PRINTPARAMETERS Print parameters to Command Window
%
%  utils.printParameters(m,M,u_i,v_i,u_f,v_f);
%  utils.printParameters(m,M,u_i,v_i,u_f,v_f,N);
%
% Inputs
%  m   - Small mass (kg)
%  M   - Large mass (kg)
%  u_i - Initial velocity of small mass, just before impact (m/s)
%  v_i - Initial velocity of large mass, just before impact (m/s)
%  u_f - Final velocity of small mass just after collision (m/s)
%  v_f - Final velocity of large mass just after collision (m/s)
%  N     - (Optional) number of collisions so far
%
% Output
%  Prints the formatted values to the Command Window.
%
% See also: Contents, main.m, tabulate_num_collisions

if nargin > 6
   utils.printIndentedCount(N);
end

fprintf(1,'\t\t<strong>`m:`</strong>   %5.2f (kg)\n',m);
fprintf(1,'\t\t<strong>`M:`</strong>   %5.2f (kg)\n',M);
fprintf(1,'\t\t<strong>`u_i:`</strong> %5.2f (m/s)\n',u_i);
fprintf(1,'\t\t<strong>`v_i:`</strong> %5.2f (m/s)\n',v_i);
fprintf(1,'\t\t<strong>`u_f:`</strong> %5.2f (m/s)\n',u_f);
fprintf(1,'\t\t<strong>`v_f:`</strong> %5.2f (m/s)\n\n',v_f);

end