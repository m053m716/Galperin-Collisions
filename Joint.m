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
   end
   
   methods
      function obj = Joint(id,name,type,color,limits,home,axis,parent)
         %JOINT Constructor for simple class to keep track of joint properties
         %
         %  obj = Joint(id,name,type,color,limits,home,axis,parent);
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
      end
   end
   
   enumeration
      Shoulder_Horizontal_Rotator      (2,"Shoulder_Horizontal_Rotator","revolute",[0.35,0.35,0.35],[-pi/6, pi/6],0,[1 0 0],"Shoulder_Frontal_Link")
      Shoulder_Frontal_Rotator         (4,"Shoulder_Frontal_Rotator","revolute",[0.35,0.35,0.35],[-pi, pi],-pi,[0 1 0],"Shoulder_Sagittal_Link")
      Shoulder_Sagittal_Rotator        (6,"Shoulder_Sagittal_Rotator","revolute",[0.35,0.35,0.35],[0, pi],pi/3,[0 0 1],"Humerus")
      Elbow_Flexion_Rotator            (8,"Elbow_Flexion_Rotator","revolute",[0.35,0.35,0.35],[0 5*pi/6],pi/6,[1 0 0],"Radius_Link")
      Elbow_Supination_Rotator         (10,"Elbow_Supination_Rotator","revolute",[0.35,0.35,0.35],[0, pi],0,[0 1 0],"Radius")
      Wrist_Flexion_Rotator            (12,"Wrist_Flexion_Rotator","revolute",[0.35,0.35,0.35],[0 2*pi/3],pi/2,[0 0 1],"Carpus")
      CMC_I_Wiggle                     (14,"CMC_I_Wiggle","revolute",[0.35,0.35,0.35],[pi/6  pi/3],pi/4,[cos(5*pi/4) sin(5*pi/4) 1],"CMC_I_Link")
      CMC_I_Rotator                    (16,"CMC_I_Rotator","revolute",[0.35,0.35,0.35],[-pi/6 pi/6],-pi/9,[1 0 0],"Metacarpus_I")
      MCP_I_Swivel                     (18,"MCP_I_Swivel","revolute",[0.35,0.35,0.35],[-pi/6 pi/6],0,[1 0 0],"MCP_I_Link")
%       MCP_I_Rotator                    (20,"MCP_I_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"MCP_I_Link")
%       DIP_I_Rotator                    (22,"DIP_I_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Proximal_Phalanx_I")
%       CMC_II_Wiggle                    (24,"CMC_II_Wiggle","revolute",[0.35,0.35,0.35],[],nan,[],"Carpus")
%       CMC_II_Rotator                   (26,"CMC_II_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"CMC_II_Link")
%       MCP_II_Rotator                   (28,"MCP_II_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Metacarpus_II")
%       PIP_II_Rotator                   (30,"PIP_II_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Proximal_Phalanx_II")
%       DIP_II_Rotator                   (32,"DIP_II_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Medial_Phalanx_II")
%       CMC_III_Wiggle                   (34,"CMC_III_Wiggle","revolute",[0.35,0.35,0.35],[],nan,[],"Carpus")
%       CMC_III_Rotator                  (36,"CMC_III_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"CMC_III_Link")
%       MCP_III_Rotator                  (38,"MCP_III_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Metacarpus_III")
%       PIP_III_Rotator                  (40,"PIP_III_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Proximal_Phalanx_III")
%       DIP_III_Rotator                  (42,"DIP_III_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Medial_Phalanx_III")
%       CMC_IV_Wiggle                    (44,"CMC_IV_Wiggle","revolute",[0.35,0.35,0.35],[],nan,[],"Carpus")
%       CMC_IV_Rotator                   (46,"CMC_IV_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"CMC_IV_Link")
%       MCP_IV_Rotator                   (48,"MCP_IV_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"CMC_IV_Link")
%       PIP_IV_Rotator                   (50,"PIP_IV_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Proximal_Phalanx_IV")
%       DIP_IV_Rotator                   (52,"DIP_IV_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Medial_Phalanx_IV")
%       CMC_V_Wiggle                     (54,"CMC_V_Wiggle","revolute",[0.35,0.35,0.35],[],nan,[],"CMC_V_Link")
%       CMC_V_Rotator                    (56,"CMC_V_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Proximal_Phalanx_V")
%       MCP_V_Rotator                    (58,"MCP_V_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"Medial_Phalanx_V")
%       PIP_V_Rotator                    (60,"PIP_V_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"")
%       DIP_V_Rotator                    (62,"DIP_V_Rotator","revolute",[0.35,0.35,0.35],[],nan,[],"")
   end
   
end