%Two handd picked boundaries for the example
load('boundaryForDiagram');

%First plot with the outlines
% figure
% hold on
% plot(outlineB1(:,1),outlineB1(:,2),'LineWidth',3)
% plot(outlineB2(:,1),outlineB2(:,2),'LineWidth',3)
% hold off

            [~,I] = max(outlineB1(:,2));
            outlineB1 = circshift(outlineB1,size(outlineB1,1)+1-I);
            outlineB1 = [outlineB1;outlineB1(1,:)];
            [trueOutline1(1:1000,1),trueOutline1(1:1000,2)] = evenOut(outlineB1(:,1),outlineB1(:,2));

            
            [~,I] = max(outlineB2(:,2));
            outlineB2 = circshift(outlineB2,size(outlineB2,1)+1-I);
            outlineB2 = [outlineB2;outlineB2(1,:)];
            [trueOutline2(1:1000,1),trueOutline2(1:1000,2)] = evenOut(outlineB2(:,1),outlineB2(:,2));


% figure
% hold on
% plot(outlineB1(:,1),outlineB1(:,2),'LineWidth',3)
% plot(outlineB2(:,1),outlineB2(:,2),'LineWidth',3)
% hold off
% Random filling with outlines
% figure
% hold on
% plot(trueOutline1(:,1),trueOutline1(:,2),'LineWidth',3,'Color','b')
% scatter(trueOutline1(1:100:end,1),trueOutline1(1:100:end,2),150,'LineWidth',2.5,'MarkerEdgeColor','b')
% scatter(trueOutline1(301,1),trueOutline1(301,2),150,"filled",'LineWidth',3,'MarkerEdgeColor','b','MarkerFaceColor','b')
% 
% plot(trueOutline2(:,1),trueOutline2(:,2),'LineWidth',3,'Color','r')
% scatter(trueOutline2(501,1),trueOutline2(501,2),150,"filled",'LineWidth',2.5,'MarkerEdgeColor','r','MarkerFaceColor','r')
% scatter(trueOutline2(1:100:end,1),trueOutline2(1:100:end,2),150,'LineWidth',3,'MarkerEdgeColor','r')
% hold off

% Filling on top index
% figure
% hold on
% plot(trueOutline1(:,1),trueOutline1(:,2),'LineWidth',3,'Color','b')
% scatter(trueOutline1(1:100:end,1),trueOutline1(1:100:end,2),150,'LineWidth',2.5,'MarkerEdgeColor','b')
% scatter(trueOutline1(1,1),trueOutline1(1,2),150,"filled",'LineWidth',3,'MarkerEdgeColor','b','MarkerFaceColor','b')
% 
% plot(trueOutline2(:,1),trueOutline2(:,2),'LineWidth',3,'Color','r')
% scatter(trueOutline2(1,1),trueOutline2(1,2),150,"filled",'LineWidth',2.5,'MarkerEdgeColor','r','MarkerFaceColor','r')
% scatter(trueOutline2(1:100:end,1),trueOutline2(1:100:end,2),150,'LineWidth',3,'MarkerEdgeColor','r')
% hold off

%Need to make the average outline, and we can include the same marking
figure
hold on
xlim([2028 2249])
ylim([2256 2430])
plot(trueOutline1(:,1),trueOutline1(:,2),'LineWidth',3,'Color','b')
scatter(trueOutline1(1:100:end,1),trueOutline1(1:100:end,2),150,'LineWidth',2.5,'MarkerEdgeColor','b')
scatter(trueOutline1(1,1),trueOutline1(1,2),150,"filled",'LineWidth',3,'MarkerEdgeColor','b','MarkerFaceColor','b')

plot(trueOutline2(:,1),trueOutline2(:,2),'LineWidth',3,'Color','r')
scatter(trueOutline2(1,1),trueOutline2(1,2),150,"filled",'LineWidth',2.5,'MarkerEdgeColor','r','MarkerFaceColor','r')
scatter(trueOutline2(1:100:end,1),trueOutline2(1:100:end,2),150,'LineWidth',3,'MarkerEdgeColor','r')
hold off



averageOutline = (trueOutline1+trueOutline2)/2;
hold on
plot(averageOutline(:,1),averageOutline(:,2),'LineWidth',3,'Color','magenta')
scatter(averageOutline(1:100:end,1),averageOutline(1:100:end,2),150,"x",'LineWidth',3,'MarkerEdgeColor','magenta')
hold off

%Final image of the outline
figure
hold on
plot(trueOutline1(:,1),trueOutline1(:,2),'LineWidth',3,'Color',[0 0 1 0.25],'LineStyle','- -')

plot(trueOutline2(:,1),trueOutline2(:,2),'LineWidth',3,'Color',[1 0 0 0.25],'LineStyle','- -')

plot(averageOutline(:,1),averageOutline(:,2),'LineWidth',3,'Color','magenta')

hold off