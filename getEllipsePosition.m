function pos = getEllipsePosition(ax)
%GETELLIPSEPOSITION Returns ellipse position based on axes properties
%
%  pos = getEllipsePosition(ax);
%
% Inputs
%  ax - Axes to base position on
%
% Output
%  pos - [x y w h] vector for ellipse position
%
% See also: Contents, main.m, addCircle, makeAxes

dx = ((-1 - ax.XLim(1))/diff(ax.XLim))*ax.InnerPosition(3);
dy = ((-1 - ax.YLim(1))/diff(ax.YLim))*ax.InnerPosition(4);
pos = [ax.InnerPosition(1)+dx,...
       ax.InnerPosition(2)+dy,...
       ax.InnerPosition(3)-2*dx,...
       ax.InnerPosition(4)-2*dy];

end