cellIndex = [];
for i = 1:24
cellIndex = [cellIndex,size(ModelInputStructDyn(i).CB,1)];
end
cellIndex = cumsum(cellIndex)
i = 1;
N = 221;
figure
hold on
patch('Faces',objectN.faces,'Vertices',objectN.vertices,'FaceColor','red','FaceAlpha',0.4,'LineStyle','none')
patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','blue','FaceAlpha',0.3,'LineStyle','none')
scatter3(x(1:cellIndex(i)),x([1:cellIndex(i)]+N),x([1:cellIndex(i)]+2*N))
scatter3(X(1:cellIndex(i)),X((1:cellIndex(i))+N),X((1:cellIndex(i))+2*N))
for i = 2:24
figure
hold on
patch('Faces',objectN.faces,'Vertices',objectN.vertices,'FaceColor','red','FaceAlpha',0.4,'LineStyle','none')
patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','blue','FaceAlpha',0.3,'LineStyle','none')
scatter3(x(cellIndex(i-1)+1:cellIndex(i)),x((cellIndex(i-1)+1:cellIndex(i))+N),x((cellIndex(i-1)+1:cellIndex(i))+2*N))
scatter3(X(cellIndex(i-1)+1:cellIndex(i)),X((cellIndex(i-1)+1:cellIndex(i))+N),X((cellIndex(i-1)+1:cellIndex(i))+2*N))
end