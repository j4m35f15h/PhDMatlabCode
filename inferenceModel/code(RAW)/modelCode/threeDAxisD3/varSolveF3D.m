function [mu1,mu2] = varSolveF3D(x,A,B1,D1,B2,D2,precision)
%varSolveF3D calculates the relative variances of the prior distributions.
%The marginal likelihood needs to be maximised, the equation of which is
%derived in Morishita et al 2014 (Eqn 16). This function uses a course-fine
%algorithm for the maximisation

%Initial run for a baseline.
margLikeLocal = zeros(1,3);
mu1 = 2; %Starting variance estimates
mu2 = 3; %Will differ based on relationship between data and prior distributions
mu1Hold = 0;

while ~ismembertol(mu1Hold,mu1,precision) %While the desired precision hasn't been reached
mu1Hold = mu1;
stepsize = 1;
while 1 %Repeating loop to iterate mu1
    
    %Calculate variance in marginal likelihood over small space of mu1
    margLikeLocal(1,2) = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2);
    mu1 = mu1 + stepsize;

    margLikeLocal(1,3) = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2);
    mu1 = mu1 - 2*stepsize;

    margLikeLocal(1,1) = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2);

    %Identify slope of local area
    temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(margLikeLocal(2)-margLikeLocal(3))];
    
    %Prints mu1 to identify progress.
    mu1 = mu1 + stepsize
    
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0 %If the sign of the gradient is constant and non-zero*
        mu1 = mu1 + sign(find(temp<0)-1.5)*stepsize; %Move in the direction of the positive gradient
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0 %If at a maximum (i.e. sign of the gradient has changed)
        stepsize = stepsize*0.1; %reduce the stepsize by a factor of 10
        if stepsize<precision %Check to see if desired precision has been reached
            mu1
            break;
        end
    end
end

stepsize = 1; %Reset stepsize from maximising mu1


while 1 %Repeating loop to iterate mu2
    
    %Calculate variance in marginal likelihood over small space of mu2
    margLikeLocal(1,2) = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2);
    mu2 = mu2 + stepsize;

    margLikeLocal(1,3) = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2);
    mu2 = mu2 - 2*stepsize;

    margLikeLocal(1,1) = margLike3DF(x,A,B1,D1,B2,D2,mu1,mu2);

    %Identify slope of local area
    temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(margLikeLocal(2)-margLikeLocal(3))];

    %Prints mu1 to identify progress.
    mu2 = mu2 + stepsize

    
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0 %If the sign of the gradient is constant and non-zero*
        mu2 = mu2 + sign(find(temp<0)-1.5)*stepsize; %Move in the direction of the positive gradient
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0 %If at a maximum (i.e. sign of the gradient has changed)
        stepsize = stepsize*0.1; %reduce the stepsize by a factor of 10
        if stepsize<precision %Check to see if desired precision has been reached
            mu2
            break;
        end
    end
    %Loop retuns to start and iterates mu1 and mu2 again
end %Loop will end when successive iterations of mu1 identify same value at desired precision

end


end

