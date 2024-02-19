
f = figure;
b4 = uicontrol(f,'String','Save','Units','normalized','Position',[0.1 0 0.8 0.1]);
b4.Callback = @(src,event)saveClose(filename,dataStruct);
p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
ax = axes(p1);
hold on
% plot(ax,ideal(1:end/2),ideal(1+end/2:end))
% plot(ax,dataStruct.Outline(1:end/2),dataStruct.Outline(1+end/2:end))
patch('Faces',object.faces,'Vertices',object.vertices,'FaceColor','red','LineStyle','none')
hold off
t1 = uicontrol(p2,'Style','text','String','Translation','Units','normalized','Position',[0.1 0.6 0.4 0.02]);
e1 = uicontrol(p2,'Style','edit','String','Pixels','Units','normalized','Position',[0.1 0.5 0.1 0.1]);
b11 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.5 0.1 0.1]);
b11.Callback = @(src,event)translateOut(f,-1*str2num(e1.String),dataStruct,1);
b12 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.5 0.1 0.1]);
b12.Callback = @(src,event)translateOut(f,str2num(e1.String),dataStruct,1);
b13 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.5 0.1 0.1]);
b13.Callback = @(src,event)translateOut(f,str2num(e1.String),dataStruct,2);
b14 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.5 0.1 0.1]);
b14.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,dataStruct,2);
b15 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.5 0.1 0.1]);
b15.Callback = @(src,event)translateOut(f,str2num(e1.String)*1,dataStruct,3);
b16 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.5 0.1 0.1]);
b16.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,dataStruct,3);


t2 = uicontrol(p2,'Style','text','String','Rotation','Units','normalized','Position',[0.1 0.4 0.4 0.02]);
e2 = uicontrol(p2,'Style','edit','String','Degrees','Units','normalized','Position',[0.1 0.3 0.1 0.1]);
b21 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.3 0.1 0.1]);
b21.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),dataStruct,1);
b22 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.3 0.1 0.1]);
b22.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,1);
b23 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.3 0.1 0.1]);
b23.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,2);
b24 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.3 0.1 0.1]);
b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,2);
b23 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.3 0.1 0.1]);
b23.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,3);
b24 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.3 0.1 0.1]);
b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,3);

t3 = uicontrol(p2,'Style','text','String','Scaling','Units','normalized','Position',[0.3 0.2 0.4 0.02]);
e3 = uicontrol(p2,'Style','edit','String','Percentage','Units','normalized','Position',[0.3 0.1 0.1 0.1]);
b31 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.1 0.1 0.1]);
b31.Callback = @(src,event)scaleOut(f,str2num(e3.String),dataStruct);
b32 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.1 0.1 0.1]);
b32.Callback = @(src,event)scaleOut(f,-1*str2num(e3.String),dataStruct);


function translateOut(f,offset,dataStruct,flag)
if flag == 1
    %     'x direction'
    f.Children(3).Children.Children.Vertices(:,1) = f.Children(3).Children.Children.Vertices(:,1) + offset;
    dataStruct.Trans(1) = dataStruct.Trans(1) + offset;
elseif flag == 2
    %     'y direction'
    f.Children(3).Children.Children.Vertices(:,2) = f.Children(3).Children.Children.Vertices(:,2) + offset;
    dataStruct.Trans(2) = dataStruct.Trans(2) + offset;
elseif flag == 3
    %     'z direction'
    f.Children(3).Children.Children.Vertices(:,3) = f.Children(3).Children.Children.Vertices(:,3) + offset;
    dataStruct.Trans(3) = dataStruct.Trans(3) + offset;
end
end

