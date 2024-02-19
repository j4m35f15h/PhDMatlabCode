function [B1X,B1Y] = EqnSolveF()

O = sym('o',[2 5]); %Positions of theta
N = sym('n',[2 5]); %Previous position of theta

%Next we set F values symbolically according to its definition 
for i = 1:4
    if(i < 4)
        %Generic definition for each of the four squares
        fj(:,:,i)= [O(1,i)-O(1,5) O(1,i+1) - O(1,5);... 
                    O(2,i)-O(2,5) O(2,i+1) - O(2,5)]/(...
                   [N(1,i)-N(1,5) N(1,i+1) - N(1,5);...
                    N(2,i)-N(2,5) N(2,i+1) - N(2,5)]);
       if(i == 1)
           fbar = fj/4;
           continue;
       end
    elseif(i == 4)
        %Generic definition needs to loop for the fourth square (i.e. uses the first vertices)
        fj(:,:,i)= [O(1,i)-O(1,5) O(1,i-3) - O(1,5);...
           O(2,i)-O(2,5) O(2,i-3) - O(2,5)]/(...
           [N(1,i)-N(1,5) N(1,i-3) - N(1,5);...
           N(2,i)-N(2,5) N(2,i-3) - N(2,5)]);
    end
    fbar = fbar + fj(:,:,i)/4; %Average is updated after each square
end

%We know have symbolic expressions for F and Fbar. All we need to do is do
%the summations as written, differentiate the expression with respect to
%the theta bars (we'll have to do it once for each direction). finding
%where its zero will provide the minimum

argmin = 0;
for j = 1:4 %Direction summation
    for k = 1:2 %First F dimension
        for l = 1:2 %Second F dimention
           argmin = argmin + (fj(k,l,j) - fbar(k,l))^2;
        end
    end
end
thetaXargmin = symfun(argmin,O(1,5)); %Set argmin a function of the center coordinate
thetaXargmin = diff(thetaXargmin,O(1,5)); %differentiate argmin by the center coordinate
thetaXrough  = solve(thetaXargmin == 0,O(1,5)); %Find an expression for the minimum

%Same as above but for the y coordinate
thetaYargmin = symfun(argmin,O(2,5));
thetaYargmin = diff(thetaYargmin,O(2,5));
thetaYrough  = solve(thetaYargmin == 0,O(2,5));

%We now have an expression for minimum in the argmin. This expression
%is a function of the old and new coordinates of theta. The old coordinates
%are fixed, however the new coordinates change with each lattice iteration.
%The expression can be re-arranged as a linear sum of the new coordinates,
%whose coefficients are a combination of the old coordinates and are found
%by differentiating the expression by each of the new coordinates in turn.

B1X = sym(zeros(1,4)); %Variables to store the coefficient expression of...
B1Y = sym(zeros(1,4)); %the second differentiations

for j = 1:4 %For each of the non-center lattice coordinates...
    B1X(j) = diff(  symfun(thetaXrough,O(1,j))  ,O(1,j)); %Save the differentiation of the minimum.
    B1Y(j) = diff(  symfun(thetaYrough,O(2,j))  ,O(2,j));
end

end




