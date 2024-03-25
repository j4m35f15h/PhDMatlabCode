function [mu1,mu2,mu3] = varSolvF3D3(x,A,B1,D1,B2,D2,B3,D3,precision)

%Initial run to compare to.
margLikeLocal = zeros(1,3);
mu1 = 0.1;
mu2 = 0.01;
mu3 = 0.01;
mu1Hold = 0;

while ~ismembertol(mu1Hold,mu1,precision)
mu1Hold = mu1;
stepsize = 0.01;
while 1
%     latticesolve3D
    margLikeLocal(1,2) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
    mu1 = mu1 + stepsize;
%     latticesolve3D
    margLikeLocal(1,3) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
    mu1 = mu1 - 2*stepsize;
%     latticesolve3D
    margLikeLocal(1,1) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
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

stepsize = 0.001;

while 1
%     latticesolve3D
    margLikeLocal(1,2) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
    mu2 = mu2 + stepsize;
%     latticesolve3D
    margLikeLocal(1,3) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
    mu2 = mu2 - 2*stepsize;
%     latticesolve3D
    margLikeLocal(1,1) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
%     margLikeLocal
    temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(margLikeLocal(2)-margLikeLocal(3))];
%     stepsize;
    mu2 = mu2 + stepsize;
%     temp
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

stepsize = 0.001;

while 1
%     latticesolve3D
    margLikeLocal(1,2) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
    mu3 = mu3 + stepsize;
%     latticesolve3D
    margLikeLocal(1,3) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
    mu3 = mu3 - 2*stepsize;
%     latticesolve3D
    margLikeLocal(1,1) = latticesolve3DF3(x,A,B1,D1,B2,D2,B3,D3,mu1,mu2,mu3);
%     margLikeLocal
    temp = [sign(margLikeLocal(2)-margLikeLocal(1)),sign(margLikeLocal(2)-margLikeLocal(3))];
%     stepsize;
    mu3 = mu3 + stepsize;
%     temp
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        mu3 = mu3 + sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
            mu3
%             'mu3 Precision reached'
            break;
        end
    end
end

end

