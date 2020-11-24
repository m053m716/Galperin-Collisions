function fig = plotPhaseSpace(m,M,U0,V0,N,u_f,v_f)
%PLOTPHASESPACE Plot circle "Sawtooth" phase space
%
%  fig = plotPhaseSpace(m,M,U0,V0,N,u_f,v_f);
%
% Inputs
%  m - Small mass
%  M - Large mass(es)
%  V0 - Initial velocity of large mass(es)
%  u_f - Final velocit(ies) of small mass(es)
%  v_f - Final velocit(ies) of large mass(es)
%
% Output
%  fig - Figure handle
%
% See also: Contents, main.m

[fig,ax] = makeAxes(N);

for ii = 1:numel(N)
   Y = u_f{ii} .* sqrt(m) ./ sqrt(M(ii));
   X = v_f{ii} ./ abs(V0);
   addLine(ax,X,Y);
end

if nargout > 0
   return;
end

% % Save figure (deletes figure)
if numel(M) > 1
   io.optSaveFig(fig,'figures/Phase-Portraits',...
      'Phase-Portrait--Multiple-Large-Weights');
else
   io.optSaveFig(fig,'figures/Phase-Portraits',...
      sprintf('Phase-Portrait--m-%d--M-%d--U0-%d--V0-%d---N-%d',...
      m,M,U0,abs(V0),N));
end

end