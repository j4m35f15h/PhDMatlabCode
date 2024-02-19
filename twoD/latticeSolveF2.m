function [newLattice,passes] = latticeSolveF2(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2)
%LATTICESOLVEF2 Summary of this function goes here
%   We're gonna make our own minimiser. The mu values are reasonable and as
%   far as I can tell, the coefficient values are correct, so the only
%   thing I can think of as not working is the native matlab minimiser.
passes = 0;
U = formU(A,B1,D1,B2,D2,mu1,mu2);
xTrans = zeros(size(U,1),1);
xTrans(1:size(x,2),1) = x';
N = size(lattice,2)/2;
precision = 1e-5;
newLattice = lattice; %Set initial guess to be the original lattice
newLatticeHold = zeros(size(newLattice));
% for f = 1:2
while sum(~ismembertol(newLatticeHold,newLattice,precision,'ByRows',true))
    newLatticeHold = newLattice;
    for i = 1:size(theta,2)
%         [tempX(i),tempY(i)] = varSolvFMinPar(theta(1,i),newLattice,theta,f1,f2,x,A,B1,D1,B2,D2,mu1,mu2,precision);
        newLattice = varSolvFMin2B(theta(1,i),newLattice,theta,f1,f2,xTrans,U,precision);
%           newLattice = varSolvFMin2(theta(1,i),newLattice,theta,f1,f2,xTrans,U,precision);
%         plot(segmentXN,segmentYN)
%         hold on
%         scatter(newLattice(1:end/2),newLattice(1+end/2:end))
%         hold off
    end
    for i = 1:size(f1,2)
%         [tempX(i),tempY(i)] = varSolvFMinPar(f1(1,i),newLattice,theta,f1,f2,x,A,B1,D1,B2,D2,mu1,mu2,precision);
         newLattice = varSolvFMin2B(f1(1,i),newLattice,theta,f1,f2,xTrans,U,precision);
%         newLattice = varSolvFMin2(f1(1,i),newLattice,theta,f1,f2,xTrans,U,precision);
    end
%     for i = 1:size(f2,2)
%         newLattice = varSolvFMax(f2(1,i),newLattice,theta,f1,f2,x,A,B1,D1,B2,D2,mu1,mu2,precision);
%     end
    
%The previous solution has problems in that the expression in the peper we
%are asked to maximise in terms of f2 isn't a function of f2. Sinf the f2
%coordinates are considered hyper-hyper parameters, they are typically
%a variable that is controlled and used to alter the outcome of a
%selection. The folowing algebraic solution for f2 merely maintain the
%smooth boundary condition.
    t1 = find(B2(:,1));
    t2 = find(B2(:,2));
    
%     tempX(f2(1)) = tempX(f1(t1(1))) + (tempX(f1(t2(2))) - tempX(f1(t1(1))))/3;
%     tempY(f2(1)) = tempY(f1(t1(1))) + (tempY(f1(t2(2))) - tempY(f1(t1(1))))/3;
%     tempX(f2(2)) = tempX(f1(t1(1))) + 2*(tempX(f1(t2(2))) - tempX(f1(t1(1))))/3;
%     tempY(f2(2)) = tempY(f1(t1(1))) + 2*(tempY(f1(t2(2))) - tempY(f1(t1(1))))/3;
%     newLattice = [tempX,tempY];

    
    newLattice(f2(1)) = newLattice(f1(t1(1))) + (newLattice(f1(t2(2))) - newLattice(f1(t1(1))))/3;
    newLattice(f2(1)+N) = newLattice(f1(t1(1))+N) + (newLattice(f1(t2(2))+N) - newLattice(f1(t1(1))+N))/3;
    newLattice(f2(2)) = newLattice(f1(t1(1))) + 2*(newLattice(f1(t2(2))) - newLattice(f1(t1(1))))/3;
    newLattice(f2(2)+N) = newLattice(f1(t1(1))+N) + 2*(newLattice(f1(t2(2))+N) - newLattice(f1(t1(1))+N))/3;

    passes = passes + 1
end
end

