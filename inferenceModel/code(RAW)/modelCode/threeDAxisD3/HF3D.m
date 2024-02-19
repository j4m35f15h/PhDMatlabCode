function [H] = HF3D(temp,U,lattice,theta,f1,f2)

%Not quite true U, no coordinates appended to side.
 N = size(lattice,2)/3;
% U = zeros(size(A,1) +size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
% U(1:size(A,1),1:size(A,2)) =A;
% U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
% U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;
% 
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu2;
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu2;

% Code below includes a column vector containing the original coordinates.
% temp = zeros(size(U,1),1);
% temp(1:size(x,2),1) = x';

H = norm( temp - U*[lattice(theta)';lattice(theta + N)';lattice(theta + 2*N)';...
                  lattice(f1)';lattice(f1 + N)';lattice(f1 + 2*N)';...
                  lattice(f2)';lattice(f2 + N)';lattice(f2 + 2*N)']);
% H = norm( temp - U*[lattice(theta)';lattice(theta + N)';lattice(theta + 2*N)';...
%                   lattice(f1)';lattice(f1 + N)';lattice(f1 + 2*N)';...
%                   ]);
end

