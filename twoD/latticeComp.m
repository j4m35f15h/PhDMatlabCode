figure
subplot(1,2,1)
hold on
scatter(trueLattice(theta),trueLattice(theta+end/2))
scatter(trueLattice(f1),trueLattice(f1+end/2))
scatter(trueLattice(f2),trueLattice(f2+end/2))
hold off

subplot(1,2,2)
hold on
scatter(latticeNew(theta),latticeNew(theta + size(lattice,2)/2))
scatter(latticeNew(f1),latticeNew(f1 + size(lattice,2)/2))
scatter(latticeNew(f2),latticeNew(f2 + size(lattice,2)/2))
hold off