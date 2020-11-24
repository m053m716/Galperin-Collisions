function vf = ideal_elastic_collision(M,vi)
%IDEAL_ELASTIC_COLLISION Compute final velocities for ideal elastic collision
%
%  vf = ideal_elastic_collision(M,vi)
%
% Inputs
%  M  - Mass of objects
%  vi - Initial velocity of objects, just before impact
%     
%     Note: if they are going toward eachother, then one must be positive
%              and one negative by convention. 
%
% Output
%  vf - Final velocity objects, just after impact
%
% See also: main.m

if numel(M) ~= numel(vi)
   error('Must have same number of elements in Mass and Velocity vectors');
end

if isrow(M)
   M = M.';
end

if isrow(vi)
   vi = vi.';
end

mstr = sprintf('%10.5f, ',M);
vstr = sprintf('%10.5f, ',vi);

m = system_momentum(M,vi);
e = system_kinetic_energy(M,vi);

k = moments(M,vi);
[~,iChange] = min(k);

fprintf(1,'\n--------------\n\n');
fprintf(1,'System Masses:     <strong>[%s]</strong> (kg)\n',mstr(1:(end-2)));
fprintf(1,'System Velocities: <strong>[%s]</strong> (m/s; just prior to collision)\n',vstr(1:(end-2)));
fprintf(1,'System Momentum:         <strong>%10.5f</strong>    (kg * m/s)\n',m);
fprintf(1,'System Energy:           <strong>%10.5f</strong>    (Joules)\n',e);
fprintf(1,'\n--------------\n');
fprintf(1,'\t\t...Solving...');
fun = @(vf)to_solve(vf,m,e,M);
v0 = vi;
v0(iChange) = -v0(iChange);
opts = optimset(optimset('fsolve'),'Display','off');
vf = fsolve(fun,v0,opts);
fprintf(1,'complete!\n\n');

vstr = sprintf('%10.5f, ',vf);
fprintf(1,'System Velocities: <strong>[%s]</strong> (m/s; just <strong>after</strong> collision)\n',vstr(1:(end-2)));
fprintf(1,'\n--------------\n');

   function k = moments(M,v)
      k = M.*v;
   end

   function m = system_momentum(M,v)
      m = sum(moments(M,v));   
   end

   function e = system_kinetic_energy(M,v)
      e = sum(0.5.*M.*v.^2);
   end


   function c = to_solve(vf,m,e,M)
      c = [... % to equal zero
         system_momentum(M,vf)-m ...
         system_kinetic_energy(M,vf)-e ...
         ];
   end

end