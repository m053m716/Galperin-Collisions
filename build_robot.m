close all force;
clear;
clc;

robot = rigidBodyTree;
robot.BaseName = 'Shoulder';
robot.Gravity = [0 0 9.81];

% First "link" bone in shoulder
boneName = "Shoulder_Horizontal_Link";
jointName = "Shoulder_Horizontal_Rotator";
bone = addBone(robot,boneName,jointName);

% Second "link" bone in shoulder
boneName = "Shoulder_Frontal_Link";
jointName = "Shoulder_Frontal_Rotator";
bone = addBone(bone,boneName,jointName);

% Third "link" bone in shoulder
boneName = "Shoulder_Sagittal_Link";
jointName = "Shoulder_Sagittal_Rotator";
bone = addBone(bone,boneName,jointName);

% Add Elbow flexion 

show(robot);