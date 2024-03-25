function [B1X,B1Y,B1Z] = EqnSolveF3D()
%EqnSolveF3D creates a symbolic algebra expression to describe the
%minimisation of the growth variance in neighbouring cubes in terms of the
%coordinates of the six closest neighbours. 
%(See Eqn (7a) of Morishita et al. 2014)

O = sym('o',[3 7]); %position of theta. Order defined by neighbour function.
N = sym('n',[3 7]); %Previous position of theta
C = [1,4,6; ... %Cube edge definitions, with indices obtained when using the neighbour function.
    1,5,4; ...
    1,2,5; ...
    1,6,2; ...
    3,4,6; ...
    3,5,4; ...
    3,2,5; ...
    3,6,2];
%Next we set F values according to its definition 
for i = 1:8 %for each cube...
    %... define the f tensor...
    fj(:,:,i)= [O(1,C(i,1))-O(1,7) O(1,C(i,2))-O(1,7) O(1,C(i,3))-O(1,7);...
        O(2,C(i,1))-O(2,7) O(2,C(i,2))-O(2,7) O(2,C(i,3))-O(2,7);...
        O(3,C(i,1))-O(3,7) O(3,C(i,2))-O(3,7) O(3,C(i,3))-O(3,7)]/(...
        [N(1,C(i,1))-N(1,7) N(1,C(i,2))-N(1,7) N(1,C(i,3))-N(1,7);...
        N(2,C(i,1))-N(2,7) N(2,C(i,2))-N(2,7) N(2,C(i,3))-N(2,7);...
        N(3,C(i,1))-N(3,7) N(3,C(i,2))-N(3,7) N(3,C(i,3))-N(3,7)]);
    %... and construct the average
    if(i == 1) %
        fbar = fj/8;
        continue;
    end
    fbar = fbar + fj(:,:,i)/8;
end

%We know have symbolic expressions for F and Fbar. All we need to do is do
%the summations as written in the thesis, differentiate the expression with respect to
%the theta bars (we'll have to do it once for each direction). finding
%where its zero will provide the minimum.

argmin = 0; %the expression to be minimised
for j = 1:8 %Direction summation
    for k = 1:3 %First F dimension
        for l = 1:3 %Second F dimention
           argmin = argmin + (fj(k,l,j) - fbar(k,l))^2;
        end
    end
end
%Differentiate each of the expression with respect to the center coordinate
thetaXargmin = symfun(argmin,O(1,7));
thetaXargmin = diff(thetaXargmin,O(1,7));
thetaXrough  = solve(thetaXargmin == 0,O(1,7));

thetaYargmin = symfun(argmin,O(2,7));
thetaYargmin = diff(thetaYargmin,O(2,7));
thetaYrough  = solve(thetaYargmin == 0,O(2,7));

thetaZargmin = symfun(argmin,O(3,7));
thetaZargmin = diff(thetaZargmin,O(3,7));
thetaZrough  = solve(thetaZargmin == 0,O(3,7));

%Following the above, we now have am expression for the minimum values of
%theta x and y, but we need to separate this into individual coefficients
%for the new values of theta (o1/2/3_1:6). For this, assmuming Morishita et al,2014 is
%correct and the formula we have are just linear sums of the new theta
%coordinates, we should be able to differentiate the expression by the old
%theta values individually, and obtain the coefficients.
B1X = sym(zeros(1,6));
B1Y = sym(zeros(1,6));
B1Z = sym(zeros(1,6));
for j = 1:6
    B1X(j) = diff(  symfun(thetaXrough,O(1,j))  ,O(1,j));
    B1Y(j) = diff(  symfun(thetaYrough,O(2,j))  ,O(2,j));
    B1Z(j) = diff(  symfun(thetaZrough,O(3,j))  ,O(3,j));
end
end