function [u_f, v_f] = run_collision(m,M,u_i,v_i,verbose)
%RUN_COLLISION Compute final velocities for ideal elastic collision
%
%  [u_f, v_f] = run_collision(m,M,u_i,v_i)
%  [u_f, v_f] = run_collision(m,M,u_i,v_i,verbose)
%
% Inputs
%  m   - Mass of small object (kg)
%  M   - Mass of large object (kg)
%  v_i - Initial velocity of small mass, just before impact (m/s)
%  u_i - Initial velocity of small mass, just before impact (m/s)
%     
%     Note: this is the same as `run_collision_from_rest`, but we simply
%           have to change the relative frame of reference for the two
%           objects so that we can set the velocity of one of the objects
%           to zero from the outset, making the problem much simpler.
%
%  verbose - (Optional) default is false; set true to print debug info to
%              command window.
%
% Output
%  u_f - Final velocity of small mass, just after impact
%  v_f - Final velocity of large mass, just after impact
%
% See also: main.m, tabulate_num_collisions

if nargin < 5
   verbose = false;
end

% Move into relative scale, where speed of u_i is zero.
v_rel_i = v_i - u_i;

[u_rel_f,v_rel_f] = run_collision_from_rest(m,M,v_rel_i);

% Move into absolute "world" scale, after figuring the changes in velocity.
u_f = u_rel_f + u_i;
v_f = v_rel_f + u_i;

if verbose
   utils.printTaggedParameters('COLLISION (RELATIVE)',m,M,u_i,v_i,u_f,v_f);
end

end