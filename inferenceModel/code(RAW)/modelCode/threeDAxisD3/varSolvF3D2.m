function [mu1] = varSolvF3D2(x,A,B1,D1,precision)

%Initial run to compare to.
margLikeLocal = zeros(1,3);
mu1 = 1;
mu1Hold = 0;

while ~ismembertol(mu1Hold,mu1,precision)
mu1Hold = mu1;
stepsize = 0.1;
while 1
%     latticesolve3D2
%     margLikeLocal(1,2) = margLike;
    margLikeLocal(1,2) = margLike;
    mu1 = mu1 + stepsize;
%     latticesolve3D2
%     margLikeLocal(1,3) = margLike;
    mu1 = mu1 - 2*stepsize;
%     latticesolve3D2
%     margLikeLocal(1,1) = margLike;
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


end


end

