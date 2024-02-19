function [B] = B1Solve3D(B1eqn,lattice,theta,cols,rows)
%BSOLVE Summary of this function goes here
%   
M1 = size(lattice,2)/3;
B = zeros(3*M1,3*M1);
for i = 1:M1
    if ~ismember(i,theta)
        continue;
    end
    [local,localIndex] = neighbours3D(i,lattice,cols,rows);
    if sum(isnan(local)) %skip point if it is on the boundary
        continue;
    end
%     if sum(ismember(f2,localIndex))
%         %Take the f2 value that is a member and find it's neighbours.
%         [~,temp] = neighbours(f2(find(ismember(f2,localIndex))),lattice,cols);
%         %If the neighbour is a member of f1,set it's index in local and its
%         %coordinates in local index.
%         new = temp(find(ismember(temp,f1)));
%         local(localIndex(find(ismember(localIndex,f2)))) = lattice(new);
%         local(localIndex(find(ismember(localIndex,f2)))+4) = lattice(new+M1);
%         localIndex(find(ismember(localIndex,f2))) = new;
%     end
    Btemp = -1*substitution(B1eqn,local,lattice,i,M1);
    for j = 1:6
        B(i,localIndex(j)) = double(Btemp(j));
%         B(i+M1,localIndex(j)+M1) = double(Btemp(j+6));
%         B(i+2*M1,localIndex(j)+2*M1) = double(Btemp(j+2*6));
    end
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
    
%     Btemp(i+size(B1eqn,2)/3) = subs(B1eqn(i+size(B1eqn,2)/3),[N(1,1) N(1,2) N(1,3) N(1,4) N(1,5) N(1,6),N(2,1) N(2,2) N(2,3) N(2,4) N(2,5) N(2,6),N(3,1) N(3,2) N(3,3) N(3,4) N(3,5) N(3,6)],[local(1),local(2),local(3),local(4),local(5),local(6),local(1+6),local(2+6),local(3+6),local(4+6),local(5+6),local(6+6),local(1+6+6),local(2+6+6),local(3+6+6),local(4+6+6),local(5+6+6),local(6+6+6)]);
%     Btemp(i+size(B1eqn,2)/3) = subs(Btemp(i+size(B1eqn,2)/3),[N(1,7) N(2,7) N(3,7)],[lattice(In) lattice(In+M1) lattice(In+2*M1)]);
%     
%     Btemp(i+2*size(B1eqn,2)/3) = subs(B1eqn(i+2*size(B1eqn,2)/3),[N(1,1) N(1,2) N(1,3) N(1,4) N(1,5) N(1,6),N(2,1) N(2,2) N(2,3) N(2,4) N(2,5) N(2,6),N(3,1) N(3,2) N(3,3) N(3,4) N(3,5) N(3,6)],[local(1),local(2),local(3),local(4),local(5),local(6),local(1+6),local(2+6),local(3+6),local(4+6),local(5+6),local(6+6),local(1+6+6),local(2+6+6),local(3+6+6),local(4+6+6),local(5+6+6),local(6+6+6)]);
%     Btemp(i+2*size(B1eqn,2)/3) = subs(Btemp(i+2*size(B1eqn,2)/3),[N(1,7) N(2,7) N(3,7)],[lattice(In) lattice(In+M1) lattice(In+2*M1)]);
end
end