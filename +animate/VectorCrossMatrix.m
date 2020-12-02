function R = VectorCrossMatrix (r)
%VECTORCROSSMATRIX Return the cross matrix R from 3-element vector `r`
%
%  R = animate.VectorCrossMatrix(r);
%
% Inputs
%  r - 3-element vector
%
% Output
%  R - Cross-matrix (3 x 3 matrix)
%     
%  Example:
%     Let a = [4; -2; 1];
%         b = [1; -1; 3];
%
%  To take their cross product, I can use:
%     c = cross(a,b,1);
%
%  In this case, it is better to do it using the built-in function.
%
%  However, suppose that I want to get the cross product of a bunch of
%  vectors `B` with a:
%  ```
%  B = [1:100000; 2:100001; 3:100002]; % Don't include in `tic` call
%  tic; 
%  C = cross(repmat(a,1,100000),B,1);
%  toc;
%  >> Elapsed time is ~0.0032 to ~0.0035 seconds.
%  ```
%
%  Then instead of replicating A and re-computing multiple
%  times in the `cross` built-in, we use:
%
%  ```
%  tic;
%  A = animate.VectorCrossMatrix(a);
%  C = A * B;
%  toc;
%  >> Elapsed time is ~0.0014 to ~0.0016 seconds.
%  ```
%
%  Note that the first call will be different as Matlab is compiled at
%  run-time on the first call but thereafter will be significantly faster
%  in the second case. Increasing the order of magnitude by another factor
%  of ten, the speed saving increases from roughly 2-3 fold to 4-fold.
%  Increasing the size of the array further means that the amount of data
%  loaded into memory with the two giant arrays becomes non-trivial. So we
%  can see that this strategy is helpful as our arrays are becoming larger.
%
%  https://en.wikipedia.org/wiki/Cross_product#Conversion_to_matrix_multiplication
%
% See also: Contents, main.m

R = [0,     -r(3),    r(2);
     r(3),     0,    -r(1);
    -r(2),   r(1),      0];
end