function [latticeNew,passes] = bayesianInferMin3DCE(A,B1,D1,B2,D2,mu1,mu2,x,lattice,faces,theta,f1,f2,f4,object,objectN)
%latticeSolveF23D Performs the maximisation of the likelihood function, or
%the minimisation of the H function defined in Eqn 11c of Morishita et al.
%2014. Introduces an additional step which incorporates a chape correction
%through convolution.

%Variable initialisation
passes = 0;
precision = 0.1;
latticeNew = lattice; %Set initial guess to be the original lattice
latticeNewHold = zeros(size(latticeNew));
U = formU(A,B1,D1,B2,D2,mu1,mu2);
U2 = formU(A,B1,D1,B2,D2,mu1,mu2);
xTrans = zeros(size(U,1),1);
xTrans(1:size(x,2),1) = x';

tic %Setup timer
while sum(~ismembertol(latticeNewHold,latticeNew,precision,'ByRows',true))
    
    latticeNewHold = latticeNew; %Store the previous estimate
    
    for i = 1:size(theta,2) %Performs the  minimisation for the calculation domain
        latticeNew = latticeMin3D(theta(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    for i = 1:size(f1,2) %Performs the minimisation for the boundary domain
        latticeNew = latticeMin3D(f1(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    	
    passes = passes + 1 %Prints number of passes over the lattice
    toc %Prints total time taken on each pass over. Decreases as accuracy of the estimate improves.
end %Loop until the esimates across two passes are the same

'Start of boundary correction'

boundaryPasses = 0;
latticeNewHold = zeros(size(latticeNew));
while sum(~ismembertol(latticeNewHold,latticeNew,precision,'ByRows',true))
    
    latticeNewHold = latticeNew; %Store the previous estimate
    
    for i = 1:size(theta,2)
        if ismember(theta(1,i),f4) %If intersection is a member of the special boundary subset...
            latticeNew = latticeMin3DCE(theta(1,i),object,objectN,latticeNew,faces,theta,f1,f2,f4,mu2,xTrans,U2,precision);
            continue
        end
        %...otherwise, perform the normal minimisation
        latticeNew = latticeMin3D(theta(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    
    for i = 1:size(f1,2)
        latticeNew = latticeMin3D(f1(1,i),latticeNew,theta,f1,f2,xTrans,U,precision);
    end
    	
    boundaryPasses = boundaryPasses + 1
    toc
end %Loop until the esimates across two passes are the same

end

