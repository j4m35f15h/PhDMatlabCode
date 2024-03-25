function [B] = B1Solve3D(B1eqn,lattice,theta,cols,rows)
%BSOLVE Substitutes coordinates of lattice intersections into the B1
%equations for the calculation domains. Does not destinguish between theta
%and f1 yet

M1 = size(lattice,2)/3;
B = zeros(3*M1,3*M1);
for i = 1:M1
    if ~ismember(i,theta) %Skip elements of the lattice that are not involved in the estimation
        continue;
    end
    [local,localIndex] = neighbours3D(i,lattice,cols,rows);
    if sum(isnan(local)) %skip point if it is on the boundary
        continue;
    end
    %Find the numerical value of the coefficients by subtituting in the
    %coordinate values
    Btemp = -1*substitution(B1eqn,local,lattice,i,M1);
    for j = 1:6
        B(i,localIndex(j)) = double(Btemp(j));
    end
    %Diagonal must be ones
    B(i,i) = 1;
    B(i+M1,i+M1) = 1;
    B(i+2*M1,i+2*M1) = 1;
end
end

function Btemp = substitution(B1eqn,local,lattice,In,M1)
N = sym('n',[3 7]); %Previous position of theta
Btemp = B1eqn;
for i = 1:size(B1eqn,2)/3
    Btemp(i) = subs(B1eqn(i),[N(1,1) N(1,2) N(1,3) N(1,4) N(1,5) N(1,6),N(2,1) N(2,2) N(2,3) N(2,4) N(2,5) N(2,6),N(3,1) N(3,2) N(3,3) N(3,4) N(3,5) N(3,6)],[local(1),local(2),local(3),local(4),local(5),local(6),local(1+6),local(2+6),local(3+6),local(4+6),local(5+6),local(6+6),local(1+6+6),local(2+6+6),local(3+6+6),local(4+6+6),local(5+6+6),local(6+6+6)]);
    Btemp(i) = subs(Btemp(i),[N(1,7) N(2,7) N(3,7)],[lattice(In) lattice(In+M1) lattice(In+2*M1)]);
end
end