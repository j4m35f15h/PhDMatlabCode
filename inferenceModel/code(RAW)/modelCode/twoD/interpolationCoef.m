function [w] = interpolationCoef(theta,X)
%INTERPOLATIONCOEF - returns a line of w for a single point.
%W has 4 elements for each of the points, and is a definition of the
%relative position between the center of the square and lattice coordinate. dx
%and dy must be calculated each time and represent the distance betwen the
%lattice coordinate and the center of the region.

%As inputs, let's assume that we have the 4 lattice coordinates, as well as
%the point of interest, X
w = zeros(1,4);
C = zeros(1,2);
C(1) = sum(theta(1:4))/4;%x value of the centre of the face
C(2) = sum(theta(5:8))/4;%y value of the centre of the face
 
it = [2 1 4 3];%Accounting for order of the face vertices.
%Substituting the values into the interpolation coefficient equation
w(it(1)) = .25*(1- (X(1) - C(1)) / abs((theta(1) - C(1))) )*...
        (1+ (X(2) - C(2)) / abs((theta(4+2) - C(2))) );
    
w(it(2)) = .25*(1- (X(1) - C(1)) / abs((theta(2) - C(1))) )*...
        (1- (X(2) - C(2)) / abs((theta(4+1) - C(2))) );
    
w(it(3)) = .25*(1+ (X(1) - C(1)) / abs((theta(3) - C(1))) )*...
        (1- (X(2) - C(2)) / abs((theta(4+4) - C(2))) );
    
w(it(4)) = .25*(1+ (X(1) - C(1)) / abs((theta(4) - C(1))) )*...
        (1+ (X(2) - C(2)) / abs((theta(4+3) - C(2))) );
end

