close all force;

% Set parameters
ISO_START   =  3.5;
ISO_FINISH  = -3.5;
ISO_STEP    = -0.05;
VIEW = [35 17];
DEPTH = 10; % X limit is [0, DEPTH]
FIELD = 3.5; % Z, Y amplitude for axes limits

% Configure containers
fig = figure('Name','Patch Flow Animation','Color','w',...
   'Units','Normalized','Position',[0.35  0.36  0.51  0.55]);
ax = axes(fig,'NextPlot','add','View',VIEW,'XColor','k',...
   'YColor','k','FontName','Arial');
xlabel(ax,'X','FontName','Arial','Color','k','FontSize',18); 
ylabel(ax,'Y','FontName','Arial','Color','k','FontSize',18); 
zlabel(ax,'Z','FontName','Arial','Color','k','FontSize',18); 
axis(ax,'tight'); 

% Initialize patch object
[x,y,z,V] = flow; % "Fluid flow" function
[faces,verts] = isosurface(x,y,z,V,ISO_START);
p = patch(ax,...
   'Vertices',verts,...
   'Faces',faces,...
   'FaceColor','red',...
   'EdgeColor','none',...
   'AmbientStrength',0.45,...
   'DiffuseStrength',0.65,...
   'FaceAlpha',0.35,...
   'SpecularStrength',0.975,...
   'FaceLighting','gouraud',...
   'SpecularExponent',5); 
isonormals(x,y,z,V,p); % Update patch object vertex normals
xlim(ax,[0   DEPTH]);
ylim(ax,[-FIELD FIELD]);
zlim(ax,[-FIELD FIELD]);

% Configure lighting
lgt = camlight(ax,'left');
lgt.Color = [1 1 1];
lighting(ax,'gouraud');

vec = ISO_START:ISO_STEP:ISO_FINISH;
theta = linspace(0,2.*pi,numel(vec));

idx = 0;
for iso_level = vec
   idx = idx + 1;
   [faces,verts] = isosurface(x,y,z,V,iso_level);
   set(p,'Faces',faces,'Vertices',verts);
   isonormals(x,y,z,V,p); % Update patch object vertex normals
   xlim(ax,[0   DEPTH]);
   ylim(ax,[-FIELD FIELD]);
   zlim(ax,[-FIELD FIELD]);
   lgt.Position = [cos(theta(idx)), -cos(theta(idx))*FIELD, sin(theta(idx))*FIELD];
   drawnow;
end