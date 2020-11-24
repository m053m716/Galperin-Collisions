% MASS-COLLISIONS_2020_SIM Project for simulating elastic collision counts
%
% Packages
%   +geom                   - Package containing basic geometric relational equations.
%   +io                     - Basic utility input/output/saving functions
%   +physics                - Package for computing basic equations of simple Newtonian physics of motion.
%   +utils                  - Package containing miscellaneous utilities for this project.
%
% Functions
%   addCircle               - Add circle to axes (really to its Parent figure)
%   addLine                 - Add a line to the axes
%   circleSaw               - Saw wave constrained by unit-circle
%   circleSaw2              - Saw wave constrained by unit-circle, more efficient?
%   ellipse_coefs           - Returns corresponding polynomial coefficients
%   getEllipsePosition      - Returns ellipse position based on axes properties
%   ideal_elastic_collision - Compute final velocities for ideal elastic collision
%   main                    - Main outline for running simulation
%   makeAxes                - Create figure and axes objects for graphics
%   numCollisions           - Returns total number of collisions based on the masses
%   plotPhaseSpace          - Plot circle "Sawtooth" phase space
%   run_collision           - Compute final velocities for ideal elastic collision
%   tabulate_num_collisions - Compute N and THETA by iterative tabulation
