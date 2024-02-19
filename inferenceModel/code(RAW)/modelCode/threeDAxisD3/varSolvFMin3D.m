function [lattice] = varSolvFMin3D(in,lattice,theta,f1,f2,x,U,precision)
%VARSOLVFMIN Summary of this function goes here
%   Detailed explanation goes here
hValLocal = zeros(1,3);
tXHold = 0;
while ~ismembertol(tXHold,lattice(in),precision)
%     tXHold
%     lattice(in)
tXHold = lattice(in);
stepsize = 5;
while 1
    hVal = HF3D(x,U,lattice,theta,f1,f2); %latticesolve
    hValLocal(1,2) = hVal;
    lattice(in) = lattice(in) + stepsize;
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,3) = hVal;
    lattice(in) = lattice(in) - 2*stepsize;
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,1) = hVal;
%     margLikeLocal
    temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))];
    lattice(in) = lattice(in) + stepsize;
%     lattice(in)
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        lattice(in) = lattice(in) - sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
%              'Precision reached'
%             lattice(in)
%             tXHold
            break;
        end
    end
end

stepsize = 5;

while 1
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,2) = hVal;
    lattice(in +size(lattice,2)/3) = lattice(in +size(lattice,2)/3) + stepsize;
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,3) = hVal;
    lattice(in +size(lattice,2)/3) = lattice(in +size(lattice,2)/3) - 2*stepsize;
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,1) = hVal;
%     margLikeLocal
    temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))];
%     stepsize;
    lattice(in +size(lattice,2)/3) = lattice(in +size(lattice,2)/3) + stepsize;
%     lattice(in +size(lattice,2)/2)
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        lattice(in +size(lattice,2)/3) = lattice(in +size(lattice,2)/3) - sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
%             'mu2 Precision reached'
            break;
        end
    end
end

stepsize = 5;
while 1
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,2) = hVal;
    lattice(in +2*size(lattice,2)/3) = lattice(in +2*size(lattice,2)/3) + stepsize;
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,3) = hVal;
    lattice(in +2*size(lattice,2)/3) = lattice(in +2*size(lattice,2)/3) - 2*stepsize;
    hVal = HF3D(x,U,lattice,theta,f1,f2);
    hValLocal(1,1) = hVal;
%     margLikeLocal
    temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))];
%     stepsize;
    lattice(in +2*size(lattice,2)/3) = lattice(in +2*size(lattice,2)/3) + stepsize;
%     lattice(in +size(lattice,2)/2)
    if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
        lattice(in +2*size(lattice,2)/3) = lattice(in +2*size(lattice,2)/3) - sign(find(temp<0)-1.5)*stepsize;
        continue;
    end
    if diff(temp) == 0 || temp(1)*temp(2) == 0
        stepsize = stepsize*0.1;
        if stepsize<precision
%             'mu2 Precision reached'
            break;
        end
    end
end

end

end
