figure
hold on
scatter3(lattice(1,theta),lattice(1,theta+N),lattice(1,theta+2*N))
scatter3(lattice(1,f1),lattice(1,f1+N),lattice(1,f1+2*N))
scatter3(lattice(1,f2),lattice(1,f2+N),lattice(1,f2+2*N))
% scatter3(lattice(1,f3),lattice(1,f3+N),lattice(1,f3+2*N))
scatter3(X(1:end/3),X(1+end/3:2*end/3),X(1+2*end/3:end))
patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','blue')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold off