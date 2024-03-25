function [lattice] = latticeMin3D(in,lattice,theta,f1,f2,x,cArray,precision)
%VARSOLVFMIN3D2 minimises the H function as a function of a single lattice
%intersection provided by the index "in". Uses a course-fine algorithm to
%find the coordinate for "in" which minimises the H function.

N = size(lattice,2)/3;
tXHold = -inf; %initialisation of the coordinate comparison

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%Initial stepsize for the coordinate adjustment
%Needs to be manually adjusted to order of magnitude of relevant
%length scale / units
initStepsize = 100;


while ~ismembertol(tXHold,lattice(in),precision)
    %Set comparison to pre-adjusted coordinate
    tXHold = lattice(in);
    
    for j = [0 1 2] %For each dimension of the coordinate
        stepsize = initStepsize;  %Reset stepsize
        hValLocal = zeros(1,3);
        while 1 %Until a minimum is found
            for i = 1:3 %For a local area
                if hValLocal(1,i) == 0 %If the value of H is not known
                    lattice(in+j*N) = lattice(in+j*N) + (i-2)*stepsize;  %Adjust step to missing position
                    hValLocal(1,i) = HF3D(x,cArray,lattice,theta,f1,f2); %Fill with the value of H
                    lattice(in+j*N) = lattice(in+j*N) - (i-2)*stepsize;  %Reset step
                end
            end
            
            %Find the gradient over the local area
            temp = [sign(hValLocal(2)-hValLocal(1)),sign(hValLocal(2)-hValLocal(3))];

            if diff(temp) ~= 0 && temp(1)*temp(2) ~= 0 %If a minimum is not found
                if find(temp<0) == 1 %If the negative gradient is on the right, shift the local area right
                    hValLocal(1) = hValLocal(2);
                    hValLocal(2) = hValLocal(3);
                    hValLocal(3) = 0;
                elseif find(temp<0) == 2 %If the negative gradient is on the left, shift the local area left
                    hValLocal(3) = hValLocal(2);
                    hValLocal(2) = hValLocal(1);
                    hValLocal(1) = 0;
                end
                lattice(in+j*N) = lattice(in+j*N) - sign(find(temp<0)-1.5)*stepsize; %Shift the coordinate to follow local area
                continue;
            end
            if diff(temp) == 0 || temp(1)*temp(2) == 0 %If a minimum is found
                stepsize = stepsize*0.1; %Reduce the stepsize by a factor of 10
                hValLocal(1) = 0; %Clear the left and right values of the local area...
                hValLocal(3) = 0; %...to be replaced with values at a higher resolution
                
                if stepsize<precision %If the desired precision is reached, terminate
                    break;
                end
            end
        end %Repeat until a minimum is found at the desired precision...

    end %...for each dimension in turn...

end %...until the x coordinate is no longer adjusted on siccessive iterations
end

