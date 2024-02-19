function [lattice] = varSolvFMax(in,lattice,theta,f1,f2,x,A,B1,D1,B2,D2,mu1,mu2,precision)
hValLocal = zeros(1,3);
tXHold = 0;

while ~ismembertol(tXHold,lattice(in),precision)
%     tXHold
%     lattice(in)
tXHold = lattice(in);
stepsize = 0.1;
while 1
    hVal = HF(x,A,B1,D1,B2,D2,mu1,mu2,lattice,theta,f1,f2); %latticesolve
    hValLocal(1,2) = hVal;
    lattice(in) = lattice(in) + stepsize;
    hVal = HF(x,A,B1,D1,B2,D2,mu1,mu2,lattice,theta,f1,f2);
    hValLocal(1,3) = hVal;
    lattice(in) = lattice(in) - 2*stepsize;
    hVal = HF(x,A,B1,D1,B2,D2,mu1,mu2,lattice,theta,f1,f2);
    hValLocal(1,1) = hVal;
%     margLikeLocal
    temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))];
    lattice(in) = lattice(in) + stepsize;
%     lattice(in)
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        lattice(in) = lattice(in) + sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
            'mu1 Precision reached'
%             lattice(in)
%             tXHold
            break;
        end
    end
end

stepsize = 0.1;

while 1
    hVal = HF(x,A,B1,D1,B2,D2,mu1,mu2,lattice,theta,f1,f2);
    hValLocal(1,2) = hVal;
    lattice(in +size(lattice,2)/2) = lattice(in +size(lattice,2)/2) + stepsize;
    hVal = HF(x,A,B1,D1,B2,D2,mu1,mu2,lattice,theta,f1,f2);
    hValLocal(1,3) = hVal;
    lattice(in +size(lattice,2)/2) = lattice(in +size(lattice,2)/2) - 2*stepsize;
    hVal = HF(x,A,B1,D1,B2,D2,mu1,mu2,lattice,theta,f1,f2);
    hValLocal(1,1) = hVal;
%     margLikeLocal
    temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))]
%     stepsize;
    lattice(in +size(lattice,2)/2) = lattice(in +size(lattice,2)/2) + stepsize;
%     lattice(in +size(lattice,2)/2)
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        lattice(in +size(lattice,2)/2) = lattice(in +size(lattice,2)/2) + sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
            'mu2 Precision reached'
            break;
        end
    end
end

end
end

