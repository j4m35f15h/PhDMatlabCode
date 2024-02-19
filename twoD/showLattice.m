figure
plot(segmentX,segmentY)
hold on
scatter(lattice(theta),lattice(theta+size(lattice,2)/2),'MarkerEdgeColor',[0 0.4470 0.7410])
scatter(lattice(f1),lattice(f1+size(lattice,2)/2),'MarkerEdgeColor',[0.8500 0.3250 0.0980])
scatter(lattice(f2),lattice(f2+size(lattice,2)/2),'MarkerEdgeColor',[0.8500 0.3250 0.0980])
hold off
xlim([0 1])
ylim([0 1])

figure
plot(segmentXN,segmentYN)
hold on
scatter(trueLattice(theta),trueLattice(theta+size(lattice,2)/2),'MarkerEdgeColor',[0 0.4470 0.7410])
scatter(trueLattice(f1),trueLattice(f1+size(lattice,2)/2),'MarkerEdgeColor',[0.8500 0.3250 0.0980])
scatter(trueLattice(f2),trueLattice(f2+size(lattice,2)/2),'MarkerEdgeColor',[0.8500 0.3250 0.0980])
hold off
% xlim([0 1])
ylim([-0.1 1.6])