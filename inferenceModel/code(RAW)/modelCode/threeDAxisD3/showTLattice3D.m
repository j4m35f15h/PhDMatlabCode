M1 = size(X,2)/3;
figure
hold on
scatter3(trueLattice(1,theta),trueLattice(1,theta+N),trueLattice(1,theta+2*N))
scatter3(trueLattice(1,f1),trueLattice(1,f1+N),trueLattice(1,f1+2*N))
scatter3(trueLattice(1,f2),trueLattice(1,f2+N),trueLattice(1,f2+2*N))
scatter3(x(1,1:M1),x(1,M1+1:2*M1),x(1,1+2*M1:end))
patch('Faces',objectN.faces,'Vertices',objectN.vertices,'FaceColor','blue')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold off