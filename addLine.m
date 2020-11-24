function [h,c] = addLine(ax,X,Y,dispName)
%ADDLINE Add a line to the axes
%
%  [h,c] = addLine(ax,X,Y);
%  [h,c] = addLine(ax,X,Y,dispName);
%
% Inputs
%  ax    - Axes
%  X     - Phase-space x-values (column vector or array)
%  Y     - Phase-space y-values (column vector or array)
%  dispName - (Optional) `DisplayName` property of line
%
% Output
%  h     - Line object
%  c     - Color of line
%
% See also: main.m

if iscell(Y)
   n = numel(Y);
   h = gobjects(n,1);
   c = nan(n,3);
   for ii = 1:n
      [h(ii),c(ii,:)] = addLine(ax,X{ii},Y{ii});
   end
   return;
end

if numel(X) ~= numel(Y)
   error('Number of rows in x and Y must be equal.');
end

if nargin < 4
   dispName = sprintf('(N = %d)',ax.UserData.N(ax.UserData.CurrentIndex));
end

% c = max(min([0.1 0.7 0.2] + randn(1,3).*[0.025 0.1 0.035],[1 1 1]),[0 0 0]);
c = ax.UserData.CMap(ax.UserData.CurrentIndex,:);
% mrk = ax.UserData.CollisionIndex{ax.UserData.CurrentIndex};
mrk = [1,2:2:numel(X)];
% iSuppress = mrk((mrk+1) < numel(Y))+1;
% Y(iSuppress) = nan(numel(iSuppress),1);
h = hggroup(ax,'DisplayName',dispName);
h.Annotation.LegendInformation.IconDisplayStyle = 'on';
line(h,X,Y,'LineStyle','none','MarkerEdgeColor','b','LineWidth',3,...
   'Marker','o','MarkerSize',12,'MarkerIndices',3:2:numel(X),...
   'MarkerFaceColor','none');
hl = line(h,X,Y, ...
   'LineWidth',1.5 + randn(1)*0.1, ...
   'Color',c,...
   'Marker','o',...
   'MarkerFaceColor','b',...
   'MarkerEdgeColor',[0 0 0],...
   'MarkerIndices',mrk,...
   'MarkerSize',12,...
   'Tag','Sawtooth',...
   'DisplayName',dispName);
hl.Annotation.LegendInformation.IconDisplayStyle = 'on';
ax.UserData.CurrentIndex = ax.UserData.CurrentIndex + 1;

end
