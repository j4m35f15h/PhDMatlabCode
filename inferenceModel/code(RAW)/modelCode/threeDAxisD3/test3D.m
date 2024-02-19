% cols = 9;
% rows = 9;
% deps = 8;
cols = 11;
rows = 11;
deps = 9;

rng(2)


% drawnRudiment3D
load('idealStartScaled.mat')
object=object2;
temp2 = mean(object.vertices);
object.vertices = object.vertices - temp2;
object.vertices = object.vertices*RZ(40);
object.vertices = object.vertices + temp2;

'rudiment loaded'
[lattice,faces,object] = formLattice3D(rows,cols,deps,object);
N = size(lattice,2)/3;
% testCE



latticeRefine3D
%setBoundary's role is captured by latticeRefine
% [f1,f2,theta] = setBoundary(lattice,cols);
'lattice constructed'

% spoofDataSimple3D
% % spoofDataRegular3D
% spoofDataTransform3D
% spoofLatticeTransform3D
load('ModelCoord.mat')
CBStat = CBStat - temp2;
CBStat = CBStat*RZ(40);
CBStat = CBStat + temp2;
X = [CBStat(:,1)'+object.offset(1),CBStat(:,2)'+object.offset(2),CBStat(:,3)'+object.offset(3)];


load('idealStatScaled.mat')
temp = mean(object2.vertices);
object2.vertices = object2.vertices - temp;
CAStat = CAStat - temp;

object2.vertices = object2.vertices*[0 -1 0; 1 0 0; 0 0 1];
CAStat = CAStat*[0 -1 0; 1 0 0; 0 0 1];

object2.vertices = object2.vertices + temp;
CAStat = CAStat + temp;

object2.vertices(:,1) = object2.vertices(:,1) + 200;
CAStat(:,1) = CAStat(:,1) + 200;
object2.vertices(:,2) = object2.vertices(:,2) + 150;
CAStat(:,2) = CAStat(:,2) + 150;
object2.vertices(:,3) = object2.vertices(:,3) + 300;
CAStat(:,3) = CAStat(:,3) + 300;

temp2 = mean(object2.vertices);
CAStat = CAStat - temp2;
CAStat = CAStat*RZ(20);
CAStat = CAStat + temp2;
object2.vertices = object2.vertices - temp2;
object2.vertices = object2.vertices*RZ(20);
object2.vertices = object2.vertices + temp2;

x = [CAStat(:,1)',CAStat(:,2)',CAStat(:,3)'];
objectN = object2;




'data found'

% [B1X,B1Y,B1Z] = EqnSolveF3D();
% B1eqn3D = [B1X,B1Y,B1Z];
load('B1Eqn3D')
B1Aug = B1Solve3D(B1eqn3D,lattice,theta,cols,rows);
[D1,B1] = B1Process3D(B1Aug,f1,theta); %clear B1Aug;
'B solved'

faceID = faceIDFind3D(X,lattice,faces,object);
A = ASolveN3D(X,theta,lattice,faces,faceID);
'A solved'

% B2Eqn = eqnSolveF3D2();
% [D2,B2] = B2Solve3D2(B2Eqn,f1,f2,lattice,cols,rows,theta);
[D2,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta);
% [D3,B3] = B3Solve3D(f2,f3,lattice,cols,rows);
'coefficients solved and processed'
clear anisotropy growthMag i j
% slicolate
tic
% [mu1] = varSolvF3D2(x,A,B1,D1,1e-5);
[mu1,mu2] = varSolvF3D(x,A,B1,D1,B2,D2,1e-5);
% [mu1,mu2,mu3] = varSolvF3D3(x,A,B1,D1,B2,D2,B3,D3,1e-5);
'variances found'
toc
clear anisotropy growthMag i j
tic
[latticeNewStat,passes] = latticeSolveF23D(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
% [latticeNewStat,passes] = latticeSolveF23D2(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
% [latticeNew,passes] = latticeSolveF23D3(A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3,x,lattice,theta,f1,f2,f3);
% tic
% [latticeNew,passes] = latticeSolveF23DCE(A,B1,D1,B2,D2,mu1,mu2,x,latticeNew,faces,theta,f1,f2,f4,object,objectN);

% mu1Stat = mu1;
% mu2Stat = mu2;





% cols = 11;
% rows = 11;
% deps = 9;
% 
% load('idealStartScaled.mat')
% object=object2;
% temp2 = mean(object.vertices);
% object.vertices = object.vertices - temp2;
% object.vertices = object.vertices*RZ(40);
% object.vertices = object.vertices + temp2;
% 'rudiment loaded'
% [lattice,faces,object] = formLattice3D(rows,cols,deps,object);
% N = size(lattice,2)/3;
% 
% % testCE
% 
% 
% 
% latticeRefine3D
% %setBoundary's role is captured by latticeRefine
% % [f1,f2,theta] = setBoundary(lattice,cols);
% 'lattice constructed'
% 
% % spoofDataSimple3D
% % % spoofDataRegular3D
% % spoofDataTransform3D
% % spoofLatticeTransform3D
% load('ModelCoord.mat')
% CBDyn = CBDyn - temp2;
% CBDyn = CBDyn*RZ(40);
% CBDyn = CBDyn + temp2;
% X = [CBDyn(:,1)'+object.offset(1),CBDyn(:,2)'+object.offset(2),CBDyn(:,3)'+object.offset(3)];
% 
% load('idealDynScaled.mat')
% object2.vertices(:,1) = object2.vertices(:,1) + 200;
% CADyn(:,1) = CADyn(:,1) + 200;
% object2.vertices(:,3) = object2.vertices(:,3) + 300;
% CADyn(:,3) = CADyn(:,3) + 300;
% 
% temp2 = mean(object2.vertices);
% CADyn = CADyn - temp2;
% CADyn = CADyn*RZ(30);
% CADyn = CADyn + temp2;
% object2.vertices = object2.vertices - temp2;
% object2.vertices = object2.vertices*RZ(30);
% object2.vertices = object2.vertices + temp2;
% 
% x = [CADyn(:,1)',CADyn(:,2)',CADyn(:,3)'];
% objectN = object2;
% 'data found'
% 
% % [B1X,B1Y,B1Z] = EqnSolveF3D();
% % B1eqn3D = [B1X,B1Y,B1Z];
% load('B1Eqn3D')
% B1Aug = B1Solve3D(B1eqn3D,lattice,theta,cols,rows);
% [D1,B1] = B1Process3D(B1Aug,f1,theta); %clear B1Aug;
% 'B solved'
% 
% faceID = faceIDFind3D(X,lattice,faces,object);
% A = ASolveN3D(X,theta,lattice,faces,faceID);
% 'A solved'
% 
% % B2Eqn = eqnSolveF3D2();
% % [D2,B2] = B2Solve3D2(B2Eqn,f1,f2,lattice,cols,rows,theta);
% [D2,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta);
% % [D3,B3] = B3Solve3D(f2,f3,lattice,cols,rows);
% 'coefficients solved and processed'
% clear anisotropy growthMag i j
% % slicolate
% % [mu1] = varSolvF3D2(x,A,B1,D1,1e-5);
% [mu1,mu2] = varSolvF3D(x,A,B1,D1,B2,D2,1e-5);
% % [mu1,mu2,mu3] = varSolvF3D3(x,A,B1,D1,B2,D2,B3,D3,1e-5);
% 'variances found'
% 
% clear anisotropy growthMag i j
% tic
% [latticeNewDyn,passes] = latticeSolveF23D(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
