function [b,j] = addBone(part,boneName,jointName)
%ADDBONE Add rigid body (bone) with joint to the robot model
%
%   [b,j] = addBone(part,boneName,jointName);
%
% Inputs
%   robot - rigidBodyTree or rigidBody object
%   boneName - String or char: name of the Bone enumeration
%   jointName - String or char: name of the Joint enumeration
%
% Output
%   b - (Bone): rigidBody object that is added
%   j - (Joint): rigidBodyJoint object that is added
%
% See also: main.m, Content

boneObj = Bone.(boneName);
jointObj = Joint.(jointName);

b = rigidBody(boneObj.name);
j = rigidBodyJoint(jointObj.name,jointObj.type);
j.HomePosition = jointObj.home;
setFixedTransform(j,trvec2tform(boneObj.length * jointObj.axis));
b.Joint = j;
addBody(part,b,'Shoulder');

end