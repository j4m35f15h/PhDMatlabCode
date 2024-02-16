function [latticeNew,passes] = latticeSolveF23DCE(A,B1,D1,B2,D2,mu1,mu2,x,lattice,faces,theta,f1,f2,f4,object,objectN)
passes = 0;
precision = 0.1;
latticeNew = lattice; %Set initial guess to be the original lattice
latticeNewHold = zeros(size(latticeNew));
U = formU(A,B1,D1,B2,D2,mu1,mu2);
U2 = formU(A,B1,D1,B2,D2,mu1,mu2);
xTrans = zeros(size(U,1),1);
xTrans(1:size(x,2),1) = x';
% for f = 1:2
while sum(~ismembertol(latticeNewHold,latticeNew,precision,'ByRows',true))
    latticeNewHold = latticeNew;
    for i = 1:size(theta,2)
        latticeNew = varSolvFMin3D2(theta(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    for i = 1:size(f1,2)
        latticeNew = varSolvFMin3D2(f1(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    	
    passes = passes + 1
    toc
end
'Boundary correction'
latticeNewHold = zeros(size(latticeNew));
while sum(~ismembertol(latticeNewHold,latticeNew,precision,'ByRows',true))
    latticeNewHold = latticeNew;
    for i = 1:size(theta,2)
        if ismember(theta(1,i),f4)
            latticeNew = varSolvFMin3D2CE(theta(1,i),object,objectN,latticeNew,faces,theta,f1,f2,f4,mu2,xTrans,U2,precision);
            continue
        end
        latticeNew = varSolvFMin3D2(theta(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    for i = 1:size(f1,2)
        latticeNew = varSolvFMin3D2(f1(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    	
    passes = passes + 1
    toc
end

end

