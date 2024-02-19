function [D2,B2] = B2Solve3D2(B2Eqn,f1,f2,lattice,cols,rows,theta)
%B2SOLVE3D2 Summary of this function goes here
%   Detailed explanation goes here
N = size(lattice,2)/3;
M2 = size(f1,2);
M3 = size(f2,2);
D2 = zeros(3*M2,3*M2);
B2 = zeros(3*M2,3*M3);
for i = 1:size(f1,2)
    
    [~,localIndex] = neighbours3D(f1(i),lattice,cols,rows);
    temp = localIndex(find(ismember(localIndex,f1)));
    if size(temp,2) < 4
        
        continue;
        tempNeg = localIndex(find(ismember(localIndex,theta)));
        for j = 1:size(tempNeg,2)
            [~,localIndex2] = neighbours3D(tempNeg(j),lattice,cols,rows);
            localIndex(find(ismember(localIndex2,f1).*~ismember(localIndex2,f1(i)))) = localIndex2(find(ismember(localIndex2,f1).*~ismember(localIndex2,f1(i))));
        end
    end
    localIndex = localIndex([6 4 1 5 2 3]);
    localIndex(find(~ismember(localIndex,f1)))= [];
    local = [lattice(localIndex),lattice(localIndex+N),lattice(localIndex+2*N)];
    %substitution step
    Btemp = substitution(B2Eqn,local,lattice,f1(i),N);
    Btemp = double(Btemp);
    for j = 1:size(Btemp,2)/3
        if ismember(localIndex(j),f2)
            B2(i,find(f2==localIndex(j))) = Btemp(j);
            B2(i+M2,find(f2==localIndex(j))+M3) = Btemp(j+size(Btemp,2)/3);
            B2(i+2*M2,find(f2==localIndex(j))+2*M3) = Btemp(j+2*size(Btemp,2)/3);
            continue;
        end
        if ismember(temp(j),f1)
            D2(i,find(f1==localIndex(j))) = Btemp(j);
            D2(i+M2,find(f1==localIndex(j))+M3) = Btemp(j+size(Btemp,2)/3);
            D2(i+2*M2,find(f1==localIndex(j))+2*M3) = Btemp(j+2*size(Btemp,2)/3);
        end
    end
    D2(i,i) = 1;
end

%At This point, we have a matrix that uss all of the boundary points. We
%now need to diminish the matix into just the bounday points, and the edges
%of the boundary. I can assume that we use the first and last point.
% for i = 2:M2-1
%     B2(i-1,1) = D2Aug(i,1);
%     B2(i-1,2) = D2Aug(i,M2);
% end

%Array is no longer a mirror. Distinct coefficients for all of the
%directions
% B2(M2+1:2*M2,M3+1:2*M3) = B2(1:M2,1:M3);
% B2(2*M2+1:3*M2,2*M3+1:3*M3) = B2(1:M2,1:M3);
% 
% D2 = zeros(3*M2,3*M2);
% D2(1:M2,1:M2) = D2Aug(1:M2,1:M2);
% D2(M2+1:2*M2,M2+1:2*M2) = D2(1:M2,1:M2);
% D2(2*M2+1:3*M2,2*M2+1:3*M2) = D2(1:M2,1:M2);
end

function  Btemp = substitution(B2Eqn,local,lattice,In,M1)
N = sym('n',[3 5]); %Previous position of theta
Btemp = B2Eqn;
for i = 1:size(B2Eqn,2)/3
%     local
    Btemp(i) = subs(Btemp(i),[N(3,1) N(3,2) N(3,3) N(3,4)],[local(1+4+4),local(2+4+4),local(3+4+4),local(4+4+4)]);

    Btemp(i) = subs(Btemp(i),[N(1,5) N(2,5) N(3,5)],[lattice(In) lattice(In+M1) lattice(In+2*M1)]);
    Btemp(i) = subs(Btemp(i),[N(1,1) N(1,2) N(1,3) N(1,4)],[local(1),local(2),local(3),local(4)]);
   
    Btemp(i) = subs(Btemp(i),[N(2,1) ],[local(1+4)]);
    Btemp(i) = subs(Btemp(i),[ N(2,2) ],[local(2+4)]);

    Btemp(i) = subs(Btemp(i),[  N(2,4)],[local(4+4)]);
    Btemp(i) = subs(Btemp(i),[ N(2,3)],[local(3+4)]);
    
      
    Btemp(i+size(B2Eqn,2)/3) = subs(B2Eqn(i+size(B2Eqn,2)/3),[N(1,1) N(1,2) N(1,3) N(1,4) N(1,5) ,N(2,1) N(2,2) N(2,3) N(2,4) N(2,5) ,N(3,1) N(3,2) N(3,3) N(3,4) N(3,5) ],[local(1),local(2),local(3),local(4),lattice(In),local(1+4),local(2+4),local(3+4),local(4+4),lattice(In+M1),local(1+4+4),local(2+4+4),local(3+4+4),local(4+4+4),lattice(In+2*M1)]);
    
    Btemp(i+2*size(B2Eqn,2)/3) = subs(B2Eqn(i+2*size(B2Eqn,2)/3),[N(1,1) N(1,2) N(1,3) N(1,4) N(1,5) ,N(2,1) N(2,2) N(2,3) N(2,4) N(2,5) ,N(3,1) N(3,2) N(3,3) N(3,4) N(3,5) ],[local(1),local(2),local(3),local(4),lattice(In),local(1+4),local(2+4),local(3+4),local(4+4),lattice(In+M1),local(1+4+4),local(2+4+4),local(3+4+4),local(4+4+4),lattice(In+2*M1)]);
end
end