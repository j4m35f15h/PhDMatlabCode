clc
clear
O = sym('o',[2 5]); %position of theta
N = sym('n',[2 5]); %Previous position of theta

%Next we set F values according to its definition 
for i = 1:4
    if(i < 4)
        fj(:,:,i)= [O(1,i)-O(1,5) O(1,i+1) - O(1,5);... 
           O(2,i)-O(2,5) O(2,i+1) - O(2,5)]/(...
           [N(1,i)-N(1,5) N(1,i+1) - N(1,5);...
           N(2,i)-N(2,5) N(2,i+1) - N(2,5)]);
       if(i == 1)
           fbar = fj/4;
           continue;
       end
    elseif(i == 4)
        fj(:,:,i)= [O(1,i)-O(1,5) O(1,i-3) - O(1,5);...
           O(2,i)-O(2,5) O(2,i-3) - O(2,5)]/(...
           [N(1,i)-N(1,5) N(1,i-3) - N(1,5);...
           N(2,i)-N(2,5) N(2,i-3) - N(2,5)]);
    end
    fbar = fbar + fj(:,:,i)/4;
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
thetaXargmin = symfun(argmin,O(1,5));
thetaXargmin = diff(thetaXargmin,O(1,5));
thetaXrough  = solve(thetaXargmin == 0,O(1,5));

thetaYargmin = symfun(argmin,O(2,5));
thetaYargmin = diff(thetaYargmin,O(2,5));
thetaYrough  = solve(thetaYargmin == 0,O(2,5));

%Following the above, we now have am expression for the minimum values of
%theta x and y, but we need to separate this into individual coefficients
%for the new values of theta (o1/2_1:4). For this, assmuming the paper is
%correct and the formula we have are just a linear sum of the new theta
%coordinates, we should be able to differentiate the expression by the
%theta values individually, and the coefficients should pop out.
B1X = sym(zeros(1,4));
B1Y = sym(zeros(1,4));
for j = 1:4
    B1X(j) = diff(  symfun(thetaXrough,O(1,j))  ,O(1,j));
    B1Y(j) = diff(  symfun(thetaYrough,O(2,j))  ,O(2,j));
end

%use the subs function to input the old theta values into each of the B
%array slots.
