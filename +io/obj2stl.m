function fname_out = obj2stl(fname,varargin)
%OBJ2STL Convert *.obj to *.stl
%
%  io.obj2stl(); --> Prompts for file with dialog box
%  io.obj2stl(fname);
%  fname_out = io.orb2stl(fname,'Name',value,...);
%
% Inputs
%  fname - Name of *.obj file to convert. If not supplied, or given as an
%           empty character ('') -- for example if you want to supply other
%           optional keyword arguments via varargin, then this will create
%           a popup prompt to select the file.
%           -> Can be supplied as cell array or array of strings; 
%  varargin - Keyword 'Name',value pairs
%              * 'Alpha': [0 - 1] double/single or [0 - 255] int, opacity
%                    (1 is opaque; also 1 is default)
%              * 'AmbientStrength': [0 - 1] double/single or [0 - 255] int,
%                    Strength of ambient light (default: 0.3)
%              * 'DiffuseStrength': [0 - 1] double/single or [0 - 255] int,
%                    Strength of diffuse light (default: 0.6)
%              * 'FaceColor': [r, g, b] 
%                 -> Either given as rgb triple ([0 - 1] if double or
%                    single, [0 - 255] if int), or as color character or
%                    string (e.g. 'k' or "red"). Can have additional "rows"
%                    of the array that each correspond to a unique FILE
%                    (currently, all faces within a file are written as
%                     homogeneously colored unless the 'Mode' | 'binary'
%                     option is invoked, in which case a different color
%                     can be used for each face).
%              * 'Force' : Force overwrite if set to true (default: false)
%                 -> Applies if the output filename already exists,
%                 otherwise if set to false a dialog will popup querying
%                 the user if they want to delete the existing file or not.
%              * 'MaxFaces' : See 'Mode' (only applies for 'hybrid'
%                                default)
%              * 'Mode' : 'hybrid' (def) | 'ascii' | 'binary'
%                 -> 'hybrid' checks for `MaxFaces`, writing ascii if file
%                       is smaller than that threshold count or otherwise
%                       using binary since it is more efficient
%              * 'OutputFolder': (def: 'data/meshes') character array denoting the
%                       full or relative path to the desired output
%                       location to collect the *.stl files
%              * 'OutputName': (def: '') if empty, it just uses the input
%                       name but changes the extension to .stl.
%                       Alternatively, this can be provided if the output
%                       name of the file should be changed.
%              * 'SpecularStrength': [0 - 1] double/single or [0 - 255] int,
%                    Strength of specular reflection (default: 0.9)
%              * 'Title': (def: '') Header text (max 32 chars) written to 
%                                   the STL file. A tag that is 48
%                                   characters long is always automatically
%                                   appended that includes this script and
%                                   stlwrite.m as generating the file, as
%                                   well as the time at which the file was
%                                   generated.
%              * 'Triangulation': (def: 'delaunay') Method for
%                                   triangulating gridded data. Options are
%                                   'delaunay' (def) | 'f' | 'b' | 'x'
%                                   -> See io.stlwrite for details.
%
% Output
%  fname_out - Name of output file
%
% See also: Contents, main.m, io.readObj, io.stlwrite

% Handle IO
if (nargin < 1) || isempty(fname)
   [f,p] = uigetfile({'*.obj','Object Files';...
                      '*.*','Any File Type'},...        % filter
                      'Select stl file to convert',...  % dialog title
                      '../ModelFactory/data/meshes',... % default location
                      'Multiselect','on');
   if ~iscell(f)
      if f == 0
         disp('No file selected. Script canceled.');
         return;
      else
         fname = string(fullfile(p,f));
      end
   else
      fname = strings(numel(f),1);
      for ii = 1:numel(f)
         fname(ii) = fullfile(p,f{ii});
      end
   end
   
elseif ischar(fname)
   fname = string(fname);
elseif iscell(fname)
   fname = string(fname);
end

[p,f] = fileparts(fname);
fname = fullfile(p,f);

% Handle parameters
pars = struct;
pars.Alpha     = 1;
pars.AmbientStrength = 0.3;
pars.DiffuseStrength = 0.6;
pars.FaceColor = [0 0 0];
pars.Force = false;
pars.HasCustomTitle = false;
pars.MaxFaces = 100000; % For 100k faces, approx filesize of 25 MB; typical output is maybe 3k faces and ~700 KB.
pars.Mode = 'hybrid'; % 'hybrid' | 'ascii' | 'binary'
pars.OutputFolder = fullfile(pwd,'data','meshes');
pars.OutputName = '';
pars.SpecularStrength = 0.9;
pars.Title = tagTitle();
pars.Triangulation = 'delaunay';
fn = fieldnames(pars);
if numel(varargin) > 0
   if isstruct(varargin{1})
      pars = varargin{1};
      varargin(1) = [];
   end
end

for iV = 1:2:numel(varargin)
   idx = strcmpi(fn,varargin{iV});
   if sum(idx) == 1
      if strcmpi(varargin{iV},'Title')
         pars.HasCustomTitle = true;         
      end
      pars.(fn{idx}) = varargin{iV+1};
   end
end

