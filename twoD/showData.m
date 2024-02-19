figure
hold on
plot(segmentX,segmentY)
scatter(X(1:end/2),X(1+end/2:end))
% scatter(lattice(theta),lattice(theta + size(lattice,2)/2))
hold off
% xlim([0 1])
% ylim([0 1])

figure
hold on
plot(segmentXN,segmentYN)
scatter(x(1:end/2),x(1+end/2:end))
% scatter(lattice(theta),lattice(theta + size(lattice,2)/2))
hold off
% xlim([0 1])
% ylim([0 1])