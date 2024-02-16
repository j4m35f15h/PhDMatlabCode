function [B2Eqn] = eqnSolveF3D2()
%EQNSOLVEF3D2 Summary of this function goes here
%   Detailed explanation goes here
O = sym('o',[3 5]); %position of theta. Order defined by neighbour function.
N = sym('n',[3 5]); %Previous position of theta
C = [1,2; ... %Square edge definitions.
    2,3;...
    3,4;...
    4,1];
%Next we set F values according to its definition 
for i = 1:4
%     fj(:,:,i)= [O(1,C(i,1))-O(1,5) O(1,C(i,2))-O(1,5);...
%         O(2,C(i,1))-O(2,5) O(2,C(i,2))-O(2,5);...
%         O(3,C(i,1))-O(3,5) O(3,C(i,2))-O(3,5)]/...
%         [N(1,C(i,1))-N(1,5) N(1,C(i,2))-N(1,5);...
%         N(2,C(i,1))-N(2,5) N(2,C(i,2))-N(2,5);...
%         N(3,C(i,1))-N(3,5) N(3,C(i,2))-N(3,5)];
    fj(:,:,i) = [O(1,C(i,1))-O(1,5) O(1,C(i,2))-O(1,5);...
                 O(2,C(i,1))-O(2,5) O(2,C(i,2))-O(2,5);...
                 O(3,C(i,1))-O(3,5) O(3,C(i,2))-O(3,5)]...
                 *pinv([N(1,C(i,1))-N(1,5) N(1,C(i,2))-N(1,5);...
                 N(2,C(i,1))-N(2,5) N(2,C(i,2))-N(2,5);...
                 N(3,C(i,1))-N(3,5) N(3,C(i,2))-N(3,5)]);
    if(i == 1)
        fbar = fj/4;
        continue;
    end
    fbar = fbar + fj(:,:,i)/4;
%     if(i < 7)
%         fj(:,:,i)= [O(1,i)-O(1,10) O(1,i+1)-O(1,9) O(1,i+2)-O(1,9);...
%             O(2,i)-O(2,9) O(2,i+1)-O(2,9) O(2,i+2)-O(2,9);...
%             O(3,i)-O(3,9) O(3,i+1)-O(3,9) O(3,i+2)-O(3,9)]/(...
%            [N(1,i)-N(1,9) N(1,i+1)-N(1,9) N(1,i+2)-N(1,9);...
%             N(2,i)-N(2,9) N(2,i+1)-N(2,9) N(2,i+2)-N(2,9);...
%             N(3,i)-N(3,9) N(3,i+1)-N(3,9) N(3,i+2)-N(3,9)]);
%        if(i == 1)
%            fbar = fj/4;
%            continue;
%        end
%     elseif(i == 7)
%         fj(:,:,i) = [O(1,i)-O(1,9) O(1,i+1)-O(1,9) O(1,1)-O(1,9);...
%             O(2,i)-O(2,9) O(2,i+1)-O(2,9) O(2,1)-O(2,9);...
%             O(3,i)-O(3,9) O(3,i+1)-O(3,9) O(3,1)-O(3,9)]/(...
%            [N(1,i)-N(1,9) N(1,i+1)-N(1,9) N(1,1)-N(1,9);...
%             N(2,i)-N(2,9) N(2,i+1)-N(2,9) N(2,1)-N(2,9);...
%             N(3,i)-N(3,9) N(3,i+1)-N(3,9) N(3,1)-N(3,9)]);
%     elseif(i == 8)
%         fj(:,:,i) = [O(1,i)-O(1,9) O(1,1)-O(1,9) O(1,2)-O(1,9);...
%             O(2,i)-O(2,9) O(2,1)-O(2,9) O(2,2)-O(2,9);...
%             O(3,i)-O(3,9) O(3,1)-O(3,9) O(3,2)-O(3,9)]/(...
%            [N(1,i)-N(1,9) N(1,1)-N(1,9) N(1,2)-N(1,9);...
%             N(2,i)-N(2,9) N(2,1)-N(2,9) N(2,2)-N(2,9);...
%             N(3,i)-N(3,9) N(3,1)-N(3,9) N(3,2)-N(3,9)]);
%     end
%     fbar = fbar + fj(:,:,i)/4;
end

%We know have symbolic expressions for F and Fbar. All we need to do is do
%the summations as written, differentiate the expression with respect to
%the theta bars (we'll have to do it once for each direction). finding
%where its zero will provide the minimum
argmin = 0;
for j = 1:4 %Direction summation
    for k = 1:3 %First F dimension
        for l = 1:2 %Second F dimention
           argmin = argmin + (fj(k,l,j) - fbar(k,l))^2;
        end
    end
end
thetaXargmin = symfun(argmin,O(1,5));
thetaXargmin = diff(thetaXargmin,O(1,5));
thetaXrough  = solve(thetaXargmin == 0,O(1,5));

thetaYargmin = symfun(argmin,O(2,5));
thetaYargmin = diff(thetaYargmin,O(2,5));
thetaYrough  = solve(thetaYargmin == 0,O(2,5));

thetaZargmin = symfun(argmin,O(3,5));
thetaZargmin = diff(thetaZargmin,O(3,5));
thetaZrough  = solve(thetaZargmin == 0,O(3,5));

%Following the above, we now have am expression for the minimum values of
%theta x and y, but we need to separate this into individual coefficients
%for the new values of theta (o1/2_1:4). For this, assmuming the paper is
%correct and the formula we have are just a linear sum of the new theta
%coordinates, we should be able to differentiate the expression by the
%theta values individually, and the coefficients should pop out.
B2X = sym(zeros(1,4));
B2Y = sym(zeros(1,4));
B2Z = sym(zeros(1,4));
for j = 1:4
    B2X(j) = diff(  symfun(thetaXrough,O(1,j))  ,O(1,j));
    B2Y(j) = diff(  symfun(thetaYrough,O(2,j))  ,O(2,j));
    B2Z(j) = diff(  symfun(thetaZrough,O(3,j))  ,O(3,j));
end
B2Eqn = [B2X,B2Y,B2Z];
end

