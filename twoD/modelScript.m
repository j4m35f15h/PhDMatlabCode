%% Model Initialisation

%Sets the relative resolution of the lattice
cols = 15;  %Number of Columns (N.B. two lattice intersection outside organ boundary)
rows = 15;  %Number of Rows
%rng(1)     %Sets RNG seed if random sample data required

%Tissue geometry loading
drawnRudiment   %Example organ outline
%   Outlines consist of two variables:
%       segmentX - Indexed x coordinates along the organ outline
%       SegmentY - Indexed y coordinates along the organ outline
'rudiment loaded'

%Lattice creation
[latticeV,latticeF] = formLattice(rows,cols); %Lattice follows STL fomat, with vertices and faces.
N = size(latticeV,2)/2; %Number of lattice vertices
latticeRefine
'lattice constructed'

%Importing Data
%   Some synthetic datasets, with coordinates...
%     spoofDataSimple
%     spoofDataNormal
%     spoofDataRegular
%   ...and transforms
%     spoofDataTransform
%     spoofLatticeTransform
%
% X = [0.25 0.6 0.755 0.5 0.6 0.75];
% X = (X/max(X))*0.34 + 0.34;
% x = [0.3 0.6 0.8 0.55 0.5 0.8];
% x = (x/max(x))*0.34 + 0.34;
'data found'

%% Coefficient Calculation
%Interpolation coefficients
faceID = faceIDFind(X,latticeV,latticeF);%finds the face each label belongs to
A = ASolveN(X,theta,latticeV,latticeF,faceID);
'A solved'
%Smoothness coefficients
[B1X,B1Y] = EqnSolveF();% returns the general form of the arg min equations
B1eqn = [B1X,B1Y]; clear B1X B1Y;
B1Aug = B1Solve(B1eqn,latticeV,cols,f1,f2);%Substitutes lattice coordinates into the general form equations
[D1,B1] = B1Process(B1Aug,f1,theta); clear B1Aug;%restructures coefficient array
'B solved'

%We have D1,B1; so now we need D2 B2. We can do the same thing as before
%and make an augmented matrix, then spearate it out using effectively the
%same code as was used to diminish the first.
[D2,B2] = B2Solve(f1,f2,latticeV,cols);
'coefficients solved and processed'
[mu1,mu2] = varSolvF(x,A,B1,D1,B2,D2,1e-4);
% [mu1,mu2] = varSolvF2(x,A,B1,D1,B2,D2);
'variances found'
clear anisotropy growthMag i j
[latticeNew,passes] = latticeSolveF2(A,B1,D1,B2,D2,mu1,mu2,x,latticeV,theta,f1,f2);




