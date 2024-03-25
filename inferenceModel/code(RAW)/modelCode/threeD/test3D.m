% cols = 9;
% rows = 9;
% deps = 8;

%Set the number of lattice intersections in x,y and z
cols = 11;
rows = 11;
deps = 9;


% Load in the stl (e.g.):
load('idealStartScaled.mat')
object=object2;

%Transforms applied to mesh. Here for example a 40 deg rotation is applied
%If there is an obvious orthogonal major and minor axis, they should be
%aligned with x and y
temp2 = mean(object.vertices);
object.vertices = object.vertices - temp2;
object.vertices = object.vertices*RZ(40);
object.vertices = object.vertices + temp2;

'initial geometry loaded'


[lattice,faces,object] = formLattice3D(rows,cols,deps,object);
N = size(lattice,2)/3;

% %If the convvolutional correction is needed:
% initCE



latticeRefine3D
%setBoundary's role is captured by latticeRefine
'lattice constructed'

% spoofDataSimple3D
% spoofDataRegular3D
% spoofDataTransform3D
% spoofLatticeTransform3D
load('ModelCoord.mat')
CBStat = CBStat - temp2;
CBStat = CBStat*RZ(40);
CBStat = CBStat + temp2;
X = [CBStat(:,1)'+object.offset(1),CBStat(:,2)'+object.offset(2),CBStat(:,3)'+object.offset(3)];


%Sometimes more complicated transforms may be required
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

%Equations for B1 can be loaded in, it is only the substitution of
%coordinate values that creates a specific solution
% [B1X,B1Y,B1Z] = EqnSolveF3D();
% B1eqn3D = [B1X,B1Y,B1Z];
load('B1Eqn3D')
B1Aug = B1Solve3D(B1eqn3D,lattice,theta,cols,rows);
[D1,B1] = B1Process3D(B1Aug,f1,theta); %clear B1Aug;
'B1 solved'

faceID = faceIDFind3D(X,lattice,faces,object);
A = ASolveN3D(X,theta,lattice,faces,faceID);
'A solved'

% B2Eqn = eqnSolveF3D2();
% [D2,B2] = B2Solve3D2(B2Eqn,f1,f2,lattice,cols,rows,theta);
[D2,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta);
'coefficients solved and processed'
clear anisotropy growthMag i j

% tic
[mu1,mu2] = varSolveF3D(x,A,B1,D1,B2,D2,1e-5);
'variances found'
% toc

clear anisotropy growthMag i j
tic
[latticeNewStat,passes] = bayesianInferMin3D(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);

% tic
% [latticeNew,passes] = bayesianInferMin3DCE(A,B1,D1,B2,D2,mu1,mu2,x,latticeNew,faces,theta,f1,f2,f4,object,objectN);


