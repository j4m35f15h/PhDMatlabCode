% function dataStruct = ui3DF(dataStruct,object1,object2)
% [object1.vertices, object1.faces] = stlread('R:\projects\nowlan_group_data\live\James\PhD\matlab scripts\stl\pre3\idealtiblowres.stl');
% [object1.vertices, object1.faces] = stlread('R:\projects\nowlan_group_data\live\James\morishita2021\D4Static.stl');
% [object1.vertices, object1.faces] = stlread('D4Static.stl');

% [object1.vertices, object1.faces] = stlread('idealtiblowres.stl');
% load('idealStartScaled.mat')
load('idealDynScaled.mat');
% load('idealStatScaled.mat');
object1 = object2;

% groupNum = 'Group14\';
limbname = '19.2R';
% [object1.vertices, object1.faces] = stlread('R:\projects\nowlan_group_data\live\James\PhD\matlab scripts\stl\september2020\D4Dynmesh.stl');
% [object1.vertices, object1.faces] = stlread('D4Dynmesh.stl');
% [object2.vertices, object2.faces] = stlread('R:\projects\nowlan_group_data\live\James\morishita2021\EndG\GROUP4\11.3R\11.3RG.stl');
% addpath(['StartG\Dyn\',groupNum,limbname])
[object2.vertices, object2.faces] = stlread([limbname,'G.stl']);
temp22 = mean(object2.vertices);
temp2 = mean(object2.vertices);
object2.vertices(:,1) = -object2.vertices(:,1);


% addpath(['limbCoordinate\Stat\',limbname])
load('CA.mat')
M(:,1) = -M(:,1);
% rmpath(['limbCoordinate\Stat\',limbname])

load('transformG.mat')
% rmpath(['StartG\',groupNum,limbname])

    object2.vertices(:,3) = object2.vertices(:,3)*dataStruct.transPre(4);
    % object.vertices = object.vertices - dataStruct.transOrigin.*[1 1 dataStruct.transPre(4)];



    temp = mean(object2.vertices);
    object2.vertices = object2.vertices - temp;
    object2.vertices = [dataStruct.transRot*object2.vertices']';
    % object.vertices = object.vertices + dataStruct.transOrigin.*[1 1 dataStruct.transPre(4)];
    object2.vertices = object2.vertices + temp;
        
% %     M(:,1) = -M(:,1);
    
    M(:,3) = M(:,3)*dataStruct.transPre(4);
%     temp22(1) = -temp22(1);
%     temp22(3) = temp22(3)*dataStruct.transPre(4);
   
    M = M - temp;
    M = [dataStruct.transRot*M']';
    M = M + temp;
    
    M = M + dataStruct.transPre(1:3);
object2.vertices = object2.vertices + dataStruct.transPre(1:3);

post = 0;
f = figure;
setappdata(f,'transformPre',dataStruct.transPre);
setappdata(f,'transformRot',dataStruct.transRot);
% setappdata(f,'transformPre',[0 0 0 1 0 0]);
% setappdata(f,'transformRot',eye(3));
% setappdata(f,'transformPost',[0 0 0 0 0 0]);
b4 = uicontrol(f,'String','Next','Units','normalized','Position',[0.1 0 0.4 0.1]);
% b4.Callback = @(src,event)saveClose(object2,dataStruct);
b4.Callback = 'changeTime';
b5 = uicontrol(f,'String','S&Q','Units','normalized','Position',[0.5 0 0.4 0.1]);
b5.Callback = "dataStruct.transPre = getappdata(f,'transformPre');dataStruct.transRot = getappdata(f,'transformRot');dataStruct.transOrigin = temp2";
p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
ax = axes(p1);
hold on
% plot(ax,ideal(1:end/2),ideal(1+end/2:end))
% plot(ax,dataStruct.Outline(1:end/2),dataStruct.Outline(1+end/2:end))
% temp = im2vol(dataStruct.gImagePre);
% temp.vertices(:,1) = temp.vertices(:,1)*dataStruct.xRes;
% temp.vertices(:,2) = temp.vertices(:,2)*dataStruct.yRes;
% temp.vertices(:,3) = temp.vertices(:,3)*dataStruct.zRes;
patch('Faces',object1.faces,'Vertices',object1.vertices,'FaceColor','blue')
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)

scatter3(M(:,1),M(:,2),M(:,3))
hold off
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


t2 = uicontrol(p2,'Style','text','String','Rotation','Units','normalized','Position',[0.1 0.4 0.4 0.02]);
e2 = uicontrol(p2,'Style','edit','String','Degrees','Units','normalized','Position',[0.1 0.3 0.1 0.1]);
b21 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.3 0.1 0.1]);
b21.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),1,post);
b22 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.3 0.1 0.1]);
b22.Callback = @(src,event)rotateOut(f,str2num(e2.String),1,post);
b23 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.3 0.1 0.1]);
b23.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),2,post);
b24 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.3 0.1 0.1]);
b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),2,post);
b23 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.3 0.1 0.1]);
b23.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),3,post);
b24 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.3 0.1 0.1]);
b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),3,post);

