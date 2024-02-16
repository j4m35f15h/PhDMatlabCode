function displayErrorMap3D(trueLattice,latticeNew,lattice,object,theta,rows)
figure
N = size(lattice,2)/3;
errorMag = zeros(size(theta));
% F = zeros(2,2,4);
for i = 1:size(theta,2) %for all the calculation domain

    xc(1) = latticeNew(theta(i));
    xc(2) = latticeNew(theta(i)+N);
    xc(3) = latticeNew(theta(i)+2*N);
    Xc(1) = trueLattice(theta(i));
    Xc(2) = trueLattice(theta(i) + N);
    Xc(3) = trueLattice(theta(i) + 2*N);
    msesum = 0;
    for j = 1:3
	msesum = msesum + (Xc(j)-xc(j))^2;
    end
errorMag(i) = sqrt(msesum);
end
heights = unique(lattice(2*N+1:end));

% figure

% title('Error Magnitude')
hold on
for i = 7%2:10%rows-1
    
    temp = find(lattice(theta+2*N)==heights(i));
    X = unique(lattice(theta));
    Y = unique(lattice(theta+N));
    colorMag = NaN(size(X,2),size(Y,2));
    
    for j = 1:size(temp,2)
        colorMag(find(lattice(theta(temp(j)))==X),find(lattice(theta(temp(j))+N)==Y)) = errorMag(temp(j));
    end
    outline = find(ismembertol(object.vertices(:,3),heights(i),(heights(2)/100)));
    outlineX = object.vertices(outline,1);
    outlineY = object.vertices(outline,2);
    k = convhull(outlineX,outlineY);
    plot3(outlineX(k),outlineY(k),ones(size(k))*heights(i),'Color','blue');
    
%     size(X)
%     size(Y)
%     size(ones(size(X,2),size(Y,2))*heights(i))
%     size(colorMag)
%     colorMag
    surf(X,Y,ones(size(Y,2),size(X,2))*heights(i)+1,colorMag');
    
end
shading interp
% scatter3(lattice(theta),lattice(theta+N),lattice(theta+2*N))
hold off

end
