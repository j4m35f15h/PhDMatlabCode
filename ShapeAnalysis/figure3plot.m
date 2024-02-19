yyaxis left
title('Variation in cell count and position proportion against position')
xlabel('% position through Lateral Condyle')
ylabel('Cell Count')

yyaxis right
ylabel('% of cells in Posterior half')

cellCountData.count = [16;17;18;9;19;20;6;13;10;18;23;18;0;4;1;4;0;8;10;1;13;3;11;7;1;13;0;1;7;5;12;11;1];
cellCountData.post = [6;4;6;2;5;5;2;3;4;8;13;8;0;2;0;2;0;6;5;0;5;1;3;4;0;5;0;0;3;0;9;6;0];
cellCountData.label = [0;0;0;0;0;0;0;0;0;0;2;2;2;2;2;2;2;4;4;4;4;4;4;4;4;4;4;4;4;4;2;2;2];
cellCountData.label2 = [0;25;0;25;0;25;75;25;50;0;25;25;50;75;75;0;50;50;50;0;25;50;50;25;0;25;75;75;50;50;50;50;0];
for i = 1:size(cellCountData.count,1)
    if cellCountData.count(i) == 0
        cellCountData.perc(i) = 0;
        continue
    end
    cellCountData.perc(i) = (cellCountData.post(i)/cellCountData.count(i))*100;
end
cellCountData.perc = cellCountData.perc';
%want to make average data. We need to for each time point, group the data
%into days, then average the data for all of that day
averageData = [];
averageBounds = [];
for j = [0 2 4]
    for k = [0 25 50 75]
        indexes = find((cellCountData.label == j).*(cellCountData.label2 == k));
        if isempty(indexes)
            averageData = [averageData,[mean(cellCountData.count(indexes));mean(cellCountData.perc(indexes))]];
            averageBounds = [avedrageBounds,0];
        end
        averageData = [averageData,[mean(cellCountData.count(indexes));mean(cellCountData.perc(indexes))]];
        averageBounds = [averageBounds,numel(indexes)];
    end
end
%Given that our most basic data set doesn't leak any of the groiups, we
%should be good to assume that none of them will be empty.
% xpos = cellCountData.label2+5*(rand(size(cellCountData.count,1),1)-0.5);
% xpos = [0 25 50 75];
% xpos = [xpos xpos xpos];
% xpos = xpos + 5*(rand(1,size(xpos,2))-0.5);
% yyaxis left
% ylabel('PHH3 Positive Cells')
% scatter(xpos,averageData(1,:))
% yyaxis right
% ylabel('% PHH3 Positive Cells in Posterior half')
% scatter(xpos,averageData(2,:))

subplot(2,3,1)
title('PHH3 positive cell distribution after 0 culture days')
yyaxis left
scatter([0 25 50 75],averageData(1,1:4),'filled')
ylim([0 22])
ylabel('PHH3 Positive Cell Count')
yyaxis right
scatter([0 25 50 75],averageData(2,1:4),'filled')
ylim([0 55])
xlim([-5 80])
xlabel('% Travelled from Centre of Lateral Condyle')

subplot(2,3,2)
title('PHH3 positive cell distribution after 2 culture days')
yyaxis left
scatter([0 25 50 75],averageData(1,5:8),'filled')
ylim([0 22])
xlim([-5 80])
xlabel('% Travelled from Centre of Lateral Condyle')
yyaxis right
scatter([0 25 50 75],averageData(2,5:8),'filled')
ylim([0 55])

subplot(2,3,3)
title('PHH3 positive cell distribution after 4 culture days')
yyaxis left
scatter([0 25 50 75],averageData(1,9:12),'filled')
ylim([0 22])
yyaxis right
scatter([0 25 50 75],averageData(2,9:12),'filled')
ylim([0 55])
ylabel('% PHH3 Positive Cells in Posterior half')
xlim([-5 80])
xlabel('% Travelled from Centre of Lateral Condyle')



subplot(2,4,5)
title('PHH3 positive cell distribution over time at 0%')
yyaxis left
scatter([0 2 4],averageData(1,1:4:end),'filled')
ylim([0 22])
ylabel('PHH3 Positive Cell Count')
yyaxis right
scatter([0 2 4],averageData(2,1:4:end),'filled')
ylim([0 55])
xlim([-0.5 4.5])
xlabel('Culture Duration (Days)')

subplot(2,4,6)
title('PHH3 positive cell distribution over time at 25%')
yyaxis left
scatter([0 2 4],averageData(1,2:4:end),'filled')
ylim([0 22])
yyaxis right
scatter([0 2 4],averageData(2,2:4:end),'filled')
ylim([0 55])
xlim([-0.5 4.5])
xlabel('Culture Duration (Days)')

subplot(2,4,7)
title('PHH3 positive cell distribution over time at 50%')
yyaxis left
scatter([0 2 4],averageData(1,3:4:end),'filled')
ylim([0 22])
yyaxis right
scatter([0 2 4],averageData(2,3:4:end),'filled')
ylim([0 55])
xlim([-0.5 4.5])
xlabel('Culture Duration (Days)')
subplot(2,4,8)

title('PHH3 positive cell distribution over time at 75%')
yyaxis left
scatter([0 2 4],averageData(1,4:4:end),'filled')
ylim([0 22])
yyaxis right
scatter([0 2 4],averageData(2,4:4:end),'filled')
ylim([0 55])
ylabel('% PHH3 Positive Cells in Posterior half')
xlim([-0.5 4.5])
xlabel('Culture Duration (Days)')