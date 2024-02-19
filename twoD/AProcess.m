function A = AProcess(A,f1,f2)
%APROCESS Summary of this function goes here
%   Detailed explanation goes here
A(:,[f1 f2 f1+size(A,2)/2 f2+size(A,2)/2]) = [];
end

