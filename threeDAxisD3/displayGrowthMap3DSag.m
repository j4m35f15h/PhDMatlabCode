function displayGrowthMap3DSag(lattice,latticeNew,object,theta,rows,cols,deps)

N = size(lattice,2)/3;
growthMag = zeros(size(theta));
growthAnisotropy = zeros(4,size(theta,2));
% F = zeros(2,2,4);
for i = 1:size(theta,2) %for all the calculation domain
    [localO,~] = neighbours3D(theta(i),lattice,cols,rows);
    [localN,~] = neighbours3D(theta(i),latticeNew,cols,rows);
    xc = latticeNew(theta(i));
    yc = latticeNew(theta(i)+N);
    zc = latticeNew(theta(i)+2*N);
    Xc = lattice(theta(i));
    Yc = lattice(theta(i) + N);
    Zc = lattice(theta(i) + 2*N);
    for j = 1:8 %for all the directions around a point
        %Obtain old and new coordinates
        [x1,x2,x3,y1,y2,y3,z1,z2,z3] = setCoordinates(j,localN);
        [X1,X2,X3,Y1,Y2,Y3,Z1,Z2,Z3] = setCoordinates(j,localO);
        newC = [x1-xc,x2-xc,x3-xc;y1-yc,y2-yc,y3-yc;z1-zc,z2-zc,z3-zc];
        oldC = [X1-Xc,X2-Xc,X3-Xc;Y1-Yc,Y2-Yc,Y3-Yc;Z1-Zc,Z2-Zc,Z3-Zc];
        F = newC/oldC;
        growthMag(i) = growthMag(i) + (det(F))/8;%Calculate magnitude and store at that point
        U = sqrtm(F'*F);
        [V,D] = eig(U);
        temp = sort(D(find(D)));
        Dt = sum(D,1);
        tempV = [V(:,find(temp(3)==Dt)),V(:,find(temp(2)==Dt)),V(:,find(temp(1)==Dt))];
        [D(1,1),D(2,2),D(3,3)] = deal(temp(3),temp(2),temp(1));
        V = tempV;
%         growthAnisotropy(1,i) = growthAnisotropy(1,i) + (D(1,1)/(D(2,2)*D(3,3)))/8;
%         growthAnisotropy(1,i) = growthAnisotropy(1,i) + (D(1,1)/(D(2,2)))/8;
%         growthAnisotropy(1,i) = growthAnisotropy(1,i) + ((1-D(2,2))*(1-D(3,3))/D(1,1))/8;
        growthAnisotropy(1,i) = growthAnisotropy(1,i) + ( 1-0.5*( (D(2,2)+D(3,3))/D(1,1) )  )/8;
        growthAnisotropy(2:4,i) = growthAnisotropy(2:4,i) + V(:,1)/8;
    end
    %     F = zeros(3,3,8);%Clear variable for next iteration
end
%We need to create the outline for the mag plot.
%each laywer of theta will get a slice of rudiment data. The best way
%of cutting up theta will probably be to take coronal slices. That 
%means finding the theta points that are in the same plane.
% heights = unique(lattice(2*N+1:end));
% 
% figure
% subplot(1,2,1)
% title('Magnitude')
% hold on
% for i = 2:deps-1
% temp = find(lattice(theta+2*N)==heights(i));
% X = unique(lattice(theta));
% Y = unique(lattice(theta+N));
% colorMag = NaN(size(X,2),size(Y,2))';
% 
% for j = 1:size(temp,2)
%     colorMag(find(lattice(theta(temp(j))+N)==Y),find(lattice(theta(temp(j)))==X)) = growthMag(temp(j));
% end
% outline = find(ismembertol(object.vertices(:,3),heights(i),(heights(2)/100)));
% outlineX = object.vertices(outline,1);
% outlineY = object.vertices(outline,2);
% k = convhull(outlineX,outlineY);
% plot3(outlineX(k),outlineY(k),ones(size(k))*heights(i),'Color','blue');
% surf(X,Y,ones(size(Y,2),size(X,2))*heights(i),colorMag);
% 
% end
% shading interp
% hold off

% tempLat = [lattice(1:N)',lattice(1+N:2*N)',lattice(1+2*N:end)',];
% deg = deg2rad(45);
% tempLat = tempLat*[cos(deg) -sin(deg) 0; sin(deg) cos(deg) 0; 0 0 1];
% lattice = [tempLat(:,1)',tempLat(:,2)',tempLat(:,3)'];
% object.vertices = object.vertices*[cos(deg) -sin(deg) 0; sin(deg) cos(deg) 0; 0 0 1];

heights = unique(lattice(2*N+1:end));
widths = unique(lattice(1:N));

figure
subplot(1,2,1)
title('Magnitude')
hold on
for i = 4%2:rows-1
temp = find(lattice(theta)==widths(i));
% X = unique(lattice(theta));
Y = unique(lattice(theta+N));
Z = unique(lattice(theta+2*N));
colorMag = NaN(size(Y,2),size(Z,2))';

for j = 1:size(temp,2)
    colorMag(find(lattice(theta(temp(j))+2*N)==Z),find(lattice(theta(temp(j))+N)==Y)) = growthMag(temp(j));
end
outline = find(ismembertol(object.vertices(:,1),widths(i),0.1));
outlineZ = object.vertices(outline,3);
outlineY = object.vertices(outline,2);
k = boundary(outlineY,outlineZ,0.5);
% plot3(outlineY(k),outlineZ(k),ones(size(k))*widths(i),'Color','blue');
% surf(Y,Z,ones(size(Z,2),size(Y,2))*widths(i),colorMag);
% plot3(outlineY(k),outlineZ(k),ones(size(k))*widths(i)+1,'Color','blue');
surf(Y,Z,ones(size(Z,2),size(Y,2))*widths(i),colorMag);
end
shading interp
hold off
caxis([-0.1257  1.3626])





% subplot(1,2,2)
% title('Anisotropy')
% hold on
% for i = 2:deps-1
% 
% temp = find(lattice(theta+2*N)==heights(i));
% X = unique(lattice(theta));
% Y = unique(lattice(theta+N));
% anMag = NaN(size(X,2),size(Y,2))';
% anDir = NaN(size(X,2),size(Y,2))';
% for j = 1:size(temp,2)
%     anMag(find(lattice(theta(temp(j))+N)==Y),find(lattice(theta(temp(j)))==X)) = growthAnisotropy(1,temp(j));
% end
% outline = find(ismembertol(object.vertices(:,3),heights(i),(heights(2)/100)));
% outlineX = object.vertices(outline,1);
% outlineY = object.vertices(outline,2);
% k = convhull(outlineX,outlineY);
% plot3(outlineX(k),outlineY(k),ones(size(k))*heights(i),'Color','blue');
% surf(X,Y,ones(size(Y,2),size(X,2))*heights(i),anMag);
% 
% temp = temp(inpolygon(lattice(theta(temp)),lattice(theta(temp)+N),outlineX(k),outlineY(k)));
% quiver3(lattice(theta(temp)),lattice(theta(temp)+N),ones(size(temp))*heights(i),abs(growthAnisotropy(2,temp)),abs(growthAnisotropy(3,temp)),abs(growthAnisotropy(4,temp)),'k')
% 
% end
% shading interp
% hold off



subplot(1,2,2)
title('Anisotropy')
hold on
% i = 5;%Dyn mid lateral
%i = 4;%Stat mid lateral
for i = 4%2:rows-1

temp = find(lattice(theta)==widths(i));
Y = unique(lattice(theta+N));
Z = unique(lattice(theta+2*N));

anMag = NaN(size(Y,2),size(Z,2))';
anDir = NaN(size(Y,2),size(Z,2))';

for j = 1:size(temp,2)
    anMag(find(lattice(theta(temp(j))+2*N)==Z),find(lattice(theta(temp(j))+N)==Y)) = growthAnisotropy(1,temp(j));
end
outline = find(ismembertol(object.vertices(:,1),widths(i),0.1));
outlineZ = object.vertices(outline,3);
outlineY = object.vertices(outline,2);
k = boundary(outlineY,outlineZ,0.5);

% plot3(outlineY(k),outlineZ(k),ones(size(k))*widths(i)+1,'Color','blue');

surf(Y,Z,ones(size(Z,2),size(Y,2))*widths(i),anMag);

temp = temp(inpolygon(lattice(theta(temp)+N),lattice(theta(temp)+2*N),outlineY(k),outlineZ(k)));
angle = atan(growthAnisotropy(3,temp)./growthAnisotropy(4,temp));
% scale = sum([abs(growthAnisotropy(3,temp));abs(growthAnisotropy(4,temp))]);
quiver3(lattice(theta(temp)+N),lattice(theta(temp)+2*N),ones(size(temp))*widths(i),...
    100*sin(angle),100*cos(angle),zeros(size(abs(growthAnisotropy(4,temp)))),'Color','k','AutoScale','off')
% quiver3(lattice(theta(temp)+N),lattice(theta(temp)+2*N),ones(size(temp))*widths(i),...
%     abs(growthAnisotropy(2,temp))*100000000,abs(growthAnisotropy(3,temp))*100000000,zeros(size(abs(growthAnisotropy(3,temp)))),'Color','k','AutoScale','on')
% growthAnisotropy(:,temp)
end
shading interp
hold off
% caxis([-0.0113 0.1598])
colormap turbo

end

function [x1,x2,x3,y1,y2,y3,z1,z2,z3] = setCoordinates(j,local)
C = [1,4,6; ... %Cube edge definitions.
    1,5,4; ...
    1,2,5; ...
    1,6,2; ...
    3,4,6; ...
    3,5,4; ...
    3,2,5; ...
    3,6,2];
N = size(local,2)/3;
[x1,y1,z1] = deal(local(C(j,1)),local(C(j,1)+N),local(C(j,1)+2*N));
[x2,y2,z2] = deal(local(C(j,2)),local(C(j,2)+N),local(C(j,2)+2*N));
[x3,y3,z3] = deal(local(C(j,3)),local(C(j,3)+N),local(C(j,3)+2*N));
end