function rotateOut(f,degs,dataStruct,flag)
%Find centroid (will position closer to condyles naturally as curved
%surface necessitates more points. subtract the values from the
%coordinates. rotate using the standard rotation matrix. Add the offset
%back. Do in single line?
degs = deg2rad(degs);
temp = [];
sizeV = size(f.Children(3).Children.Children.Vertices,1);
if flag == 1
    %     for i = 1:size(f.Children(3).Children.Children.Vertices,1)
    %         temp = [temp;[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children.Vertices(i,1) - mean(f.Children(3).Children.Children.Vertices(:,1));f.Children(3).Children.Children.Vertices(i,2) - mean(f.Children(3).Children.Children.Vertices(:,2));f.Children(3).Children.Children.Vertices(i,3) - mean(f.Children(3).Children.Children.Vertices(:,3));]+[mean(f.Children(3).Children.Children.Vertices(:,1));mean(f.Children(3).Children.Children.Vertices(:,2));mean(f.Children(3).Children.Children.Vertices(:,3))]];
    %     end
    %     f.Children(3).Children.Children.Vertices(:,1) = temp(1:3:end);
    %     f.Children(3).Children.Children.Vertices(:,2) = temp(2:3:end);
    %     f.Children(3).Children.Children.Vertices(:,3) = temp(3:3:end);
    f.Children(3).Children.Children.Vertices = [[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children.Vertices(:,1) - mean(f.Children(3).Children.Children.Vertices(:,1)),f.Children(3).Children.Children.Vertices(:,2) - mean(f.Children(3).Children.Children.Vertices(:,2)),f.Children(3).Children.Children.Vertices(:,3) - mean(f.Children(3).Children.Children.Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,3))];
    
    dataStruct.Trans(4) = dataStruct.Trans(4) + degs;
elseif flag == 2
    %     for i = 1:size(f.Children(2).Children.Children.Vertices,1)
    %         temp = [temp;[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(2).Children.Children.Vertices(i,1) - mean(f.Children(2).Children.Children.Vertices(:,1)),f.Children(2).Children.Children.Vertices(i,2) - mean(f.Children(2).Children.Children.Vertices(:,2)),f.Children(2).Children.Children.Vertices(i,3) - mean(f.Children(2).Children.Children.Vertices(:,3));]+[mean(f.Children(2).Children.Children.Vertices(:,1));mean(f.Children(2).Children.Children.Vertices(:,2));mean(f.Children(2).Children.Children.Vertices(i,3))]];
    %     end
    %     f.Children(2).Children.Children.Vertices(:,1) = temp(1:3:end);
    %     f.Children(2).Children.Children.Vertices(:,2) = temp(2:3:end);
    %     f.Children(2).Children.Children.Vertices(:,3) = temp(3:3:end);
    f.Children(3).Children.Children.Vertices = [[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)]*[f.Children(3).Children.Children.Vertices(:,1) - mean(f.Children(3).Children.Children.Vertices(:,1)),f.Children(3).Children.Children.Vertices(:,2) - mean(f.Children(3).Children.Children.Vertices(:,2)),f.Children(3).Children.Children.Vertices(:,3) - mean(f.Children(3).Children.Children.Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,3))];
    dataStruct.Trans(5) = dataStruct.Trans(5) + degs;
elseif flag == 3
    %     for i = 1:size(f.Children(2).Children.Children.Vertices,1)
    %         temp = [temp;[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(2).Children.Children.Vertices(i,1) - mean(f.Children(2).Children.Children.Vertices(:,1));f.Children(2).Children.Children.Vertices(i,2) - mean(f.Children(2).Children.Children.Vertices(:,2));f.Children(2).Children.Children.Vertices(i,3) - mean(f.Children(2).Children.Children.Vertices(:,3));]+[mean(f.Children(2).Children.Children.Vertices(:,1));mean(f.Children(2).Children.Children.Vertices(:,2));mean(f.Children(2).Children.Children.Vertices(i,3))]];
    %     end
    %     f.Children(2).Children.Children.Vertices(:,1) = temp(1:3:end);
    %     f.Children(2).Children.Children.Vertices(:,2) = temp(2:3:end);
    %     f.Children(2).Children.Children.Vertices(:,3) = temp(3:3:end);
    f.Children(3).Children.Children.Vertices = [[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1]*[f.Children(3).Children.Children.Vertices(:,1) - mean(f.Children(3).Children.Children.Vertices(:,1)),f.Children(3).Children.Children.Vertices(:,2) - mean(f.Children(3).Children.Children.Vertices(:,2)),f.Children(3).Children.Children.Vertices(:,3) - mean(f.Children(3).Children.Children.Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,3))];
    dataStruct.Trans(6) = dataStruct.Trans(6) + degs;
end

% temp = [cos(degs),sin(degs);-sin(degs),cos(degs)]*[f.Children(2).Children.Children.XData - mean(f.Children(2).Children.Children.XData);f.Children(2).Children.Children.YData - mean(f.Children(2).Children.Children.YData)]+[ones(size(f.Children(2).Children.Children.YData))*mean(f.Children(2).Children.Children.XData);ones(size(f.Children(2).Children.Children.YData))*mean(f.Children(2).Children.Children.YData)];
% f.Children(2).Children.Children.XData = temp(1:end/2);
% f.Children(2).Children.Children.YData = temp(1+end/2:end);
%3D rotation arrays:
%[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)];
%[cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)];
%[cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1];

end

function saveClose(filename,dataStruct)
save(['H:\Desktop\PhD\matlab scripts\limbStore\',filename],'dataStruct')
close
end