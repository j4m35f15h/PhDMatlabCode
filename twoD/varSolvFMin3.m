function [lattice] = varSolvFMin3(in,lattice,theta,f1,f2,x,U,precision)
%VARSOLVFMIN2 Summary of this function goes here
%   Detailed explanation goes here
N = size(lattice,2)/2;
hValLocal = zeros(1,3);

%     tXHold
%     lattice(in)
stepsize = 5;
while 1
    tXHold = 0;
    while ~ismembertol(tXHold,lattice(in),precision)
        tXHold = lattice(in);
        for j = [0 1]
            hValLocal = zeros(1,3);
            while 1
                for i = 1:3
                    if hValLocal(1,i) == 0
                        lattice(in+j*N) = lattice(in+j*N) + (i-2)*stepsize;
                        hValLocal(1,i) = HF(x,U,lattice,theta,f1,f2);
                        lattice(in+j*N) = lattice(in+j*N) - (i-2)*stepsize;
                    end
                end
                temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))];
                %     lattice(in) = lattice(in) + stepsize;
                %     lattice(in)
                if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0
                    if find(temp<0) == 1
                        hValLocal(1) = hValLocal(2);
                        hValLocal(2) = hValLocal(3);
                        hValLocal(3) = 0;
                    elseif find(temp<0) == 2
                        hValLocal(3) = hValLocal(2);
                        hValLocal(2) = hValLocal(1);
                        hValLocal(1) = 0;
                    end
                    lattice(in+j*N) = lattice(in+j*N) - sign(find(temp<0)-1.5)*stepsize;
                    continue;
                end
                if diff(temp) == 0 || temp(1)*temp(2) == 0

                    break;
                end
            end
        end
    end
    stepsize = stepsize*0.1;
    if stepsize<precision
        %             'mu1 Precision reached'
        %             lattice(in)
        %             tXHold
        break;
    end
end
end

