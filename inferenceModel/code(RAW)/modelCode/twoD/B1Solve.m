function [B] = B1Solve(B1eqn,lattice,cols,f1,f2)
%BSOLVE Summary of this function goes here
%   
M1 = size(lattice,2)/2;
B = zeros(2*M1,2*M1);
for i = 1:M1
    [local,localIndex] = neighbours(i,lattice,cols);
    if sum(isnan(local)) %skip point if it is on the boundary
        continue;
    end

    Btemp = -1*substitution(B1eqn,local,lattice,i,M1);
    for j = 1:4
        B(i,localIndex(j)) = double(Btemp(j));
        B(i+M1,localIndex(j)+M1) = double(Btemp(j+4));
    end
    B(i,i) = 1;
    B(i+M1,i+M1) = 1;
end
end

function Btemp = substitution(B1eqn,local,lattice,In,M1)
N = sym('n',[2 5]); %Previous position of theta
Btemp = B1eqn;
for i = 1:size(B1eqn,2)/2
    Btemp(i) = subs(B1eqn(i),[N(1,1) N(1,2) N(1,3) N(1,4),N(2,1),N(2,2),N(2,3),N(2,4)],[local(1) local(2) local(3) local(4),local(5),local(6),local(7),local(8)]);
    Btemp(i) = subs(Btemp(i),[N(1,5) N(2,5)],[lattice(In) lattice(In+M1)]);
    Btemp(i+size(B1eqn,2)/2) = subs(B1eqn(i+size(B1eqn,2)/2),[N(1,1) N(1,2) N(1,3) N(1,4),N(2,1),N(2,2),N(2,3),N(2,4)],[local(1) local(2) local(3) local(4) local(5),local(6),local(7),local(8)]);
    Btemp(i+size(B1eqn,2)/2) = subs(Btemp(i+size(B1eqn,2)/2),[N(1,5) N(2,5)],[lattice(In) lattice(In+M1)]);
end
end