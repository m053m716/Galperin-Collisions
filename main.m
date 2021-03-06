%MAIN Main outline for running simulation
clc; close all; clear;

% Fix the small mass (M1) as "1-kg" equivalent
m   =  1;              % small mass: "kg"
M   = [10,100,1000];   % large mass: "kg" can be scalar or array
U0  =  0;              % small mass initial velocity 
V0  = -1;              % large mass initial velocity
D0  =  2;              % Initial distance from (fixed) WALL

% Define number of collisions (minimum value is 3)
[N,THETA,u,v,t,pos] = tabulate_num_collisions(m,M,U0,V0,D0,false);

% % Make phase plot of "sawtooth" on circle representing collisions
plotPhaseSpace(m,M,U0,V0,N,u,v); % Remove `fig` assignment to auto-save
% fig = plotPhaseSpace(m,M,U0,V0,N,u,v); 

% Play audio corresponding to this
% writeCollisionSounds(t);   % Remove output to auto-write audio to *.wav
% writeCollisionSounds(t,... % Use defaults to specify optional args
%    default.waveform('file'),default.fs(),'low');
% writeCollisionSounds(t,... % Can also specify custom waveforms
%    [-0.75 1 1 1 -0.75],default.fs(),'medium');

[data,fs,tSample] = writeCollisionSounds(t{3},[-0.25 -0.5 -1 1 1 -1 -0.5 -0.25],20000,'low');
[fig,pdata,f,t_f] = plotSeries(tSample,data);

%% Export meshes for model simulation
% Export models for left arm
objFiles = ["D:\MATLAB\Projects\ModelFactory\data\meshes\MK_handL.obj"; ...
            "D:\MATLAB\Projects\ModelFactory\data\meshes\MK_lowerArmL.obj"; ...
            "D:\MATLAB\Projects\ModelFactory\data\meshes\MK_upperArmL.obj"];
objHeaders = ["Simulation Left-Hand";...
              "Simulation Left-Lower-Arm"; ...
              "Simulation Left-Upper-Arm"];
segmentColors = [27 4 12; ... % Left-Hand
                 18 6 10; ... % Left-Arm (Lower)
                 6 10 18 ];   % Left-Arm (Upper)
io.obj2stl(objFiles,'FaceColor',segmentColors./255,'Force',true,'Title',objHeaders);