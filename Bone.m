classdef Bone
   %BONE Simple class to store properties of bones
   
   properties
      id       (1,1)  uint16           % Numeric identifier of segment
      name     (1,1)  string           % Name of segment
      bodypart (1,1)  string           % What body part does it belong to
      color    (1,3)  double           % What color is it?
      length   (1,1)  double           % Length (meters)
      mass     (1,1)  double           % Expected mass (kilograms)
      joint    (1,1)  string           % "Parent" joint name
   end
   
   methods
      function obj = Bone(id,name,length,mass,bodypart,color,joint)
         %BONE Constructor for simple class to store bone properties
         %
         %     obj = Bone(id,name,length,mass,bodypart,color,joint);
         %
         % Inputs
         %  id:         Numeric identifier
         %  name:       String name of bone segment
         %  length:     How long is it? (meters)
         %  mass:       How massive is it? (kilograms)
         %  bodypart:   What body part does this bone belong to?
         %  color:      What color is it?
         %  joint:      Name of "child" joint (or "Fixed")
         %
         % Output
         %  obj:        Bone class object for keeping track of bone properties
         %
         % See also: Contents
         
         obj.id = id;
         obj.name = name;
         obj.length = length;
         obj.mass = mass;
         obj.bodypart = bodypart;
         obj.color = color;
         obj.joint = joint;
      end
   end
   
   enumeration
      Shoulder_Horizontal_Link 	 (1,"Shoulder_Horizontal_Link",0.002,0.00158,"Shoulder",[0.2 0.2 0.2],"Fixed")
      Shoulder_Frontal_Link      (3,"Shoulder_Frontal_Link",0.002,0.00158,"Shoulder",[0.2 0.2 0.2],"Shoulder_Horizontal_Rotator")
      Shoulder_Sagittal_Link     (5,"Shoulder_Sagittal_Link",0.002,0.00158,"Shoulder",[0.2 0.2 0.2],"Shoulder_Frontal_Rotator")
      Humerus                    (7,"Humerus",0.330,0.26027,"Proximal_Forelimb",[0.2 0.2 0.8],"Shoulder_Sagittal_Rotator")
      Radius_Link                (9,"Radius_Link",0.002,0.00158,"Proximal_Forelimb",[0.2 0.2 0.2],"Elbow_Flexion_Rotator")
      Radius                     (11,"Radius",0.308,0.18,"Distal_Forelimb",[0.3 0.3 0.9],"Elbow_Supination_Rotator")
      Carpus                     (13,"Carpals",0.027,0.00385,"Hand",[0.1 0.1 1.0],"Wrist_Rotator")
      CMC_I_Link                 (15,"CMC_I_Link",0.002,0.00029,"Thumb",[0.2 0.2 0.2],"CMC_I_Wiggle")
      Metacarpus_I               (17,"Metacarpus_I",0.038,0.00542,"Thumb",[0.7 0.1 0.1],"CMC_I_Rotator")
      MCP_I_Link                 (19,"MCP_I_Link",0.002,0.00029,"Thumb",[0.2 0.2 0.2],"MCP_I_Swivel")
      Proximal_Phalanx_I         (21,"Proximal_Phalanx_I",0.028,0.00399,"Thumb",[0.5 0.2 0.2],"MCP_I_Rotator")
      Distal_Phalanx_I           (23,"Distal_Phalanx_I",0.015,0.00214,"Thumb",[0.6 0.3 0.3],"DIP_I_Rotator")
      CMC_II_Link                (25,"CMC_II_Link",0.002,0.00029,"Index_Finger",[0.2 0.2 0.2],"CMC_II_Wiggle")
      Metacarpus_II              (27,"Metacarpus_II",0.058,0.008265,"Index_Finger",[0.7 0.4 0.1],"CMC_II_Rotator")
      Proximal_Phalanx_II        (29,"Proximal_Phalanx_II",0.040,0.00570,"Index_Finger",[0.6 0.5 0.1],"MCP_II_Rotator")
      Medial_Phalanx_II          (31,"Medial_Phalanx_II",0.030,0.00428,"Index_Finger",[0.8 0.3 0.1],"PIP_II_Rotator")
      Distal_Phalanx_II          (33,"Distal_Phalanx_II",0.020,0.00285,"Index_Finger",[0.75 0.45 0.1],"DIP_II_Rotator")
      CMC_III_Link               (35,"CMC_III_Link",0.002,0.00029,"Middle_Finger",[0.2 0.2 0.2],"CMC_III_Wiggle")
      Metacarpus_III             (37,"Metacarpus_III",0.063,0.008978,"Middle_Finger",[0.8 0.8 0.1],"CMC_III_Rotator")
      Proximal_Phalanx_III       (39,"Proximal_Phalanx_III",0.042,0.00599,"Middle_Finger",[0.7 0.7 0.2],"MCP_III_Rotator")
      Medial_Phalanx_III         (41,"Medial_Phalanx_III",0.030,0.00428,"Middle_Finger",[0.5 0.8 0.1],"PIP_III_Rotator")
      Distal_Phalanx_III         (43,"Distal_Phalanx_III",0.020,0.00285,"Middle_Finger",[0.8 0.5 0.1],"DIP_III_Rotator")
      CMC_IV_Link                (45,"CMC_IV_Link",0.002,0.00029,"Ring_Finger",[0.2 0.2 0.2],"CMC_IV_Wiggle")
      Metacarpus_IV              (47,"Metacarpus_IV",0.058,0.008265,"Ring_Finger",[0.2 0.7 0.1],"CMC_IV_Rotator")
      Proximal_Phalanx_IV        (49,"Proximal_Phalanx_IV",0.040,0.00570,"Ring_Finger",[0.25 0.8 0.1],"MCP_IV_Rotator")
      Medial_Phalanx_IV          (51,"Medial_Phalanx_IV",0.030,0.00428,"Ring_Finger",[0.3 0.85 0.1],"PIP_IV_Rotator")
      Distal_Phalanx_IV          (53,"Distal_Phalanx_IV",0.020,0.00285,"Ring_Finger",[0.35 0.90 0.1],"DIP_IV_Rotator")
      CMC_V_Link                 (55,"CMC_V_Link",0.002,0.00029,"Pinky_Finger",[0.2 0.2 0.2],"CMC_V_Wiggle")
      Metacarpus_V               (57,"Metacarpus_V",0.048,0.00684,"Pinky_Finger",[0.8 0.3 0.8],"CMC_V_Rotator")
      Proximal_Phalanx           (59,"Proximal_Phalanx_V",0.030,0.00428,"Pinky_Finger",[0.9 0.2 0.9],"MCP_V_Rotator")
      Medial_Phalanx_V           (61,"Medial_Phalanx_V",0.025,0.00356,"Pinky_Finger",[1.0 0.3 1.0],"PIP_V_Rotator")
      Distal_Phalanx_V           (63,"Distal_Phalanx_V",0.020,0.00285,"Pinky_Finger",[0.9 0.25 0.7],"DIP_V_Rotator")
   end
end