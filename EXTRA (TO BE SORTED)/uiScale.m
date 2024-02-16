post = 0;
f = figure;
setappdata(f,'transformPre',[0 0 0 1 0 0]);
setappdata(f,'transformSca',1)
% setappdata(f,'transformPost',[0 0 0 0 0 0]);
b4 = uicontrol(f,'String','Next','Units','normalized','Position',[0.1 0 0.4 0.1]);
% b4.Callback = @(src,event)saveClose(object2,dataStruct);
b4.Callback = 'changeTime';
b5 = uicontrol(f,'String','S&Q','Units','normalized','Position',[0.5 0 0.4 0.1]);
b5.Callback = "dataStruct.transPre = getappdata(f,'transformPre');dataStruct.scale = getappdata(f,'transformSca')";
p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
ax = axes(p1);

%% Plot basic
hold on
addpath('R:\live\James\morishita2021\EndG\GROUP4\1.3L')
load('transformG.mat');
[object.vertices, object.faces] = stlread('1.3LG.stl');

object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
object.vertices = object.vertices + dataStruct.transPre(1:3);
temp = mean(object.vertices);
object.vertices = object.vertices - temp;
object.vertices = [dataStruct.transRot*object.vertices']';
object.vertices = object.vertices + temp;

patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.2)
rmpath('R:\live\James\morishita2021\EndG\GROUP4\1.3L')


addpath('R:\live\James\morishita2021\EndG\GROUP1\4.3L')
load('transformG.mat');
[object.vertices, object.faces] = stlread('4.3LG.stl');

object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
object.vertices = object.vertices + dataStruct.transPre(1:3);
temp = mean(object.vertices);
object.vertices = object.vertices - temp;
object.vertices = [dataStruct.transRot*object.vertices']';
object.vertices = object.vertices + temp;

patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','green','LineStyle','none','FaceAlpha',0.2)
rmpath('R:\live\James\morishita2021\EndG\GROUP1\4.3L')


addpath('R:\live\James\morishita2021\EndG\GROUP1\5.3R')
load('transformG.mat');
[object.vertices, object.faces] = stlread('5.3RG.stl');

object.vertices(:,1) = -object.vertices(:,1);
object.vertices(:,3) = object.vertices(:,3)*dataStruct.transPre(4);
object.vertices = object.vertices + dataStruct.transPre(1:3);
temp = mean(object.vertices);
object.vertices = object.vertices - temp;
object.vertices = [dataStruct.transRot*object.vertices']';
object.vertices = object.vertices + temp;

patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','blue','LineStyle','none','FaceAlpha',0.2)
rmpath('R:\live\James\morishita2021\EndG\GROUP1\5.3R')


% [object2.vertices, object2.faces] = stlread('D4Static.stl');
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','blue','FaceAlpha',0.4)

%% 
t1 = uicontrol(p2,'Style','text','String','Translation','Units','normalized','Position',[0.1 0.6 0.4 0.02]);
e1 = uicontrol(p2,'Style','edit','String','Pixels','Units','normalized','Position',[0.1 0.5 0.1 0.1]);
b11 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.5 0.1 0.1]);
b11.Callback = @(src,event)translateOut(f,-1*str2num(e1.String),1,post);
b12 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.5 0.1 0.1]);
b12.Callback = @(src,event)translateOut(f,str2num(e1.String),1,post);
b13 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.5 0.1 0.1]);
b13.Callback = @(src,event)translateOut(f,str2num(e1.String),2,post);
b14 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.5 0.1 0.1]);
b14.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,2,post);
b15 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.5 0.1 0.1]);
b15.Callback = @(src,event)translateOut(f,str2num(e1.String)*1,3,post);
b16 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.5 0.1 0.1]);
b16.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,3,post);


t2 = uicontrol(p2,'Style','text','String','Scale','Units','normalized','Position',[0.1 0.4 0.4 0.02]);
e2 = uicontrol(p2,'Style','edit','String','Factor','Units','normalized','Position',[0.1 0.3 0.1 0.1]);
b21 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.3 0.1 0.1]);
b21.Callback = @(src,event)scaleOut(f,-1*str2num(e2.String),post);
b22 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.3 0.1 0.1]);
b22.Callback = @(src,event)scaleOut(f,str2num(e2.String),post);
% b23 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.3 0.1 0.1]);
% b23.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),2,post);
% b24 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.3 0.1 0.1]);
% b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),2,post);
% b23 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.3 0.1 0.1]);
% b23.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),3,post);
% b24 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.3 0.1 0.1]);
% b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),3,post);

% b31 = uicontrol(p2,'String','Z-flip','Units','normalized','Position',[0.8 0.3 0.1 0.1]);
% b31.Callback = @(src,event)zflip(f);
% t3 = uicontrol(p2,'Style','text','String','Scaling','Units','normalized','Position',[0.3 0.2 0.4 0.02]);
% e3 = uicontrol(p2,'Style','edit','String','Percentage','Units','normalized','Position',[0.3 0.1 0.1 0.1]);
% b31 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.1 0.1 0.1]);
% b31.Callback = @(src,event)scaleOut(f,str2num(e3.String),dataStruct);
% b32 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.1 0.1 0.1]);
% b32.Callback = @(src,event)scaleOut(f,-1*str2num(e3.String),dataStruct);


