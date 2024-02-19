function [margLike] = LF(mu,x,A,B1,D1,B2,D2)
%LF Summary of this function goes here
%   Detailed explanation goes here
U = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
U(1:size(A,1),1:size(A,2)) =A;
U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu(1);
U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu(1);

U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu(2);
U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu(2);

% Code below includes a column vector containing the original coordinates.
temp = zeros(size(U,1),1);
temp(1:size(x,2),1) = x';
U = [U,temp];
clear temp

[R] = qr(U);
% R = qr(R);
%Now that we have our Q matrix, we need to separate it into its components:
%g represents a scalar at the bottom right of the matrix.
%\textb{g} represents the column from the start of the matrix to the scalar
%Is the top left element of the triangular matrix zero? 
%The total matrix isn't square so it's hard to tell. Assuming non-zero:
w = size(R,2);
G = R(1:w-1,1:w-1);
g = R(w,w);
% gB = R(1:w-1,w);

%Now that Q has been separated, we need to construct the marginal
%likelihood function;
Gval = 0;
for i = 1:w-1
%     G(i,i)
	Gval = Gval + log(abs(G(i,i)));
end
margLike = -1*(-1*(-1*size(A,1)*log(g^2) + size(A,2)*log(mu(1)^2) + size(B1,2)*log(mu(2)^2) - 2*Gval));

end

