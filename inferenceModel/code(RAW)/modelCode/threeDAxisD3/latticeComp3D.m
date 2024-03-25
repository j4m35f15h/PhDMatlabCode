%A quick comparison on an estimate latticeNew and a known deformed trueLattice.
%f3 may not exist
figure
subplot(1,2,1)
hold on
scatter3(trueLattice(1,theta),trueLattice(1,theta+N),trueLattice(1,theta+2*N))
scatter3(trueLattice(1,f1),trueLattice(1,f1+N),trueLattice(1,f1+2*N))
scatter3(trueLattice(1,f2),trueLattice(1,f2+N),trueLattice(1,f2+2*N))
scatter3(trueLattice(1,f3),trueLattice(1,f3+N),trueLattice(1,f3+2*N))
hold off

subplot(1,2,2)
hold on
scatter3(latticeNew(1,theta),latticeNew(1,theta + N),latticeNew(1,theta + 2*N))
scatter3(latticeNew(1,f1),latticeNew(1,f1 + N),latticeNew(1,f1 + 2*N))
scatter3(latticeNew(1,f2),latticeNew(1,f2 + N),latticeNew(1,f2 + 2*N))
scatter3(latticeNew(1,f3),latticeNew(1,f3 + N),latticeNew(1,f3 + 2*N))
hold off
