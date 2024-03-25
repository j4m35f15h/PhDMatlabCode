function [H] = HF3DCE(temp,U,lattice,theta,f1,f2,f4)

%Not quite true U, no coordinates appended to side.
N = size(lattice,2)/3;

H = norm( temp - U*[lattice(theta)';lattice(theta + N)';lattice(theta + 2*N)';...
                  lattice(f1)';lattice(f1 + N)';lattice(f1 + 2*N)';...
                  lattice(f2)';lattice(f2 + N)';lattice(f2 + 2*N)']);

end

