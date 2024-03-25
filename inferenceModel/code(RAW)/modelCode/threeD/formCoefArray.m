function [cArray] = formCoefArray(A,B1,D1,B2,D2,mu1,mu2)

%formCoefArray creates the coefficient array seen in Eqn 13 of Morishita et al. 2014

cArray = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
cArray(1:size(A,1),1:size(A,2)) = A;
cArray(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
cArray(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;

cArray(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu2;
cArray(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu2;


end

