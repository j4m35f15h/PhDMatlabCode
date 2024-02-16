% cols = 9;
% rows = 9;
% deps = 8;
% rng(2)
% 
% 
% % drawnRudiment3D
% load('idealStartScaled.mat')
% object=object2;
% 
% 'rudiment loaded'
% [lattice,faces,object] = formLattice3D(rows,cols,deps,object);
% N = size(lattice,2)/3;
% % testCE
% 
% 
% 
% latticeRefine3D
% %setBoundary's role is captured by latticeRefine
% % [f1,f2,theta] = setBoundary(lattice,cols);
% 'lattice constructed'
% LatticeStatCross = zeros([size(lattice) 10]);
% 
% % spoofDataSimple3D
% % % spoofDataRegular3D
% % spoofDataTransform3D
% % spoofLatticeTransform3D
% load('ModelCoord.mat')
% X = [CBStat(:,1)'+object.offset(1),CBStat(:,2)'+object.offset(2),CBStat(:,3)'+object.offset(3)];
% 
% 
% load('idealStatScaled.mat')
% temp = mean(object2.vertices);
% object2.vertices = object2.vertices - temp;
% CAStat = CAStat - temp;
% 
% object2.vertices = object2.vertices*[0 -1 0; 1 0 0; 0 0 1];
% CAStat = CAStat*[0 -1 0; 1 0 0; 0 0 1];
% 
% object2.vertices = object2.vertices + temp;
% CAStat = CAStat + temp;
% 
% object2.vertices(:,1) = object2.vertices(:,1) + 200;
% CAStat(:,1) = CAStat(:,1) + 200;
% object2.vertices(:,3) = object2.vertices(:,3) + 200;
% CAStat(:,3) = CAStat(:,3) + 200;
% 
% x = [CAStat(:,1)',CAStat(:,2)',CAStat(:,3)'];
% objectN = object2;
% 
% 
% 
% 
% 'data found'
% 
% % [B1X,B1Y,B1Z] = EqnSolveF3D();
% % B1eqn3D = [B1X,B1Y,B1Z];
% load('B1Eqn3D')
% B1Aug = B1Solve3D(B1eqn3D,lattice,theta,cols,rows);
% [D1,B1] = B1Process3D(B1Aug,f1,theta); %clear B1Aug;
% 'B solved'
% 
% %Need to create a randomsied index list, then set the coorsinates used to
% %delete the elements that are in that group to be ignored
% 
% ignoreList = randperm(size(CBStat,1));
% chunkSize = floor(size(CBStat,1)/10);
% for i = 3:10
%     ignoreIndex = ignoreList((i*chunkSize)-chunkSize+1:i*chunkSize);
%     load('ModelCoord.mat')
%     CBStat(ignoreIndex,:) = [];
%     CAStat(ignoreIndex,:) = [];
%     X = [CBStat(:,1)'+object.offset(1),CBStat(:,2)'+object.offset(2),CBStat(:,3)'+object.offset(3)];
%     load('idealStatScaled.mat')
%     temp = mean(object2.vertices);
%     object2.vertices = object2.vertices - temp;
%     CAStat = CAStat - temp;
%     
%     object2.vertices = object2.vertices*[0 -1 0; 1 0 0; 0 0 1];
%     CAStat = CAStat*[0 -1 0; 1 0 0; 0 0 1];
%     
%     object2.vertices = object2.vertices + temp;
%     CAStat = CAStat + temp;
%     
%     object2.vertices(:,1) = object2.vertices(:,1) + 200;
%     CAStat(:,1) = CAStat(:,1) + 200;
%     object2.vertices(:,3) = object2.vertices(:,3) + 200;
%     CAStat(:,3) = CAStat(:,3) + 200;
%     
%     x = [CAStat(:,1)',CAStat(:,2)',CAStat(:,3)'];
%     objectN = object2;
%     
%     
% 
% Nc = size(CAStat,1);
% faceID = faceIDFind3D(X,lattice,faces,object);
% zeroCell = find(faceID==0);
% X(zeroCell+2*Nc) = [];
% X(zeroCell+Nc) = [];
% X(zeroCell) = [];
% x(zeroCell+2*Nc) = [];
% x(zeroCell+Nc) = [];
% x(zeroCell) = [];
% faceID(zeroCell) = [];
% A = ASolveN3D(X,theta,lattice,faces,faceID);
% 'A solved'
% 
% % B2Eqn = eqnSolveF3D2();
% % [D2,B2] = B2Solve3D2(B2Eqn,f1,f2,lattice,cols,rows,theta);
% [D2,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta);
% % [D3,B3] = B3Solve3D(f2,f3,lattice,cols,rows);
% 'coefficients solved and processed'
% 
% % slicolate
% tic
% % [mu1] = varSolvF3D2(x,A,B1,D1,1e-5);
% [mu1,mu2] = varSolvF3D(x,A,B1,D1,B2,D2,1e-5);
% % [mu1,mu2,mu3] = varSolvF3D3(x,A,B1,D1,B2,D2,B3,D3,1e-5);
% 'variances found'
% toc
% 
% tic
% [latticeNewStat,passes] = latticeSolveF23D(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
% % [latticeNewStat,passes] = latticeSolveF23D2(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
% % [latticeNew,passes] = latticeSolveF23D3(A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3,x,lattice,theta,f1,f2,f3);
% % tic
% % [latticeNew,passes] = latticeSolveF23DCE(A,B1,D1,B2,D2,mu1,mu2,x,latticeNew,faces,theta,f1,f2,f4,object,objectN);
% 
% latticeStatCross(:,:,i) = latticeNewStat;
% 
% end

% mu1Stat = mu1;
% mu2Stat = mu2;





cols = 11;
rows = 11;
deps = 8;

load('idealStartScaled.mat')
object=object2;

'rudiment loaded'
[lattice,faces,object] = formLattice3D(rows,cols,deps,object);
N = size(lattice,2)/3;

% testCE



latticeRefine3D
%setBoundary's role is captured by latticeRefine
% [f1,f2,theta] = setBoundary(lattice,cols);
'lattice constructed'
% 
% % spoofDataSimple3D
% % % spoofDataRegular3D
% % spoofDataTransform3D
% % spoofLatticeTransform3D
% load('ModelCoord.mat')
% X = [CBDyn(:,1)'+object.offset(1),CBDyn(:,2)'+object.offset(2),CBDyn(:,3)'+object.offset(3)];
% x = [CADyn(:,1)',CADyn(:,2)',CADyn(:,3)'];
% load('idealDynScaled.mat')
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


'data found'





% [B1X,B1Y,B1Z] = EqnSolveF3D();
% B1eqn3D = [B1X,B1Y,B1Z];
load('B1Eqn3D')
B1Aug = B1Solve3D(B1eqn3D,lattice,theta,cols,rows);
[D1,B1] = B1Process3D(B1Aug,f1,theta); %clear B1Aug;
'B solved'

%Need to create a randomsied index list, then set the coorsinates used to
%delete the elements that are in that group to be ignored

ignoreList = randperm(size(CBDyn,1));
chunkSize = floor(size(CBDyn,1)/10);
latticeDynCross = zeros([size(lattice) 10]);
for i = 10%1:10
    ignoreIndex = ignoreList((i*chunkSize)-chunkSize+1:i*chunkSize);
    load('ModelCoord.mat')
    CBDyn(ignoreIndex,:) = [];
    CADyn(ignoreIndex,:) = [];
    load('ModelCoord.mat')
    X = [CBDyn(:,1)'+object.offset(1),CBDyn(:,2)'+object.offset(2),CBDyn(:,3)'+object.offset(3)];

    load('idealDynScaled.mat')
    object2.vertices(:,1) = object2.vertices(:,1) + 200;
    CADyn(:,1) = CADyn(:,1) + 200;
    object2.vertices(:,3) = object2.vertices(:,3) + 300;
    CADyn(:,3) = CADyn(:,3) + 300;
    x = [CADyn(:,1)',CADyn(:,2)',CADyn(:,3)'];    
    objectN = object2;
    'data found'
    
    Nc = size(CADyn,1);
    faceID = faceIDFind3D(X,lattice,faces,object);
    zeroCell = find(faceID==0);
    X(zeroCell+2*Nc) = [];
    X(zeroCell+Nc) = [];
    X(zeroCell) = [];
    x(zeroCell+2*Nc) = [];
    x(zeroCell+Nc) = [];
    x(zeroCell) = [];
    faceID(zeroCell) = [];
    A = ASolveN3D(X,theta,lattice,faces,faceID);
    'A solved'

% B2Eqn = eqnSolveF3D2();
% [D2,B2] = B2Solve3D2(B2Eqn,f1,f2,lattice,cols,rows,theta);
[D2,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta);
% [D3,B3] = B3Solve3D(f2,f3,lattice,cols,rows);
'coefficients solved and processed'

% slicolate
tic
% [mu1] = varSolvF3D2(x,A,B1,D1,1e-5);
[mu1,mu2] = varSolvF3D(x,A,B1,D1,B2,D2,1e-5);
% [mu1,mu2,mu3] = varSolvF3D3(x,A,B1,D1,B2,D2,B3,D3,1e-5);
'variances found'
toc

tic
[latticeNewDyn,passes] = latticeSolveF23D(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
% [latticeNewStat,passes] = latticeSolveF23D2(A,B1,D1,B2,D2,mu1,mu2,x,lattice,theta,f1,f2);
% [latticeNew,passes] = latticeSolveF23D3(A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3,x,lattice,theta,f1,f2,f3);
% tic
% [latticeNew,passes] = latticeSolveF23DCE(A,B1,D1,B2,D2,mu1,mu2,x,latticeNew,faces,theta,f1,f2,f4,object,objectN);

latticeDynCross(:,:,i) = latticeNewDyn;

end