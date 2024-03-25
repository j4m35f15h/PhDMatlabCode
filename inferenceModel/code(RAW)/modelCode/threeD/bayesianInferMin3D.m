function [newLattice,passes] = bayesianInferMin3D(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2)
%latticeSolveF23D Performs the maximisation of the likelihood function, or
%the minimisation of the H function defined in Eqn 11c of Morishita et al.
%2014.

%Variable initialisation
passes = 0;
precision = 0.1;
newLattice = lattice; %Set initial guess to be the original lattice
newLatticeHold = zeros(size(newLattice)); %The previous iterative guess
cArray = formCoefArray(A,B1,D1,B2,D2,mu1,mu2);
xTrans = zeros(size(cArray,1),1);
xTrans(1:size(x,2),1) = x';

tic %set up timer
while sum(~ismembertol(newLatticeHold,newLattice,precision,'ByRows',true)) 
    
    newLatticeHold = newLattice; %Store the previous estimate
    
    for i = 1:size(theta,2) %Performs the  minimisation for the calculation domain
        newLattice = latticeMin3D(theta(1,i),newLattice,theta,f1,f2,xTrans,cArray,precision);
    end
    for i = 1:size(f1,2) %Performs the minimisation for the boundary domain
        newLattice = latticeMin3D(f1(1,i),newLattice,theta,f1,f2,xTrans,cArray,precision);
    end
    	
    passes = passes + 1 %Prints number of passes over the lattice
    toc %Prints total time taken on each pass over. Decreases as accuracy of the estimate improves.
end %Loop until the esimates across two passes are the same

end

