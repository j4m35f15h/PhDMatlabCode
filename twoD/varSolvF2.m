function [mu1,mu2] = varSolvF2(x,A,B1,D1,B2,D2)

f = @(mu,x,A,B1,D1,B2,D2)LF(mu,x,A,B1,D1,B2,D2);
fun = @(mu)f(mu,x,A,B1,D1,B2,D2);
mu0 = [0.02 0.02];
options = optimset('Display','iter','PlotFcns',@optimplotfval,'MaxFunEvals',200000,'MaxIter',200000);
[mu,fval,exitflag,output] = fminsearch(fun,mu0,options);
% mu = fminsearch(fun,mu0);
mu1 = mu(1);
mu2 = mu(2);
end

