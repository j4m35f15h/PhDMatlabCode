nPoint = 220;
X = zeros(1,2*nPoint);
for i = 1:nPoint
    tX = rand();
    tY = rand();
    while ~inpolygon(tX,tY,segmentX,segmentY)
        tX = rand();
        tY = rand();
    end
    X(i) = tX;
    X(i+nPoint) = tY;
end