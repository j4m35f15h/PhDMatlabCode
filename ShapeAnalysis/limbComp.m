orderOp = 13 -[1 2;...
3 4;...
5 6;...
6 7;...
7 12;...
8 9;...
10 11];
featureDifft1 = zeros(7,3);
for i = 1:7
featureDifft1(i,:) = [t1Coordinates(orderOp(i,1)).Position - t1Coordinates(orderOp(i,2)).Position];
end
featureLengtht1 = sqrt(sum(featureDifft1.^2,2));
featureLengtht1(4,:) = [];

featureDifft2 = zeros(7,3);
for i = 1:7
featureDifft2(i,:) = [t2Coordinates(orderOp(i,1)).Position - t2Coordinates(orderOp(i,2)).Position];
end
featureLengtht2 = sqrt(sum(featureDifft2.^2,2));
featureLengtht2(4,:) = [];

featureDifft3 = zeros(7,3);
for i = 1:7
featureDifft3(i,:) = [t3Coordinates(orderOp(i,1)).Position - t3Coordinates(orderOp(i,2)).Position];
end
featureLengtht3 = sqrt(sum(featureDifft3.^2,2));
featureLengtht3(4,:) = [];

featureDifft4 = zeros(7,3);
for i = 1:7
featureDifft4(i,:) = [t4Coordinates(orderOp(i,1)).Position - t4Coordinates(orderOp(i,2)).Position];
end
featureLengtht4 = sqrt(sum(featureDifft4.^2,2));
featureLengtht4(4,:) = [];

featureDifft5 = zeros(7,3);
for i = 1:7
featureDifft5(i,:) = [t5Coordinates(orderOp(i,1)).Position - t5Coordinates(orderOp(i,2)).Position];
end
featureLengtht5 = sqrt(sum(featureDifft5.^2,2));
featureLengtht5(4,:) = [];

% figure
% titleArray = ["Lateral Condyle Height","Lateral Condyle Depth","Lateral Condyle Width","Medial Condyle Height","Medial Condyle depth","Medial Condyle width"];
% for i = [1:6]
%     subplot(2,3,i)
%     plot([1 2 3 4 5],[featureLengtht1(i) featureLengtht2(i) featureLengtht3(i) featureLengtht4(i) featureLengtht5(i)])
%     xlabel('Day')
%     ylabel(['feature length \mu','m'])
%     title(titleArray(i))
% end
bigBoi = [featureLengtht1 featureLengtht2 featureLengtht3 featureLengtht4 featureLengtht5];
% LCH = [LCH; bigBoi(1,:) ];
% LCD = [LCD; bigBoi(2,:) ];
% LCW = [LCW; bigBoi(3,:) ];
% MCH = [MCH; bigBoi(4,:) ];
% MCD = [MCD; bigBoi(5,:) ];
% MCW = [MCW; bigBoi(6,:) ];