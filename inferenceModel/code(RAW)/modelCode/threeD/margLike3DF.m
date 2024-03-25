function [margLike] = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2)
%LATTICESOLVE3DF returns the value of the marginal likelihood function for
%a given pair of relative variance values, mu1 and mu2. Uses the formula
%derived in Morishita et al. 2014.

%Following the definition of U in Eqn 14
U = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
U(1:size(A,1),1:size(A,2)) =A;

U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1*mu1;
U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1*mu1;

U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2*mu2;
U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2*mu2;

%Concatenate the coordinate onto the end of the array
temp = zeros(size(U,1),1);
temp(1:size(x,2),1) = x';
U = [U,temp];
clear temp

%QR decomposition creates the upper right traingular matrix required
[R] = qr(U);

%Obtain variables form different region of the R matrix as seen in Eqn 14
w = size(R,2);
G = R(1:w-1,1:w-1);
g = R(w,w);
gB = R(1:w-1,w);


%Perform the summation in Eqn 16
Gval = 0;
for i = 1:(w-1)
	Gval = Gval + log(abs(G(i,i)));
end

margLike = -2*(size(A,1)/3)*log(g^2) + 2*(size(A,2)/2)*log(mu1^2) + 2*(size(B1,2)/2)*log(mu2^2) - 2*Gval;
end

