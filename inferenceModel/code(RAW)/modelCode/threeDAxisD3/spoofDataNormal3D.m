nPoint = 650;
X = zeros(1,3*nPoint);
maxim = [max(object.vertices(:,1)),max(object.vertices(:,2)),max(object.vertices(:,3))];
for i = 1:nPoint
    tX = rand()*maxim(1);
    tY = rand()*maxim(2);
    tZ = rand()*maxim(3);
    while ~inpolyhedron(object,[tX tY tZ])
        tX = rand()*maxim(1);
        tY = rand()*maxim(2);
        tZ = rand()*maxim(3);
    end
    X(i) = tX;
    X(i+nPoint) = tY;
    X(i+2*nPoint) = tZ;
end
clear tX tY tZ maxim nPoint