b31 = uicontrol(p2,'String','Z-flip','Units','normalized','Position',[0.8 0.3 0.1 0.1]);
b31.Callback = @(src,event)zflip(f);
% t3 = uicontrol(p2,'Style','text','String','Scaling','Units','normalized','Position',[0.3 0.2 0.4 0.02]);
% e3 = uicontrol(p2,'Style','edit','String','Percentage','Units','normalized','Position',[0.3 0.1 0.1 0.1]);
% b31 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.1 0.1 0.1]);
% b31.Callback = @(src,event)scaleOut(f,str2num(e3.String),dataStruct);
% b32 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.1 0.1 0.1]);
% b32.Callback = @(src,event)scaleOut(f,-1*str2num(e3.String),dataStruct);


% end

function zflip(f)
f.Children(3).Children.Children(2).Vertices(:,3) = f.Children(3).Children.Children(2).Vertices(:,3)*-1;
f.Children(3).Children.Children(1).ZData = f.Children(3).Children.Children(1).ZData*-1;
temp = getappdata(f,'transformPre');
setappdata(f,'transformPre',temp.*[1 1 1 -1 1 1]);
end

function translateOut(f,offset,flag,post)
if post == 0
    if flag == 1
        %     'x direction'
        f.Children(3).Children.Children(2).Vertices(:,1) = f.Children(3).Children.Children(2).Vertices(:,1) + offset;
                f.Children(3).Children.Children(1).XData = f.Children(3).Children.Children(1).XData + offset;
%         dataStruct.transPre(1) = dataStruct.transPre(1) + offset;
        setappdata(f,'transformPre',getappdata(f,'transformPre')+[offset 0 0 0 0 0]);
    elseif flag == 2
        %     'y direction'
        f.Children(3).Children.Children(2).Vertices(:,2) = f.Children(3).Children.Children(2).Vertices(:,2) + offset;
                f.Children(3).Children.Children(1).YData = f.Children(3).Children.Children(1).YData + offset;
%         dataStruct.transPre(2) = dataStruct.transPre(2) + offset;
        setappdata(f,'transformPre',getappdata(f,'transformPre')+[0 offset 0 0 0 0]);
    elseif flag == 3
        %     'z direction'
        f.Children(3).Children.Children(2).Vertices(:,3) = f.Children(3).Children.Children(2).Vertices(:,3) + offset;
                f.Children(3).Children.Children(1).ZData = f.Children(3).Children.Children(1).ZData + offset;
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

