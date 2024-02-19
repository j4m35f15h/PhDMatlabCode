function [outputArg1,outputArg2] = Main(Old_Coor,New_Coor)
%MAIN Runs the morshita model.
%   Detailed explanation goes here
%Inputs will need to be the original coordinates and the final coordinates.
%These will need to be in the form of line vectors, which have the X
%coordinates, then the y coordinates. If the program is generalised enough,
%the 3D framework might not even need to be considered.

%The output of the model will be the new lattice points. Another function
%can then calculate the defromation strain tensor for each square region.

%First things first, we should provide the model with a way to calculate
%the coefficients. This will involve the use of EqnSolve. We'll re-write
%the script as a function that outputs the eqn and takes in the dimensions
%(i.e. 2 or 3)

%We need to decide what the inputs for the model are going to look like. We
%need the coordinates of the lattice present in the calculation domain, the
%coordinates of the lattice defined as being on the boundary, and the two
%coordinates defined as the edge of the boundary. We will also need a way
%of know which coordinates are connected to each other as the majority of
%the matrices used will be zeroed for non-connected coordinates. The format 
%for the coordinates is the x values followed by the y values in one long
%row vector. If we wish to extend to three dimensions, we will need to add
%the z coordinates to the end of the data.

[B1X,B1Y] = EqnSolveF();
B1 = [B1X,B1Y];

%Lets calculate the value of the interpolation coefficient. Rather than
%calcualte it point by point, it makes sense to attempt to caluclate this
%region by region. Point by point would make it difficult to find the
%neighbouring lattice points. We won't look for points outside of the
%calculation domain, so we only have to work within the lattice
%coordinates.
%Due to this, it makes sense to work with a mesh file. Contained within the
%mesh file are indexed coordinates with the columns corresponding to X,Y.
%The file can also have faces which will have between 2:4 values. It will
%therefore be an M1x4 matrix, with NaN values for fewer connections. This 
%is a standardised formatting, but it will be useful to process the data so
%that we have an indexed list of squares w/o duplicates. The matrix will
%have a number of rows equal to the number of squares, and have 4 columns,
%which represent the indexes of the vertices which ... this is basically
%the faces array without duplicates. I believe we assume there are no
%squares for points that include boindary coordinates, so the faces list
%will only contain non-boundary points. 

%We will need to come up with a way to extract the boundary points. In the
%end, we may ahave a generalised lattice, then superimpose the rudiment.
%Where the rudiment partially envelops will be considered the calculation
%domain. The lattice points connected to but not part of the calculation
%domin will be considered boundary points.

%W = interpolationCoef();
%This function requires a point of interest, as well as the lattice
%coordinates for the square it's in. 

%First to process the data, we can make a face ID matrix which contains the
%index of which faces contain the coordinate. This may be harder than we
%first thought
% for i = 1:size(X)/2
%     j = 1;
%     while(1)
%          if(  X(i) > faces(j,1)  )
%              j = j+1;
%          elseif X(i+size(X)/2) > faces(j,2)
%             
%          end
%     end
% end

% lattice = [0.1 0.2 1 1 1 2 2 0 1.1 0 1.3 2 1 2];
% faces = [1 2 3 4; 4 5 6 7];
% X = [0.25 1.25 0.755 0.5 1.5 0.75];

%Faces needs to be specified in a clockwise direction!!!!!!!!!!
faceID = faceIDFind(X,lattice,faces);
A = ASolve(X,lattice,faces,faceID);

%B1 currently contains the equations describing the values of how the
%lattice points in the old neighborhood affect the present theta values.
%For each point in the lattice we need to substitute the values in. Let's
%be consistent and always use the top value (highest Y). 

% lattice = [0 0 0 1 1 1 2 2 2 0 1 2 0 1 2 0 1 2];
% faces = [1 2 4 5; 2 3 5 6;4 5 7 8;5 6 8 9];
% neighbour4(5,lattice,faces)

%Connected lattice point might be a useful thing to hold on to so we'll
%have a variable for the entire calculation domain of the lattice.
%current problem is edge cases, needs to be dealt with

%We're defining the lattice. The indexes hold information about the
%connections: 1 before, 1 after, 1 a row before, 1 a row after.

%When creating the lattice, we might want to include the number of rows and
%number of columns as the variables: rows and cols

% lattice = [0 1 2 0 1 2 0 1 2 0 0 0 1 1 1 2 2 2 ];
% faces = [4 5 2 1;5 6 2 3;7 8 4 5;8 9 6 5];
% cols = 3;
local = neighbours(5,lattice,cols);

%At this point, we have the X and Y coordinates of the lattice point's
%neighbours. Then we need to substitute these values into the symbolic
%functions we created at the beginning of our model.



outputArg1 = Old_Coor;
outputArg2 = New_Coor;
end

