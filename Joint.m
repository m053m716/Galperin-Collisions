classdef Joint
   %JOINT Simple class to store properties of joints
   
   properties
      id             (1,1) uint16 % Numeric identifier
      name           (1,1) string % Name of joint
      type           (1,1) string % Type of joint ("fixed" | "revolute")
      color          (1,3) double % Color associated with joint
      limits         (1,2) double % What is the range of motion [lower, upper] (radians)?
      home           (1,1) double % What is the "home" position at rest (radians)?
      axis           (1,3) double % What is the orientation of the axis that it revolves about?
      parent         (1,1) string % Specifies which bone it is associated with
      attachment     (1,1) string % Specifies which bone it attaches to
   end
   
   methods
      function obj = Joint(id,name,type,color,limits,home,axis,parent,attachment)
         %JOINT Constructor for simple class to keep track of joint properties
         %
         %  obj = Joint(id,name,type,color,limits,home,axis,parent,attachment);
         %
         % See also: Content
         
         obj.id = id;
         obj.name = name;
         obj.type = type;
         obj.color = color;
         obj.limits = limits;
         obj.home = home;
         obj.axis = axis;
         obj.parent = parent;
         obj.attachment = attachment;
      end
   end
   
   enumeration
      Shoulder_Horizontal_Rotator      (2,"Shoulder_Horizontal_Rotator","revolute",[0.35,0.35,0.35],[-pi/6, pi/6],0,[1 0 0],"Shoulder_Horizontal_Link","base")
%       Shoulder_Frontal_Rotator
%       Shoulder_Sagittal_Rotator
%       Elbow
%       Wrist
%       CMC_I_Wiggle
%       CMC_I_Rotator
%       MCP_I_Swivel
%       MCP_I_Rotator
%       DIP_I_Rotator
%       CMC_II_Wiggle
%       CMC_II_Rotator
%       MCP_II_Rotator
%       PIP_II_Rotator
%       DIP_II_Rotator
%       CMC_III_Wiggle
%       CMC_III_Rotator
%       MCP_III_Rotator
%       PIP_III_Rotator
%       DIP_III_Rotator
%       CMC_IV_Wiggle
%       CMC_IV_Rotator
%       MCP_IV_Rotator
%       PIP_IV_Rotator
%       DIP_IV_Rotator
%       CMC_V_Wiggle
%       CMC_V_Rotator
%       MCP_V_Rotator
%       PIP_V_Rotator
%       DIP_V_Rotator
   end
   
end