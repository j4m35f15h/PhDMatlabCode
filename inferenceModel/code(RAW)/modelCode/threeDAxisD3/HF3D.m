function [H] = HF3D(temp,cArray,lattice,theta,f1,f2)
%HF3D provides a value for the H function given the current lattice
%estimate stored in "lattice"

N = size(lattice,2)/3;

H = norm( temp - cArray*[lattice(theta)';lattice(theta + N)';lattice(theta + 2*N)';...
                  lattice(f1)';lattice(f1 + N)';lattice(f1 + 2*N)';...
                  lattice(f2)';lattice(f2 + N)';lattice(f2 + 2*N)']);

end

