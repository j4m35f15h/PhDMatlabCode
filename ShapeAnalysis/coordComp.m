orderOp = 13 -[1 2;...
3 4;...
5 6;...
6 7;...
7 12;...
8 9;...
10 11];
featureDiffD0 = zeros(7,3);
for i = 1:7
featureDiffD0(i,:) = [t1Coordinates(orderOp(i,1)).Position - t1Coordinates(orderOp(i,2)).Position];
end
featureLengthD0 = sqrt(sum(featureDiffD0.^2,2));
featureLengthD0(4,:) = [];
featureLengthD0(2) = 320;

featureDiffD2 = zeros(7,3);
for i = 1:7
featureDiffD2(i,:) = [t2Coordinates(orderOp(i,1)).Position - t2Coordinates(orderOp(i,2)).Position];
end
featureLengthD2 = sqrt(sum(featureDiffD2.^2,2));
featureLengthD2(4,:) = [];

featureDiffD4 = zeros(7,3);
for i = 1:7
featureDiffD4(i,:) = [t3Coordinates(orderOp(i,1)).Position - t3Coordinates(orderOp(i,2)).Position];
end
featureLengthD4 = sqrt(sum(featureDiffD4.^2,2));
featureLengthD4(4,:) = [];

featureDiffD6 = zeros(7,3);
for i = 1:7
featureDiffD6(i,:) = [t4Coordinates(orderOp(i,1)).Position - t4Coordinates(orderOp(i,2)).Position];
end
featureLengthD6 = sqrt(sum(featureDiffD6.^2,2));
featureLengthD6(4,:) = [];

figure
titleArray = ["Lateral Condyle Height","Lateral Condyle Depth","Lateral Condyle Width","Medial Condyle Height","Medial Condyle depth","Medial Condyle width"];
for i = [1:6]
    subplot(2,3,i)
    plot([0 2 4 6],[featureLengthD0(i) featureLengthD2(i) featureLengthD4(i) featureLengthD6(i)])
    xlabel('Day')
    ylabel(['feature length \mu','m'])
    title(titleArray(i))
end

