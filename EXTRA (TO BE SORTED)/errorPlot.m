%Plots each limb cell stuff individually so I can identiy which limbs need
%correction

%     load('idealStatScaled.mat')
% for i = 1:size(ModelInputStructStat,2)
%     M = ModelInputStructStat(i).CA;
%     figure
%     hold on
%     patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.3)
%     scatter3(M(:,1),M(:,2),M(:,3))
% end

%     load('idealDynScaled.mat')
% for i = 1:size(ModelInputStructDyn,2)
%     M = ModelInputStructDyn(i).CA;
%     figure
%     hold on
%     patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.3)
%     scatter3(M(:,1),M(:,2),M(:,3))
% end

    load('idealStartScaled.mat')
for i = 1:size(ModelInputStructStat,2)
    M = ModelInputStructStat(i).CB;
    figure
    hold on
    patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.3)
    scatter3(M(:,1),M(:,2),M(:,3))
end

% load('idealStartScaled.mat')
% for i = 1:size(ModelInputStructDyn,2)
%     M = ModelInputStructDyn(i).CB;
%     figure
%     hold on
%     patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.3)
%     scatter3(M(:,1),M(:,2),M(:,3))
% end