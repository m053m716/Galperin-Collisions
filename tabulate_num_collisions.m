function [N,THETA,u,v,t,p] = tabulate_num_collisions(m,M,U0,V0,D0,verbose)
%TABULATE_NUM_COLLISIONS Compute N and THETA by iterative tabulation
%
%  [N,THETA,u,v,t,p] = tabulate_num_collisions(m,M)
%  [N,THETA,u,v,t,p] = tabulate_num_collisions(m,M,V0)
%
% Inputs
%  m  - The small weight (must be scalar) (kg)
%  M  - The big weight (can be array) (kg)
%  U0 - Initial velocity of small mass (meters/sec)
%  V0 - Initial velocity of large mass (meters/sec)
%  D0 - Initial distance of small mass from the (fixed) wall. (meters)
%  verbose - (Optional) default is false; set true to print debug info to
%              command window.
%
% Output
%  N     - Integer number of collisions the same size as input `m2`
%  THETA - Angle between the two masses when scaled onto unit circle (rad)
%  u     - Velocity of small mass just prior to each collision 
%           (with other mass OR with the wall)
%  v     - Velocity of large mass just prior to each collision of the
%              small mass with either large mass or the wall.
%  t     - Relative time between each collision.
%  p     - Position of LARGE mass at each collision, in 1-D case let the
%           "fixed" wall represent a value of zero, and movement to the
%           right be positive. The large mass starts out moving left
%           (negative value). 
%
% See also: main.m;

if nargin < 3
   U0 = 0;  % (m/s) - initial velocity of small mass
end

if nargin < 4
   V0 = -1; % (m/s)
end

if nargin < 5
   D0 = 10; % (m)
end

if nargin < 6
   verbose = false;
end

if numel(M) > 1
   N = nan(size(M));
   THETA = nan(size(M));
   u = cell(numel(M),1);
   v = cell(numel(M),1);
   t = cell(numel(M),1);
   p = cell(numel(M),1);
   for ii = 1:numel(M)
      [N(ii),THETA(ii),u{ii},v{ii},t{ii},p{ii}] = tabulate_num_collisions(m,M(ii),U0,V0,D0,verbose);
   end
   return;
end

% Start with no collisions. There will be at least one (`flag = true`).
N = 1; 
flag = true;
u   = U0;
v   = V0;
t   = 0;
p   = D0;

tic;
if ~verbose
   fprintf(1,'Computing collisions for <strong>M = %5.2f-kg</strong>...',M);
else
   utils.printIndentedCount(N,61,0,'(INITIAL COLLISION) | ');
end

while flag
   [u(N+1),v(N+1)] = run_collision(m,M,u(N),v(N),verbose); %#ok<*AGROW>
   N = N + 1; % Count (collision) -> it just occurred.
   if verbose
      utils.printIndentedCount(N,31,5,'(COLLISION) | ');
   end
   
   % Is there a wall collision? It depends on velocity of the small mass
   % after the collision.
   if u(N) < 0
      t(N) = -p(N-1)./u(N); % Total time for small mass to travel from large mass to wall.
      p(N) = p(N-1) + t(N).*v(N); % Meanwhile, the large mass continues to travel some distance with constant velocity      
      u(N+1) = -u(N); % Due to wall collision, small mass direction MUST become negative (for simple 1-D model) 
      v(N+1) = v(N); % The large mass continues to move at the same speed since nothing has happened to it yet
      N = N + 1; % Increment counter due to wall collision 
      
      % In the next step, the large mass and small mass are moving toward
      % each other, each with constant speed and starting from some
      % arbitrary distance, p(N-1). The amount of time it will take them to
      % collide can be recovered by taking the relative speed and dividing
      % the total distance traversed by that value.
      if v(N) < u(N)
         t(N) = p(N-1)./(u(N) - v(N));
      else
         flag = false;
         t(N) = inf;
      end
      
      % The place where they collide is obtained by multiplying the total
      % time it takes them to travel that distance by the velocity of the
      % one that is moving to the right (since it starts from zero and
      % doesn't require to add back on the relative starting point). 
      p(N) = t(N).*u(N);
      if verbose
         utils.printIndentedCount(N,31,1,'(WALL) | ');
      end
   else
      flag = false;
      t(N) = inf; % The next collision will never occur
      p(N) = inf; % Since next collision never occurs, mark its location as inf as well.
   end
end

if ~verbose
   fprintf(1,'complete (%5.2f sec)\n',toc);
   fprintf(1,'\t->\tN = %d collisions\n\n',N);
else
   utils.printTaggedParameters('FINAL STATES',m,M,U0,V0,u(end),v(end));
end

THETA = atan(sqrt(m)/sqrt(M));

end