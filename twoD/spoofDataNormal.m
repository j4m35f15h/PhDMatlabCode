nPoint = 500;
nSites = 50;
X = zeros(1,2*nPoint);
XSites = zeros(1,2*nSites);
for i = 1:nSites
    tXs = rand();
    tYs = rand();
    while ~inpolygon(tXs,tYs,segmentX,segmentY)
        tXs = rand();
        tYs = rand();
    end
    for j = 1:nPoint/nSites
        tX = normrnd(tXs,0.01);
        tY = normrnd(tYs,0.01);
        while ~inpolygon(tX,tY,segmentX,segmentY)
            tX = normrnd(tXs,0.01);
            tY = normrnd(tYs,0.01);
        end
        X(j+(i-1)*nPoint/nSites) = tX;
        X(j+((i-1)*nPoint/nSites)+nPoint) = tY;
    end
     XSites(i) = tXs;
     XSites(i+nSites) = tYs;
end

