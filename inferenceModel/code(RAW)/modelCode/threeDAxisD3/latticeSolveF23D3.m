function [newLattice,passes] = latticeSolveF23D3(A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3,x,lattice,theta,f1,f2,f3)
passes = 0;
precision = 0.1;
newLattice = lattice; %Set initial guess to be the original lattice
newLatticeHold = zeros(size(newLattice));
U = formU3(A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
xTrans = zeros(size(U,1),1);
xTrans(1:size(x,2),1) = x';
% for f = 1:2
while sum(~ismembertol(newLatticeHold,newLattice,precision,'ByRows',true))
    newLatticeHold = newLattice;
    for i = 1:size(theta,2)
        newLattice = varSolvFMin3D3(theta(1,i),newLattice,theta,f1,f2,f3,xTrans,U,precision);
    end
    for i = 1:size(f1,2)
        newLattice = varSolvFMin3D3(f1(1,i),newLattice,theta,f1,f2,f3,xTrans,U,precision);
    end
    	
    %The following expression is going to become much harder to untangle. Our best
    % bet would be to try and set it's position to the average of the # neighbour
    % f1 positions. We're still going to have the issue of the boundary point 
    %violating some of the prior information. Still, the error around them is small
    % and we can keep the points far away from the regions of interest.    

    %Compile a list of the valid neighbours
    %set position to be average position of the valid neighbourhood.
%     [local1,localIndex1] = neighbours83D(f2(1),newLattice,cols,rows);
%     [local2,localIndex2] = neighbours83D(f2(2),newLattice,cols,rows);
%     localIndex1 = [localIndex1,localIndex1,localIndex1];
%     localIndex2 = [localIndex2,localIndex2,localIndex2];
%     local1(find(~ismember(localIndex1,f1))) = [];
%     local2(find(~ismember(localIndex2,f1))) = [];
%     newLattice(f2(1)) = mean(local1(1:end/3));
%     newLattice(f2(1)+N) = mean(local1(1+end/3:2*end/3)); 
%     newLattice(f2(1)+2*N) = mean(local1(1+2*end/3:end));
% 
%     newLattice(f2(2)) = mean(local2(1:end/3));
%     newLattice(f2(2)+N) = mean(local2(1+end/3:2*end/3)); 
%     newLattice(f2(2)+2*N) = mean(local2(1+2*end/3:end));
    passes = passes + 1
    toc
end
end

