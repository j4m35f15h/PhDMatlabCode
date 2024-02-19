function convErr = CE(in,object,objectN,latticeNew,faces,f1)

N = size(latticeNew,2)/3;
meshEst.vertices = zeros(size(object.vertices));
meshEst.faces = object.faces;

for i = 1:size(object.vertices,1)%Create limb shape estimate
    meshEst.vertices(i,:) = object.vertexCoef(i,:)*[latticeNew(object.vertexCube(i,:))',latticeNew(object.vertexCube(i,:)+N)',latticeNew(object.vertexCube(i,:)+2*N)'];
end

temp = faces(any(faces==in,2),:);%indexof cubes with point
if any(ismember(temp,f1))
    temp = temp.*~ismember(temp,f1);
    temp = temp(find(temp));%Only index of the cubes were interested in
end


%Create grid
% xrange = [min(min(latticeNew(faces(temp)))) max(max(latticeNew(faces(temp))))];
% yrange = [min(min(latticeNew(faces(temp)+N))) max(max(latticeNew(faces(temp)+N)))];
% zrange = [min(min(latticeNew(faces(temp)+2*N))) max(max(latticeNew(faces(temp)+2*N)))];
% [xax,yax,zax] = meshgrid([xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/19:zrange(2)]);

xrange = [min(min(latticeNew(temp))) max(max(latticeNew(temp)))];
yrange = [min(min(latticeNew(temp+N))) max(max(latticeNew(temp+N)))];
zrange = [min(min(latticeNew(temp+2*N))) max(max(latticeNew(temp+2*N)))];
[xax,yax,zax] = meshgrid([xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]);
%Duplicate
%for where inplohedron, 1
% estKernel = zeros(size(xax));
% idealKernel = estKernel;
% for j = 1:10    %I think we might be able to parallelize this if we unspool the arrays.
%     for k = 1:10
%         for m =1:10
%             estKernel(j,k,m) = inpolyhedron(meshEst,xax(j,k,m),yax(j,k,m),zax(j,k,m)); 
%             idealKernel(j,k,m) = inpolyhedron(objectN,xax(j,k,m),yax(j,k,m),zax(j,k,m));
%         end
%     end
% end

%provides indecies in mesh grid that it is valid for.
estKernel =inpolyhedron(meshEst,[xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]);
idealKernel =inpolyhedron(objectN,[xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]);

temp = zeros(size(xax));
temp(estKernel) = 1;
estKernel = temp;

temp = zeros(size(xax));
temp(idealKernel) = 1;
idealKernel = temp;
errorComp = sum(sum(sum(idealKernel)));
%for not, 0 or -1 depending. estKernel already 0 padded
idealKernel(idealKernel==0) = -1;
%.* the two then sum sum sum
convErr = abs(sum(sum(sum(estKernel.*idealKernel)))-errorComp);%/(10^3);
end