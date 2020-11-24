function [u_f, v_f] = run_collision_from_rest(m,M,v_i)
%RUN_COLLISION_FROM_REST Compute final velocities for ideal elastic collision, where one mass starts at rest.
%
%  [u_f, v_f] = run_collision_from_rest(m,M,v_i)
%
% Inputs
%  m   - Mass of small object (kg)
%  M   - Mass of large object (kg)
%  v_i - Initial velocity of slarge mass, just before impact (m/s)
%     
%     Note: if they are going toward eachother, then one must be positive
%              and one negative by convention. 
%
% Output
%  u_f - Final velocity of small mass, just after impact
%  v_f - Final velocity of large mass, just after impact
%
% See also: main.m, tabulate_num_collisions

u_f = finalVelocitySmallMass(m,M,v_i);
v_f = finalVelocityLargeMass(m,M,v_i);

   function v_f = finalVelocityLargeMass(m,M,v_i)
      v_f = (M - m).*v_i./(m + M);
   end

   function u_f = finalVelocitySmallMass(m,M,v_i)
      u_f = 2.*M.*v_i./(m + M);
   end

end