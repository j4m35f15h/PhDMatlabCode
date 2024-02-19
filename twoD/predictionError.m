function [xError,yError,magError] = predictionError(x,latticeNew,theta,A)
%PREDICTIONERROR Summary of this function goes here
%   Prediction error conveys the model's ability to predict the location of
%   our marker data in the second time frame. It is useful if we want to
%   incorporate cross-validation into the model. The easiest way for us to
%   do this is to compare the transformed data x to the interpolation
%   coefficients held within A times the lattice coordinates.
xExp = A*[latticeNew(theta),latticeNew(theta + size(latticeNew,2)/2)]';
xError = 0;
yError = 0;
N = size(A,1)/2;
for i = N
    xError = xError + (xExp(i)-x(i))^2;
    yError = yError + (xExp(i + N) - x(i + N))^2;
end 
xError = sqrt(xError/N);
yError = sqrt(yError/N);
magError = sqrt(xError.^2 + yError.^2);
end

