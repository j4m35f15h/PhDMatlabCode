clear all
figure
hold on
addpath('R:\live\James\morishita2021\StartG\Dyn\7.4TO9.4\8.4L')
load('transformG.mat');
[object.vertices, object.faces] = stlread('8.4LG.stl');

object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
object.vertices = object.vertices + dataStruct.transPre(1:3);
temp = mean(object.vertices);
object.vertices = object.vertices - temp;
object.vertices = [dataStruct.transRot*object.vertices']';
object.vertices = object.vertices + temp;

patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.2)
rmpath('R:\live\James\morishita2021\StartG\Dyn\7.4TO9.4\8.4L')


addpath('R:\live\James\morishita2021\StartG\Dyn\7.4TO9.4\9.4L')
load('transformG.mat');
[object.vertices, object.faces] = stlread('9.4LG.stl');

object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
object.vertices = object.vertices + dataStruct.transPre(1:3);
temp = mean(object.vertices);
object.vertices = object.vertices - temp;
object.vertices = [dataStruct.transRot*object.vertices']';
object.vertices = object.vertices + temp;

patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','green','LineStyle','none','FaceAlpha',0.2)
rmpath('R:\live\James\morishita2021\StartG\Dyn\7.4TO9.4\9.4L')


addpath('R:\live\James\morishita2021\StartG\Dyn\7.4TO9.4\9.4R')
load('transformG.mat');
[object.vertices, object.faces] = stlread('9.4RG.stl');

object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
object.vertices = object.vertices + dataStruct.transPre(1:3);
temp = mean(object.vertices);
object.vertices = object.vertices - temp;
object.vertices = [dataStruct.transRot*object.vertices']';
object.vertices = object.vertices + temp;

patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.2)
rmpath('R:\live\James\morishita2021\StartG\Dyn\7.4TO9.4\9.4R')


[object2.vertices, object2.faces] = stlread('idealtiblowres.stl');
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','FaceAlpha',0.4)

load('idealStartScaled.mat')
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','FaceAlpha',0.4)