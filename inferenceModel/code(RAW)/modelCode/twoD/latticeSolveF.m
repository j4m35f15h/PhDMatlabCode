function [margLike] = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x)
%LATTICESOLVEF Summary of this function goes here
%   We've found the values of mu1 and mu2 at this point, so now we need to
%   minimise the likelihood function in matrix form to find the new
%   coordinates.

U = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
U(1:size(A,1),1:size(A,2)) =A;
U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;

U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu2;
U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu2;

temp = zeros(size(U,1),1);
temp(1:size(x,2),1) = x';
U = [U,temp];
clear temp

[R] = qr(U);
% R = qr(R);
% 'starting decomposition'
% [R,~] = house_qr(U);
% 'decomposition complete'

%Now that we have our Q matrix, we need to separate it into its components:
%g represents a scalar at the bottom right of the matrix.
%\textb{g} represents the column from the start of the matrix to the scalar
%Is the top left element of the triangular matrix zero? 
%The total matrix isn't square so it's hard to tell. Assuming non-zero:
w = size(R,2);
G = R(1:w-1,1:w-1);
g = R(w,w);
gB = R(1:w-1,w);

%Now that Q has been separated, we need to construct the marginal
%likelihood function;
Gval = 0;
for i = 1:w-1
%     G(i,i)
	Gval = Gval + log(abs(G(i,i)));
end
margLike = -1*size(A,1)*log(g^2) + size(A,2)*log(mu1^2) + size(B1,2)*log(mu2^2) - 2*Gval;
end

