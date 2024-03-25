


U = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
U(1:size(A,1),1:size(A,2)) =A;
U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1*mu1;
U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1*mu1;

U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2*mu2;
U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2*mu2;

% U = zeros(size(A,1) + size(B1,1) ,size(A,2) + size(B1,2) );
% U(1:size(A,1),1:size(A,2)) =A;
% U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1*mu1;
% U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1*mu1;

% U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2*mu2;
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2*mu2;

temp = zeros(size(U,1),1);
temp(1:size(x,2),1) = x';
U = [U,temp];
clear temp

% [R,~] = house_qr(U);
[R] = qr(U);
% [R] = qr(R);

w = size(R,2);
G = R(1:w-1,1:w-1);
g = R(w,w);
gB = R(1:w-1,w);



Gval = 0;
for i = 1:(w-1)
	Gval = Gval + log(abs(G(i,i)));
end
% g = R(1+(w-1)*2/3,1+(w-1)*2/3);
margLike = -2*(size(A,1)/3)*log(g^2) + 2*(size(A,2)/3)*log(mu1^2) + 2*(size(B1,2)/3)*log(mu2^2) - 2*Gval;
% margLike = -2*(size(A,1)/3)*log(g^2) + 2*(size(A,2)/3)*log(mu1^2)  - 2*Gval;
% margLike = -size(A,1)*log(g^2) + size(A,2)*log(mu1^2) + size(B1,2)*log(mu2^2) - 2*Gval;





