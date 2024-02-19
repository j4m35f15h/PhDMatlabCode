function [mu1,mu2] = varSolvF(x,A,B1,D1,B2,D2,precision)
%This function performs the maximisation of the marginal likelihood function to find the variance values
%   creates U with some sample values of variance. performs the
%   decomposition. forms the likelihood function and calculates magnitude.
%   Adjusts value of mu1, performs the above again, then compares the
%   value. If the value has increased, continue to move the variable in
%   that direction until the value decreases. Decrease the value of the
%   step, then add it to the old value. Repeat until we reach some
%   previously described precision, such as 3dp etc. Perform for the other
%   variable. Loop until no change is seen.


%Initial run to compare to.
margLikeLocal = zeros(1,3);
mu1 = 0.4;
mu2 = 0.04;
mu1Hold = 0;

while ~ismembertol(mu1Hold,mu1,precision)
mu1Hold = mu1;
stepsize = 0.1;
while 1
%     latticesolve
    margLike = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x);
    margLikeLocal(1,2) = margLike;
    mu1 = mu1 + stepsize;
%     latticesolve
    margLike = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x);
    margLikeLocal(1,3) = margLike;
    mu1 = mu1 - 2*stepsize;
%     latticesolve
    margLike = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x);
    margLikeLocal(1,1) = margLike;
%     margLikeLocal
    temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(margLikeLocal(2)-margLikeLocal(3))];
    mu1 = mu1 + stepsize;
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        mu1 = mu1 + sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
%             'mu1 Precision reached'
            mu1
%             mu1Hold
            break;
        end
    end
end

stepsize = 0.01;

while 1
%     latticesolve
    margLike = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x);
    margLikeLocal(1,2) = margLike;
    mu2 = mu2 + stepsize;
%     latticesolve
    margLike = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x);
    margLikeLocal(1,3) = margLike;
    mu2 = mu2 - 2*stepsize;
%     latticesolve
    margLike = latticeSolveF(A,B1,D1,B2,D2,mu1,mu2,x);
    margLikeLocal(1,1) = margLike;
%     margLikeLocal
    temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(margLikeLocal(2)-margLikeLocal(3))];
%     stepsize;
    mu2 = mu2 + stepsize;
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        mu2 = mu2 + sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
            mu2
%             'mu2 Precision reached'
            break;
        end
    end
end

end

% while 1
%     latticesolve
%     margLikeLocal(1,2) = margLike;
%     mu2 = mu2 + stepsize;
%     latticesolve
%     margLikeLocal(1,3) = margLike;
%     mu2 = mu2 - 2*stepsize;
%     latticesolve
%     margLikeLocal(1,1) = margLike;
%     margLikeLocal
%     temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(sign(margLikeLocal(2)-margLikeLocal(3)))]
%     mu2 = mu2 + stepsize
%     if diff(temp) ~= 0
%         if mu2 + sign(find(temp<0)-1.5)*stepsize < precision
%             stepsize = stepsize * 0.1;
%             continue
%         end
%         mu2 = mu2 + sign(find(temp<0)-1.5)*stepsize;
%         continue;
%     end
%     if diff(temp) == 0
%         stepsize = stepsize*0.1;
%         if stepsize<precision
%             'mu2 Precision reached'
%             mu2
%             break;
%         end
%     end
% end

% while 1 
% %Look forward some step. If the difference in value between the step and
% %current location is negative, go back two spaces and find the value. if
% %the sign is still negative, go back to the original spot, decrease the
% %step size and return to step one. if the sign is positive, then keep
% %going.
% signt = 1;
% mu1 = mu1+stepsize*signt;
% comp = margLike;
% latticesolve
% signt = sign(margLike - comp);
% if signt < 0
%     stepsize
%     mu1 = mu1+stepsize*signt
%     comp = margLike
%     latticesolve
%     signt = sign(margLike - comp)
%     if signt < 0
%         mu1 = mu1-stepsize*signt;
%         stepsize = stepsize*.1;
%         'precision stepped'
%         if stepsize < precision
%             'variable 1 complete'
%             break;
%         end
%         continue;
%     end
% end
% 
% end
% 
% stepsize = 0.1;
% latticesolve;
% 
% while 1 
%     
% signt = 1;
% mu2 = mu2+stepsize*signt;
% comp = margLike;
% latticesolve
% signt = sign(margLike - comp);
% if signt < 0
%     mu2 = mu2+2*stepsize*signt;
%     comp = margLike;
%     latticesolve
%     signt = sign(margLike - comp);
%     if signt < 0
%         mu2 = mu2-stepsize*signt;
%         stepsize = stepsize*.1;
%         if stepsize < precision
%             break;
%         end
%         continue;
%     end
% end

end