% end

% function zflip(f)
% f.Children(3).Children.Children(1).Vertices(:,3) = f.Children(3).Children.Children(2).Vertices(:,3)*-1;
% temp = getappdata(f,'transformPre');
% setappdata(f,'transformPre',temp.*[1 1 1 -1 1 1]);
% end

function translateOut(f,offset,flag,post)
if post == 0
    if flag == 1
        %     'x direction'
        f.Children(3).Children.Children(1).Vertices(:,1) = f.Children(3).Children.Children(1).Vertices(:,1) + offset;
%         dataStruct.transPre(1) = dataStruct.transPre(1) + offset;
        setappdata(f,'transformPre',getappdata(f,'transformPre')+[offset 0 0 0 0 0]);
    elseif flag == 2
        %     'y direction'
        f.Children(3).Children.Children(1).Vertices(:,2) = f.Children(3).Children.Children(1).Vertices(:,2) + offset;
%         dataStruct.transPre(2) = dataStruct.transPre(2) + offset;
        setappdata(f,'transformPre',getappdata(f,'transformPre')+[0 offset 0 0 0 0]);
    elseif flag == 3
        %     'z direction'
        f.Children(3).Children.Children(1).Vertices(:,3) = f.Children(3).Children.Children(1).Vertices(:,3) + offset;
%         dataStruct.transPre(3) = dataStruct.transPre(3) + offset;
        setappdata(f,'transformPre',getappdata(f,'transformPre')+[0 0 offset 0 0 0]);
    end
elseif post == 1
    if flag == 1
        %     'x direction'
        f.Children(3).Children.Children(2).Vertices(:,1) = f.Children(3).Children.Children(2).Vertices(:,1) + offset;
%         dataStruct.transPost(1) = dataStruct.transPost(1) + offset;
        setappdata(f,'transformPost',getappdata(f,'transformPost')+[offset 0 0 0 0 0]);
    elseif flag == 2
        %     'y direction'
        f.Children(3).Children.Children(2).Vertices(:,2) = f.Children(3).Children.Children(2).Vertices(:,2) + offset;
%         dataStruct.transPost(2) = dataStruct.transPost(2) + offset;
        setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 offset 0 0 0 0]);
    elseif flag == 3
        %     'z direction'
        f.Children(3).Children.Children(2).Vertices(:,3) = f.Children(3).Children.Children(2).Vertices(:,3) + offset;
%         dataStruct.transPost(3) = dataStruct.transPost(3) + offset;
        setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 offset 0 0 0]);
    end
end
end

% function rotateOut(f,degs,flag,post)
% %Find centroid (will position closer to condyles naturally as curved
% %surface necessitates more points. subtract the values from the
% %coordinates. rotate using the standard rotation matrix. Add the offset
% %back. Do in single line?
% degs = deg2rad(degs);
% temp = [];
% sizeV = size(f.Children(3).Children.Children(2).Vertices,1);
% if post==0
%     if flag == 1
%         f.Children(3).Children.Children(2).Vertices = [[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
% %         dataStruct.transPre(4) = dataStruct.transPre(4) + degs;
%         setappdata(f,'transformRot',[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*getappdata(f,'transformRot'));
%     elseif flag == 2
%         f.Children(3).Children.Children(2).Vertices = [[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
% %         dataStruct.transPre(5) = dataStruct.transPre(5) + degs;
%         setappdata(f,'transformRot',[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*getappdata(f,'transformRot'));
%     elseif flag == 3
%         f.Children(3).Children.Children(2).Vertices = [[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
% %         dataStruct.transPre(6) = dataStruct.transPre(6) + degs;
%         setappdata(f,'transformRot',[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*getappdata(f,'transformRot'));
%     end
% elseif post==1
%     if flag == 1
%         f.Children(3).Children.Children(2).Vertices = [[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
% %         dataStruct.transPost(4) = dataStruct.transPost(4) + degs;
%         setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 0 degs 0 0]);
%     elseif flag == 2
%         f.Children(3).Children.Children(2).Vertices = [[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
% %         dataStruct.transPost(5) = dataStruct.transPost(5) + degs;
%         setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 0 0 degs 0]);
%     elseif flag == 3
%         f.Children(3).Children.Children(2).Vertices = [[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
% %         dataStruct.transPost(6) = dataStruct.transPost(6) + degs;
%         setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 0 0 0 degs]);
%     end    
% end
% 
% 
% end

function scaleOut(f,factor,post)
%Find centroid (will position closer to condyles naturally as curved
%surface necessitates more points. subtract the values from the
%coordinates. rotate using the standard rotation matrix. Add the offset
%back. Do in single line?
temp = f.Children(3).Children.Children(1).Vertices;
sizeV = size(f.Children(3).Children.Children(1).Vertices,1);
        f.Children(3).Children.Children(1).Vertices = ( (temp-mean(temp))*(1+factor) )+mean(temp);
%         dataStruct.transPre(4) = dataStruct.transPre(4) + degs;
        setappdata(f,'transformSca',getappdata(f,'transformSca')*(1+factor));


end