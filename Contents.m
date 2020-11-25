% MASS-COLLISIONS_2020_SIM Project for simulating elastic collision counts
%
% Packages
%   +default                - Package with "standard" default values.
%   +geom                   - Package containing basic geometric relational equations.
%   +io                     - Basic utility input/output/saving functions
%   +physics                - Package for computing basic equations of simple Newtonian physics of motion.
%   +utils                  - Package containing miscellaneous utilities for this project.
%
% Functions: Graphics
%   addCircle               - Add circle to axes (really to its Parent figure)
%   addLine                 - Add a line to the axes
%   circleSaw               - Saw wave constrained by unit-circle
%   getEllipsePosition      - Returns ellipse position based on axes properties
%   makeAxes                - Create figure and axes objects for graphics
%   plotSeries              - Plot time-series of audio data related to collisions
%   plotPhaseSpace          - Plot circle "Sawtooth" phase space
%
% Functions: Audio
%   writeCollisionSounds    - Make files with "collision sounds" 
%
% Functions: Math
%   getSmoothedRate         - Return smoothed rate for time-series y of noisy impulses
%   run_collision           - Compute final velocities for ideal elastic collision
%   run_collision_from_rest - Compute final velocities for ideal elastic collision, where one mass starts at rest.
%   tabulate_num_collisions - Compute N and THETA by iterative tabulation
%
% Scripts
%   main                    - Main outline for running simulation
