%At this point, we have B1,B2,D1 and D2 so we can use these to construct the array.
%We'll use symbolic placeholders for the x coordinates as well as the variance values.
%Are the values of mue arrays or scalar? They look to be scalar in the paper.


% M2 = size(f1,2);
% M1 = size(theta,2);
% N = size(X,2)/2;

%What is the best way to construct this matrix?
%There are 5 different data based array sections so we'll need to add those on.

%Do we want to pre-allocate?: What is the total size of the array?
%Col: size(A,2) + size(B1,2) + size(B2,2) + 1;
%Row: size(A,1) + size(B1,1) + size(B2,1)

%We need the syms syntax here to incorporate the mu values as well as the x coordinates.

%We have two versions, this first one concacts the new x coordinates, but
%has the wrong dimensions as written in the paper:
% U = sym(zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2) + size(x,2)));
% U(1:size(A,1),1:size(A,2)) =A;
% syms mu1 mu2
% U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
% U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;
% 
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu2;
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu2;
% 
% U(1,end-(2*N-1):end) = x;

% U = sym(zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2)));
% U(1:size(A,1),1:size(A,2)) =A;
% syms mu1 mu2
% U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
% U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;
% 
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu2;
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu2;
% 
% % Code below includes a column vector containing the original coordinates.
% temp = zeros(size(U,1),1);
% temp(1:size(x,2),1) = x';
% U = [U,temp];
% clear temp

%This second one doesn't concact the coordinates, not following what was
%written to be transformed in the paper, but matches with the dimensions
%talked about:
U = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
U(1:size(A,1),1:size(A,2)) =A;
U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1*mu1;
U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1*mu1;

U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2*mu2;
U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2*mu2;

% Code below includes a column vector containing the original coordinates.
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

%At the point, we now have the marginal likelihood function. The next step
%is to maximise the values to attempt to identify the variance values.
%Perhaps mupad will have an SAT function to maximise with two variables
%simultaneously.

%Assuming we have the likelihood function with all variables other than the
%Theta solved, We then need to minimise the likelihood function by finding
%the appropriate values of the lattice positions

%The hyper-hyper-parameter f2 needs to be determined by maximising the
%function. We'll take it back to the original untransformed likelihood
%function since all we need to do is maximise a 2norm.

% H = norm(    U(:,end) - U(:,1:end-1)*[theta,f1,f2]  );
%Code to maximise H by varying the two valus in f2

%Now we need to minimise H to find the values of theta and f1 We're putting
%a lot of weight on a theoretical function but we'll have to think about it
%later.

%Theoretically at this point,  we have the new coordinates of the lattice
%positions. There are still a few things we have left to do. With the new
%lattice positions, a comparison of the two will allow us to produce the
%deformation strain tensors.

%The deformation strain tensor represents the change in the relative
%position of the lattice points.



