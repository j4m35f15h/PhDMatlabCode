figure
plot(segmentXN,segmentYN)
hold on
scatter(trueLattice(theta),trueLattice(theta + end/2))
scatter(trueLattice(f1),trueLattice(f1+end/2))
scatter(trueLattice(f2),trueLattice(f2+end/2))
hold off