load('idealStartScaled.mat')
figure
hold on
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','FaceAlpha',0.3,'LineStyle','none')
scatter3(CBStat(:,1),CBStat(:,2),CBStat(:,3))
scatter3(CBDyn(:,1),CBDyn(:,2),CBDyn(:,3))
hold off

load('idealDynScaled')
figure
hold on
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','FaceAlpha',0.3,'LineStyle','none')
scatter3(CADyn(:,1),CADyn(:,2),CADyn(:,3),'MarkerEdgeColor','red')
hold off

load('idealStatScaled')
figure
hold on
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','FaceAlpha',0.3,'LineStyle','none')
scatter3(CAStat(:,1),CAStat(:,2),CAStat(:,3))
hold off