function rotateOut(f,degs,flag,post)
%Find centroid (will position closer to condyles naturally as curved
%surface necessitates more points. subtract the values from the
%coordinates. rotate using the standard rotation matrix. Add the offset
%back. Do in single line?
degs = deg2rad(degs);
temp = [f.Children(3).Children.Children(1).XData',f.Children(3).Children.Children(1).YData',f.Children(3).Children.Children(1).ZData',];
sizeV = size(f.Children(3).Children.Children(2).Vertices,1);
if post==0
    if flag == 1
        f.Children(3).Children.Children(2).Vertices = [[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
                    
        temp = (   ([1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*(temp-mean(f.Children(3).Children.Children(2).Vertices))')+ mean(f.Children(3).Children.Children(2).Vertices)'   )';            
        f.Children(3).Children.Children(1).XData = temp(:,1)';
        f.Children(3).Children.Children(1).YData = temp(:,2)';
        f.Children(3).Children.Children(1).ZData = temp(:,3)';
        
        setappdata(f,'transformRot',[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*getappdata(f,'transformRot'));
    elseif flag == 2
        f.Children(3).Children.Children(2).Vertices = [[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
%         dataStruct.transPre(5) = dataStruct.transPre(5) + degs;
        temp = (   ([cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*(temp-mean(f.Children(3).Children.Children(2).Vertices))')+ mean(f.Children(3).Children.Children(2).Vertices)'   )';            
        f.Children(3).Children.Children(1).XData = temp(:,1)';
        f.Children(3).Children.Children(1).YData = temp(:,2)';
        f.Children(3).Children.Children(1).ZData = temp(:,3)';

        setappdata(f,'transformRot',[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*getappdata(f,'transformRot'));
    elseif flag == 3
        f.Children(3).Children.Children(2).Vertices = [[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
        
        temp = (   ([cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*(temp-mean(f.Children(3).Children.Children(2).Vertices))')+ mean(f.Children(3).Children.Children(2).Vertices)'   )';            
        f.Children(3).Children.Children(1).XData = temp(:,1)';
        f.Children(3).Children.Children(1).YData = temp(:,2)';
        f.Children(3).Children.Children(1).ZData = temp(:,3)';
        
        %       dataStruct.transPre(6) = dataStruct.transPre(6) + degs;
        setappdata(f,'transformRot',[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*getappdata(f,'transformRot'));
    end
elseif post==1
    if flag == 1
        f.Children(3).Children.Children(2).Vertices = [[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
%         dataStruct.transPost(4) = dataStruct.transPost(4) + degs;
        setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 0 degs 0 0]);
    elseif flag == 2
        f.Children(3).Children.Children(2).Vertices = [[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
%         dataStruct.transPost(5) = dataStruct.transPost(5) + degs;
        setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 0 0 degs 0]);
    elseif flag == 3
        f.Children(3).Children.Children(2).Vertices = [[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*[f.Children(3).Children.Children(2).Vertices(:,1) - mean(f.Children(3).Children.Children(2).Vertices(:,1)),f.Children(3).Children.Children(2).Vertices(:,2) - mean(f.Children(3).Children.Children(2).Vertices(:,2)),f.Children(3).Children.Children(2).Vertices(:,3) - mean(f.Children(3).Children.Children(2).Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children(2).Vertices(:,3))];
%         dataStruct.transPost(6) = dataStruct.transPost(6) + degs;
        setappdata(f,'transformPost',getappdata(f,'transformPost')+[0 0 0 0 0 degs]);
    end    
end


end

% function saveClose(object1,dataStruct)
% closereq()
% f = figure;
% b4 = uicontrol(f,'String','Close','Units','normalized','Position',[0.1 0 0.8 0.1]);
% b4.Callback = "[dataStruct.transPre dataStruct.transPost] = deal(getappdata(f,'transformPre'),getappdata(f,'transformPost'))";
% p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
% p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
% ax = axes(p1);
% hold on
% % plot(ax,ideal(1:end/2),ideal(1+end/2:end))
% % plot(ax,dataStruct.Outline(1:end/2),dataStruct.Outline(1+end/2:end))
% temp = im2vol(dataStruct.gImagePost);
% patch('Faces',temp.faces,'Vertices',temp.vertices,'FaceColor','red','LineStyle','none')
% patch('Faces',object1.faces,'Vertices',object1.vertices,'FaceColor','red','LineStyle','none')
% hold off
% t1 = uicontrol(p2,'Style','text','String','Translation','Units','normalized','Position',[0.1 0.6 0.4 0.02]);
% e1 = uicontrol(p2,'Style','edit','String','Pixels','Units','normalized','Position',[0.1 0.5 0.1 0.1]);
% b11 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.5 0.1 0.1]);
% b11.Callback = @(src,event)translateOut(f,-1*str2num(e1.String),dataStruct,1,1);
% b12 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.5 0.1 0.1]);
% b12.Callback = @(src,event)translateOut(f,str2num(e1.String),dataStruct,1,1);
% b13 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.5 0.1 0.1]);
% b13.Callback = @(src,event)translateOut(f,str2num(e1.String),dataStruct,2,1);
% b14 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.5 0.1 0.1]);
% b14.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,dataStruct,2,1);
% b15 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.5 0.1 0.1]);
% b15.Callback = @(src,event)translateOut(f,str2num(e1.String)*1,dataStruct,3,1);
% b16 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.5 0.1 0.1]);
% b16.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,dataStruct,3,1);
% 
% 
% t2 = uicontrol(p2,'Style','text','String','Rotation','Units','normalized','Position',[0.1 0.4 0.4 0.02]);
% e2 = uicontrol(p2,'Style','edit','String','Degrees','Units','normalized','Position',[0.1 0.3 0.1 0.1]);
% b21 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.3 0.1 0.1]);
% b21.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),dataStruct,1,1);
% b22 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.3 0.1 0.1]);
% b22.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,1,1);
% b23 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.3 0.1 0.1]);
% b23.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,2,1);
% b24 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.3 0.1 0.1]);
% b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,2,1);
% b23 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.3 0.1 0.1]);
% b23.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,3,1);
% b24 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.3 0.1 0.1]);
% b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,3,1);
% 
% t3 = uicontrol(p2,'Style','text','String','Scaling','Units','normalized','Position',[0.3 0.2 0.4 0.02]);
% e3 = uicontrol(p2,'Style','edit','String','Percentage','Units','normalized','Position',[0.3 0.1 0.1 0.1]);
% b31 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.1 0.1 0.1]);
% b31.Callback = @(src,event)scaleOut(f,str2num(e3.String),dataStruct);
% b32 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.1 0.1 0.1]);
% b32.Callback = @(src,event)scaleOut(f,-1*str2num(e3.String),dataStruct);
% end