if numel(fname) > 1
   fname_out = strings(size(fname));
   if isempty(pars.OutputName)
      [~,pars.OutputName,~] = fileparts(fname);
   else
      if numel(pars.OutputName) ~= numel(fname)
         error('`OutputName` must contain same number of elements as number of input files.');
      end
   end
   if numel(pars.Title)==1
      pars.Title = repmat(pars.Title,numel(fname),1);
   end
   if ~iscell(pars.FaceColor)
      if size(pars.FaceColor,1)==numel(fname)
         pars.FaceColor = mat2cell(pars.FaceColor,ones(1,numel(fname)),3);
      else
         pars.FaceColor = repmat({pars.FaceColor},numel(fname),1);
      end
   end
   for ii = 1:numel(fname)
      fname_out(ii) = io.obj2stl(fname(ii),...
         'Alpha',pars.Alpha,...
         'AmbientStrength',pars.AmbientStrength,...
         'DiffuseStrength',pars.DiffuseStrength,...
         'FaceColor',pars.FaceColor{ii},...
         'Force',pars.Force,...
         'HasCustomTitle',pars.HasCustomTitle,...
         'MaxFaces',pars.MaxFaces,...
         'Mode',pars.Mode,...
         'OutputFolder',pars.OutputFolder,...
         'OutputName',pars.OutputName(ii),...
         'SpecularStrength',pars.SpecularStrength,...
         'Title',pars.Title(ii),...
         'Triangulation',pars.Triangulation);
   end
   return;
else
   if isempty(pars.OutputName)
      [~,pars.OutputName,~] = fileparts(fname);
   end
   if pars.HasCustomTitle
      pars.Title = tagTitle(pars.Title);
   end
end

fname_in = strcat(fname,".obj");
tic;
fprintf(1,'\n->\tReading <strong>INPUT</strong>: "%s"...',fname_in);
obj = io.readObj(fname_in);
fprintf(1,'complete (%5.2f sec)\n',toc);

if exist(pars.OutputFolder,'dir')==0
   mkdir(pars.OutputFolder);
end

tic;
ff = strcat(pars.OutputName,".stl");
fname_out = fullfile(pars.OutputFolder,ff);
if (exist(fname_out,'file')~=0) && ~pars.Force
   msg = questdlg(sprintf('%s already exists. Do you want to overwrite it?',ff),...
      'Overwite existing file?','Yes');
   if ~strcmpi(msg,'Yes')
      fprintf(1,'\t->\tCanceled export of %s (file already exists)\n',fname_out);
      return;  
   else
      delete(fname_out);
   end
end

switch lower(pars.Mode)
   case 'hybrid'
      if size(obj.f.v,1) < pars.MaxFaces
         Mode = 'ascii';
      else
         Mode = 'binary';
      end
   case 'ascii'
      % do nothing
      Mode = 'ascii';
   case 'binary'
      % do nothing
      Mode = 'binary';
   otherwise
      error('Unexpected save "Mode" value: "<strong>%s</strong>"',pars.Mode);
end

fprintf(1,'\n->\tSaving <strong>OUTPUT</strong>: "%s.stl" (%s -- %s) ...',...
   fname_out,Mode,pars.Triangulation);
if size(pars.FaceColor,1)~=size(obj.f.v,1)
   face_col = repmat(pars.FaceColor(1,:),size(obj.f.v,1),1);
else
   face_col = pars.FaceColor;
end
str = addHeaderProperties(pars.Title,face_col(1,:),...
   pars.Alpha,...
   pars.DiffuseStrength,...
   pars.SpecularStrength,...
   pars.AmbientStrength);
io.stlwrite(fname_out,obj.f.v,obj.v,...
   'FACECOLOR',face_col,...
   'MODE',char(Mode),...
   'TITLE',char(str), ...
   'TRIANGULATION',char(pars.Triangulation));
fprintf(1,'complete (%5.2f sec)\n',toc);

% Helper functions
   function out = tagTitle(in)
      if nargin < 1
         in = 'Untitled';
      else
         in = char(in);
         if numel(in) > 56
            in = in(1:56);
            warning(['Header can be 56 characters maximum ' ...
               '(COLOR and MATERIAL tags are included automatically). ' ...
               'Truncated custom Title to: <strong>"%s"</strong>'],in);
         end
      end
      out = string(in);
   end

   function out = addHeaderProperties(in,color,alpha,diffStr,specStr,ambStr)
      [RGBA,DSL] = col2ascii(color,alpha,diffStr,specStr,ambStr);
      out = sprintf('%s COLOR=%u%u%u%u,MATERIAL=%u%u%u%u',in,RGBA,DSL);
   end

   function [RGBA,DSL] = col2ascii(color,a,d,s,l)
      switch class(color)
         case {'char','string'}
            RGB = uint16(round(utils.color2Num(color)));
         case {'double','single'} % Expected in range [0, 1]
            RGB = uint16(round(color*255)); 
         case {'uint16','int16'} % Expected in range [0, 255]
            RGB = uint16(color);
         otherwise
            error('Unexpected FaceColor type: %s',class(color));
      end
      
      [A,D,S,L] = map2byte(a,d,s,l);
      % Bytes are: 
      %     Red|Green|Blue|Alpha,
      %  for COLOR=RGBA
      RGBA = [RGB, A];
      
      
      % Bytes are: 
      %    Diffuse Reflection|Specular Highlight|Ambient Light, 
      %  for MATERIAL=DSL
      DSL = [D,S,L];
   end

   function varargout=map2byte(varargin)
      varargout = cell(size(varargin));
      for vv = 1:numel(varargin)
         switch class(varargin{vv})
            case {'single','double'}
               varargout{vv} = uint16(round(varargin{vv} * 255));
            otherwise
               varargout{vv} = uint16(varargin{vv});
         end
      end
   end

end