%Should look similar to the plot in the paper. Subplot with two elements.
%Has the outline of the original rudiment. Superimposed ontop of that is a
%heat map of the growth rate

temp = zeros(1,rows*cols);
temp(theta) = growthMag;%.*inpolygon(lattice(theta),lattice(theta + size(lattice,2)/2),segmentX,segmentY);
% temp= temp.*;
temp(temp == 0) = NaN;
temp = vec2mat(temp,cols);



figure
subplot(1,2,1)
title('Magnitude')
hold on
pcolor(lattice(1:cols),lattice(1:rows),temp)
% plot(segmentX,segmentY,'Color',[0.8500, 0.3250, 0.0980])
shading interp 
% surf(lattice(1:15),lattice(1:15),temp)
hold off

temp = zeros(1,rows*cols);
temp(theta) = growthAnisotropy(1,:);%.*inpolygon(lattice(theta),lattice(theta + size(lattice,2)/2),segmentX,segmentY);
temp(temp == 0) = NaN;
temp = vec2mat(temp,cols);
temp2 = growthAnisotropy(2,:).*inpolygon(lattice(theta),lattice(theta + size(lattice,2)/2),segmentX,segmentY);
temp2(temp2 == 0) = NaN;

temp3 = growthAnisotropy(3,:).*inpolygon(lattice(theta),lattice(theta + size(lattice,2)/2),segmentX,segmentY);
temp3(temp3 == 0) = NaN;


subplot(1,2,2)
title('Anisotropy')
hold on
pcolor(lattice(1:cols),lattice(1:rows),temp)
% plot(segmentX,segmentY,'Color',[0.8500, 0.3250, 0.0980])
shading interp 
quiver(lattice(theta),lattice(theta+N),temp2,temp3,'Color','Black')
caxis([0 1])
% quiver(lattice(theta(1:2:N)),lattice(theta(1:2:N)+N),temp2(1:2:end),temp3(1:2:end),'Color','Black')
hold off
