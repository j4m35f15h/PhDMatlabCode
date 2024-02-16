% [object2.vertices, object2.faces] = stlread('idealtiblowres.stl');
[object.vertices, object.faces] = stlread('11.3RG.stl');

% object = object2;
load('idealStatScaled.mat')
object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
% object.vertices = object.vertices - dataStruct.transOrigin.*[1 1 dataStruct.transPre(4)];

object.vertices = object.vertices + dataStruct.transPre(1:3);

temp = mean(object.vertices);
object.vertices = object.vertices - temp;
% object.vertices = object.vertices*dataStruct.transRot;
object.vertices = [dataStruct.transRot*object.vertices']';
% object.vertices = object.vertices + dataStruct.transOrigin.*[1 1 dataStruct.transPre(4)];
object.vertices = object.vertices + temp;

figure
hold on
patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.3)
hold off

% object.vertices = [dataStruct.transRot*[object.vertices(:,1) - mean(object.vertices(:,1)),object.vertices(:,2) - mean(object.vertices(:,2)),object.vertices(:,3) - mean(object.vertices(:,3))]']'+ [ones(sizeV,1)*mean(object.vertices(:,1)),ones(sizeV,1)*mean(object.vertices(:,2)),ones(sizeV,1)*mean(object.vertices(:,3))];

% object.Vertices = [[1 0 0;
%     0 cos(degs) -sin(degs);
%     0 sin(degs) cos(degs)]*
%     [object.Vertices(:,1) - mean(object.Vertices(:,1)),
%     object.Vertices(:,2) - mean(object.Vertices(:,2)),
%     object.Vertices(:,3) - mean(object.Vertices(:,3))]']'
% + [ones(sizeV,1)*mean(object.Vertices(:,1))
%     ,ones(sizeV,1)*mean(object.Vertices(:,2))
%     ,ones(sizeV,1)*mean(object.Vertices(:,3))];