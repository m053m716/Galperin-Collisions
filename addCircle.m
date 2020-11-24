function h = addCircle(fig,pos,varargin)
%ADDCIRCLE Add circle to axes (really to its Parent figure)
%
%  h = addCircle(ax);
%  h = addCircle(ax,pos);
%  h = addCircle(ax,pos,'Name',value,...);
%
% Inputs
%  ax    - Axes object
%  pos   - (Optional) [x,y,w,h] in normalized values relative to figure
%                       (ax.Parent) for where the rectangle (square) that
%                       completely bounds the ellipse (circle) will go.
%  varargin - Any annotation Ellipse 'Name',value pairs.
%
% Output
%  h     - Annotation ellipse object
%
% See also: main.m

h = annotation(fig,...
   'ellipse',pos,...
   'LineWidth',3,...
   'LineStyle',':',...
   'EdgeColor',[0.65 0.65 0.65],...
   'Tag','Unit Circle',...
   varargin{:});

end
