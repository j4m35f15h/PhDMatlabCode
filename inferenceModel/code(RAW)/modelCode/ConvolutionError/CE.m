function convErr = CE(in,object,objectN,latticeNew,faces,f1)
%CE returns the error associated with the overlap between
%the known end geometry and the current estimate. Produces an estimate of
%the limb geometry using interpolation coefficients applied to the vertices
%of the geometry. Identifies the overlap in the boundaries of the estimated
%organ geomtry and the known end geomtry. Returns an error based on the
%overlap, which is at a minimum at the maximum overlap.

N = size(latticeNew,2)/3;

%The estimated organ geomtry is generated
meshEst.vertices = zeros(size(object.vertices));
meshEst.faces = object.faces;

%Interpolation coefficients created during initialisation with the CE
%script are used
for i = 1:size(object.vertices,1) %Create limb shape estimate
    meshEst.vertices(i,:) = object.vertexCoef(i,:)*[latticeNew(object.vertexCube(i,:))',latticeNew(object.vertexCube(i,:)+N)',latticeNew(object.vertexCube(i,:)+2*N)'];
end

temp = faces(any(faces==in,2),:); %index of cubes insluding indexed point

%Remove cubes strictly in the calculation domain
if any(ismember(temp,f1))
    temp = temp.*~ismember(temp,f1);
    temp = temp(find(temp));
end


%Create 10x10x10 grid that fills the space of the cubes surrounding the point
xrange = [min(min(latticeNew(temp))) max(max(latticeNew(temp)))];
yrange = [min(min(latticeNew(temp+N))) max(max(latticeNew(temp+N)))];
zrange = [min(min(latticeNew(temp+2*N))) max(max(latticeNew(temp+2*N)))];
[xax,yax,zax] = meshgrid([xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]);

%identify which geometry contains elements of the grid.
estKernel =inpolyhedron(meshEst,[xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]);
idealKernel =inpolyhedron(objectN,[xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]);

%Set the value of grid elements contained in the geometries to 1
temp = zeros(size(xax));
temp(estKernel) = 1;
estKernel = temp;

temp = zeros(size(xax));
temp(idealKernel) = 1;
idealKernel = temp;

%Valuereturned from a perfect overlap
errorComp = sum(sum(sum(idealKernel)));

%Create a penalty for exceeding the ideal geomerty
idealKernel(idealKernel==0) = -1;

%Dot multiplying the two kernels gives a numerical value which
%we normalise by the perfect overlap value to generate  error.
convErr = abs(sum(sum(sum(estKernel.*idealKernel)))-errorComp);
end