function [U] = formU3(A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3)
%FORMU Summary of this function goes here
%   Detailed explanation goes here

% U = zeros(size(A,1) + size(B1,1),size(A,2) + size(B1,2) );
% U(1:size(A,1),1:size(A,2)) =A;
% U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
% U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;

% U = zeros(size(A,1) + size(B1,1) + size(B2,1),size(A,2) + size(B1,2) + size(B2,2));
% U(1:size(A,1),1:size(A,2)) = A;
% U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1.*mu1;
% U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1.*mu1;
% 
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+1:size(A,2)+size(D2,2)) = -D2.*mu2;
% U(size(A,1)+size(D1,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2.*mu2;

U = zeros(size(A,1) + size(B1,1) + size(B2,1) + size(B3,1),size(A,2) + size(B1,2) + size(B2,2) + size(B3,2));
U(1:size(A,1),1:size(A,2)) =A;
U(size(A,1)+1:size(A,1)+size(D1,1),1:size(D1,2)) = -D1*mu1;
U(size(A,1)+1:size(A,1)+size(B1,1),size(A,2)+1:size(A,2)+size(B1,2)) = B1*mu1;

U(size(A,1)+size(D1,1)+1:size(A,1)+size(D1,1) + size(D2,1),size(A,2)+1:size(A,2)+size(D2,2)) = -D2*mu2;
U(size(A,1)+size(D1,1)+1:size(A,1)+size(D1,1) + size(D2,1),size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = B2*mu2;

U(size(A,1)+size(D1,1) + size(D2,1)+1:end,size(A,2)+size(D2,2)+1:size(A,2)+size(D2,2)+size(B2,2)) = -D3*mu3;
U(size(A,1)+size(D1,1) + size(D2,1)+1:end,size(A,2)+size(D2,2)+size(B2,2)+1:size(A,2)+size(D2,2)+size(B2,2)+size(B3,2)) = B3*mu3;
end

