tx = object.vertices(:,1);
ty = object.vertices(:,2);
tz = object.vertices(:,3);
for i = 1:size(faces,1)
    %     faceDef = [1 4 2;2 4 3;...
    %         5 6 8; 6 7 8;...
    %         4 7 3; 8 7 4;...
    %         1 2 6; 5 1 6;...
    %         1 5 4; 4 5 8;...
    %         2 3 6; 3 7 6];
    %     Make shapes for inpolyhedron from cubes.
    % Look for cubes that contain mesh vertices.
    % If yes, create the reconstruction coefficients.
    % Store the cube index? And the coefficients.
    
    insideV = find((tx>min(lattice(faces(i,:)))).*(tx<max(lattice(faces(i,:)))).*(ty>min(lattice(faces(i,:)+end/3))).*(ty<max(lattice(faces(i,:)+end/3))).*(tz>min(lattice(faces(i,:)+2*end/3))).*(tz<max(lattice(faces(i,:)+2*end/3))));
    %now we have the vertices contained within a certain cube.
    %     Considering that we want to make reconstruction coefficients out of
    %     these, we should probalby store each vertex with the index of the
    %     cube that contains it. I think we can just stick it as another field
    %     in object. It is going to be indexed by the vertices, and contain the
    %     row in faces.
    for k = insideV'
        object.vertexCube(k,:) = faces(i,:);
    end
    
    
    
    %     Do for all
    %     gives me cubes that contain vertices, as well as which ones.
    %     then need to use these to calculate coefficients.
    %     can steal the code from a solve.
end

% Calculatin the interpolation coefficients requires the coordinate values
% of the faces, and then the vertex
object.vertexCoef = zeros(size(object.vertexCube));
for i = 1:size(object.vertexCoef,1)
    object.vertexCoef(i,:) = interpolationCoef3D([lattice(object.vertexCube(i,:)),lattice(object.vertexCube(i,:)+N),lattice(object.vertexCube(i,:)+2*N)],object.vertices(i,:));
end
%Now that we have the interpolation coefficients, we are able to transform
%the initial lattice to the estimated state. At this point we need to write
%some code to transform the lattice. Next we do the part that calculates
%the error.
% meshEst.vertices = zeros(size(object.vertices));
% meshEst.faces = object.faces;
% for i = 1:size(object.vertices,1)
%     meshEst.vertices(i,:) = object.vertexCoef(i,:)*[latticeNew(object.vertexCube(i,:))',latticeNew(object.vertexCube(i,:)+N)',latticeNew(object.vertexCube(i,:)+2*N)'];
% end
% 
% %Now we have an estimate for the mesh, we need to compare them. We're going
% %to look through our cube list that we know contains our mesh. We're going
% %to check those cubes to see if they contain vertices from the ideal mesh.
% %This is where inpolyhedron would have been useful.
% 
% %A rough approximation should be fine. We're going to go through the list
% %of vertices just before the boundary. We can obtain the neighbour cubes
% %that don't contain boundary points. We then create a cubiod using the
% %min/max of the 18 lattice points. We can fill the cuboid with a regular
% %grid
% 
% for i =1:size(f4,2)
%     %Have the points, need to find where the face list contains these
%     %points. Essentially find the four-ish cubes that contain the element.
%     
%     %Find cubes containin. eliminate ones eith f1 members.
%     temp = faces(any(faces==f4(i),2),:);%indexof cubes with point
%     if any(ismember(temp,f1))
%         temp = temp.*~ismember(temp,f1);
%         temp = temp(find(temp));%Only index of the cubes were interested in
%     end
%     if isnull(temp)
%         continue
%     end
%     
%     %Create grid
%     xrange = [min(min(lattice(faces(temp)))) max(max(lattice(faces(temp))))];
%     yrange = [min(min(lattice(faces(temp)+N))) max(max(lattice(faces(temp)+N)))];
%     zrange = [min(min(lattice(faces(temp)+2*N))) max(max(lattice(faces(temp)+2*N)))];
%     [xax,yax,zax] = meshgrid([xrange(1):diff(xrange)/9:xrange(2)],[yrange(1):diff(yrange)/9:yrange(2)],[zrange(1):diff(zrange)/9:zrange(2)]); 
%     %Duplicate
%     %for where inplohedron, 1
%     estKernel = zeros(size(xax));
%     idealKernel = estKernel;
%     for j = 1:10    %I think we might be able to parallelize this if we unspool the arrays.
%         for k = 1:10
%             for m =1:10
%                 estKernel(j,k,m) = inpolyhedron(meshEst,xax(j,k,m),yax(j,k,m),zax(j,k,m)); %Need to change meshEst
%                 idealKernel(j,k,m) = inpolyhedron(objectN,xax(j,k,m),yax(j,k,m),zax(j,k,m));
%             end
%         end
%     end
%     %for not, 0 or -1 depenging. estKernel already 0 padded
%     idealKernel(~find(idealKernel)) = -1;
%     %.* the two then sum sum sum
%     convErr = sum(sum(sum(estKernel.*idealKernel)))/(10^3)
%     %Provides the error
%     %We should probably normalise according to the volumes used. Do we just
%     %adjust the magnitude by the number of elements? or by the total
%     %volume? The volume calculation will be harder to do. instead for now
%     %we'll just do by element to get the values small.
%     
%     %Now that we have code to produce a convolution error, we need to work
%     %on the implementation. The idea is, that after the model has been run,
%     %the boundary won't be quite right. On the subset of f4, we then run an
%     %augmented minimisation. This minimisation will be much the same but
%     %when producing the error values the convolution will be calculated.
%     %For this first test it might take a while, but we'll calculate, on
%     %each adjustment of the f4 point, a whole new mesh to use for the error
%     %in the region. We refine the position of the f4 until we hit a
%     %minimum. Then we move on to the next element of f4. We should probably
%     %loop arround the f4 points until it's stabilised. Then we can move to
%     %the non f4 members of theta and adjust them without considering the
%     %convolution. After we re-adjust the inside, do we retouch the boundary
%     %convolution? It sound like we're going to end up doing the following:
%     
%     %Refine the model using the standard technique. Once an equilibrium is
%     %found, loop through f4 using the new minimisation function which takes
%     %into account the convolution. Once those positions have stabilised,
%     %refine the mesh using the standard techniques. Alternatively, we just
%     %have a repeat of the minimisation algorithm but with the f4 tweak.
%     
%     %If runtime becomes too much of an issue, there's a variety of thins we
%     %can do, such as only calculate the new mesh for the regions that
%     %matter, rather than the whole region. If runtime isn't greatyl
%     %affected by th convolution, we can increase the resoltion of the
%     %kernerls in order to get a better shape conformity.
% end

