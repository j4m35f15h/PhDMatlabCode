nPoint = 650;
X = zeros(1,3*nPoint);
maxim = [max(object.vertices(:,1)),max(object.vertices(:,2)),max(object.vertices(:,3))];
minim = [min(object.vertices(:,1)),min(object.vertices(:,2)),min(object.vertices(:,3))];
centre = [(maxim(1)-minim(1))/2,(maxim(2)-minim(2))/2];
for i = 1:nPoint
    
    tX = 0;
    tY = 0;
    tZ = 0;
    %Distance to centre
%     dmag = sqrt((centre-tY)^2+(centre-tZ)^2)
%     dmag = 0;

    while 1
%         dmag<(1.5*object.resolution(1))
        tX = rand()*maxim(1);
        tY = rand()*maxim(2);
        tZ = rand()*maxim(3);
        dmag = sqrt((centre(1)-tX)^2+(centre(2)-tY)^2);
%         

        if (dmag<200)
            continue 
        end
        if ~inpolyhedron(object,[tX tY tZ])
            continue
        end
        break
%         '1'
%         ~inpolyhedron(object,[tX tY tZ])
%           (dmag<(1.5*object.resolution(1)))
% dmag<(1.5*object.resolution(1))
    end
% '2'
    X(i) = tX;
    X(i+nPoint) = tY;
    X(i+2*nPoint) = tZ;
    i
end
clear tX tY tZ maxim nPoint