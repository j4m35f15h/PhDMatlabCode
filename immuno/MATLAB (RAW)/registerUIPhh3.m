%Ok so this is a copy of the reigter ui but to include the transformation
%applied/ also apply it to the PHH3 data. For the latter, the program
%proceeds as normal, except we also apply the transfomration to parallel
%phh3 data loaded in


% filename = '25p';
% dataStruct = [];
% regList = dir('\\rds.imperial.ac.uk\rds\project\nowlan_group_data\live\James\septemberExp20\FIGURES\D0\25p');
% regList2 = dir('\\rds.imperial.ac.uk\rds\project\nowlan_group_data\live\James\septemberExp20\FIGURES\D0\25pPhh3'); 
% 
% for i = 3:size(regList,1)
%     T = readtable(regList(i).name);
%     T2 = readtable(regList2(i).name);
%     dataStruct(i-2).data = [T.X,T.Y];
%     dataStruct(i-2).phh3 = [T2.X,T2.Y];
%     if regList(i).name(2) == 'L' || regList(i).name(3) == 'L'
%         dataStruct(i-2).data(:,2) = -dataStruct(i-2).data(:,2);
%         dataStruct(i-2).phh3(:,2) = -dataStruct(i-2).phh3(:,2);
%     end
% end
% 
% bigRange = zeros(1,2);
% for i = 1:size(dataStruct,2)
%     temp = range(dataStruct(i).data(:,1))*range(dataStruct(i).data(:,2));
%     if temp-bigRange(1) > 0
%         bigRange(1) = temp;
%         bigRange(2) = i;
%     end
% end
% 
% temp = dataStruct(1).data;
% temp2 = dataStruct(1).phh3;
% dataStruct(1).data = dataStruct(bigRange(2)).data;
% dataStruct(1).phh3 = dataStruct(bigRange(2)).phh3;
% dataStruct(bigRange(2)).data = temp;
% dataStruct(bigRange(2)).phh3 = temp2;

i = 2;

f = figure;
b4 = uicontrol(f,'String','Save','Units','normalized','Position',[0.1 0 0.8 0.1]);
b4.Callback = @(src,event)saveClose(f,filename,dataStruct,i);
p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
ax = axes(p1);
hold on
k = boundary(dataStruct(1).data(:,1),dataStruct(1).data(:,2));
plot(dataStruct(1).data(k,1),dataStruct(1).data(k,2))
k = boundary(dataStruct(i).data(:,1),dataStruct(i).data(:,2));
plot(dataStruct(i).data(k,1),dataStruct(i).data(k,2))

hold off
f.Children(2).Children.Children(1).UserData = [0 0 0 1];

t1 = uicontrol(p2,'Style','text','String','Translation','Units','normalized','Position',[0.1 0.6 0.4 0.02]);
e1 = uicontrol(p2,'Style','edit','String','Pixels','Units','normalized','Position',[0.1 0.5 0.1 0.1]);
b11 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.5 0.1 0.1]);
b11.Callback = @(src,event)translateOut(f,-1*str2num(e1.String),dataStruct,1,i);
b12 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.5 0.1 0.1]);
b12.Callback = @(src,event)translateOut(f,str2num(e1.String),dataStruct,1,i);
b13 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.5 0.1 0.1]);
b13.Callback = @(src,event)translateOut(f,str2num(e1.String),dataStruct,2,i);
b14 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.5 0.1 0.1]);
b14.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,dataStruct,2,i);
% b15 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.5 0.1 0.1]);
% b15.Callback = @(src,event)translateOut(f,str2num(e1.String)*1,dataStruct,3);
% b16 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.5 0.1 0.1]);
% b16.Callback = @(src,event)translateOut(f,str2num(e1.String)*-1,dataStruct,3);


t2 = uicontrol(p2,'Style','text','String','Rotation','Units','normalized','Position',[0.1 0.4 0.4 0.02]);
e2 = uicontrol(p2,'Style','edit','String','Degrees','Units','normalized','Position',[0.1 0.3 0.1 0.1]);
b21 = uicontrol(p2,'String','<','Units','normalized','Position',[0.2 0.3 0.1 0.1]);
b21.Callback = @(src,event)rotateOut(f,-1*str2num(e2.String),dataStruct,1,i);
b22 = uicontrol(p2,'String','>','Units','normalized','Position',[0.3 0.3 0.1 0.1]);
b22.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,1,i);
% b23 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.3 0.1 0.1]);
% b23.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,2);
% b24 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.3 0.1 0.1]);
% b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,2);
% b23 = uicontrol(p2,'String','.','Units','normalized','Position',[0.6 0.3 0.1 0.1]);
% b23.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,3);
% b24 = uicontrol(p2,'String','O','Units','normalized','Position',[0.7 0.3 0.1 0.1]);
% b24.Callback = @(src,event)rotateOut(f,str2num(e2.String),dataStruct,3);

t3 = uicontrol(p2,'Style','text','String','Scaling','Units','normalized','Position',[0.3 0.2 0.4 0.02]);
e3 = uicontrol(p2,'Style','edit','String','Percentage','Units','normalized','Position',[0.3 0.1 0.1 0.1]);
b31 = uicontrol(p2,'String','^','Units','normalized','Position',[0.4 0.1 0.1 0.1]);
b31.Callback = @(src,event)scaleOut(f,str2num(e3.String),dataStruct);
b32 = uicontrol(p2,'String','v','Units','normalized','Position',[0.5 0.1 0.1 0.1]);
b32.Callback = @(src,event)scaleOut(f,-1*str2num(e3.String),dataStruct);


function translateOut(f,offset,dataStruct,flag,i)
if flag == 1
    %     'x direction'
%     dataStruct(i).data(:,1) = dataStruct(i).data(:,1) + offset;
%     assignin('base','dataStruct',dataStruct)
    f.Children(2).Children.Children(1).XData = f.Children(2).Children.Children(1).XData + offset;
    f.Children(2).Children.Children(1).UserData(1) = f.Children(2).Children.Children(1).UserData(1) + offset;
    %     dataStruct(i).Trans(1) = dataStruct(i).Trans(1) + offset;
    
elseif flag == 2
    %     'y direction'
%     dataStruct(i).data(:,2) = dataStruct(i).data(:,2) + offset;
%     assignin('base','dataStruct',dataStruct)
    f.Children(2).Children.Children(1).YData = f.Children(2).Children.Children(1).YData + offset;    
    f.Children(2).Children.Children(1).UserData(2) = f.Children(2).Children.Children(1).UserData(2) + offset;
    %     dataStruct(i).Trans(2) = dataStruct.Trans(2) + offset;

elseif flag == 3
    %     'z direction'
    f.Children(2).Children.Children(1).Vertices(:,3) = f.Children(3).Children.Children.Vertices(:,3) + offset;
    dataStruct.Trans(3) = dataStruct.Trans(3) + offset;
end
assignin('base','dataStruct',dataStruct);
end

function rotateOut(f,degs,dataStruct,flag,i)
%Find centroid (will position closer to condyles naturally as curved
%surface necessitates more points. subtract the values from the
%coordinates. rotate using the standard rotation matrix. Add the offset
%back. Do in single line?
degs = deg2rad(degs);
temp = [];
% sizeV = size(f.Children(3).Children.Children.Vertices,1);
if flag == 1
    %     for i = 1:size(f.Children(3).Children.Children.Vertices,1)
    %         temp = [temp;[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children.Vertices(i,1) - mean(f.Children(3).Children.Children.Vertices(:,1));f.Children(3).Children.Children.Vertices(i,2) - mean(f.Children(3).Children.Children.Vertices(:,2));f.Children(3).Children.Children.Vertices(i,3) - mean(f.Children(3).Children.Children.Vertices(:,3));]+[mean(f.Children(3).Children.Children.Vertices(:,1));mean(f.Children(3).Children.Children.Vertices(:,2));mean(f.Children(3).Children.Children.Vertices(:,3))]];
    %     end
    %     f.Children(3).Children.Children.Vertices(:,1) = temp(1:3:end);
    %     f.Children(3).Children.Children.Vertices(:,2) = temp(2:3:end);
    %     f.Children(3).Children.Children.Vertices(:,3) = temp(3:3:end);
%     f.Children(3).Children.Children.Vertices = [[1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)]*[f.Children(3).Children.Children.Vertices(:,1) - mean(f.Children(3).Children.Children.Vertices(:,1)),f.Children(3).Children.Children.Vertices(:,2) - mean(f.Children(3).Children.Children.Vertices(:,2)),f.Children(3).Children.Children.Vertices(:,3) - mean(f.Children(3).Children.Children.Vertices(:,3))]']' + [ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,1)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,2)),ones(sizeV,1)*mean(f.Children(3).Children.Children.Vertices(:,3))];
    temp = [f.Children(2).Children.Children(1).XData',f.Children(2).Children.Children(1).YData'];
    R = [cos(degs) -sin(degs); sin(degs) cos(degs)];
    centre = mean(temp);
    temp = temp - ones(size(temp,1),1)*centre;
    temp = temp*R;
    temp = temp + ones(size(temp,1),1)*centre;
    f.Children(2).Children.Children(1).XData = temp(:,1)';
    f.Children(2).Children.Children(1).YData = temp(:,2)';
    f.Children(2).Children.Children(1).UserData(3) = f.Children(2).Children.Children(1).UserData(3) + degs;

%     temp = dataStruct(i).data;
%     centre = mean(temp);
%     temp = temp - ones(size(temp,1),1)*centre;
%     temp = temp*R;
%     temp = temp + ones(size(temp,1),1)*centre;
%     dataStruct(i).data = temp;
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

function scaleOut(f,scale,dataStruct)

temp = [f.Children(2).Children.Children(1).XData',f.Children(2).Children.Children(1).YData'];
centre = mean(temp);
f.Children(2).Children.Children(1).XData = (f.Children(2).Children.Children(1).XData-centre(1))*(1+scale/100)+centre(1) ;
f.Children(2).Children.Children(1).UserData(4) = f.Children(2).Children.Children(1).UserData(4)*(1+scale/100);
end

function saveClose(f,filename,dataStruct,i)
% save(['R:\projects\nowlan_group_data\live\James\septemberExp20\FIGURES\Static\D2\',filename],'dataStruct')

dataStruct(i).data(:,1) = dataStruct(i).data(:,1) + f.Children(2).Children.Children(1).UserData(1);
dataStruct(i).data(:,2) = dataStruct(i).data(:,2) + f.Children(2).Children.Children(1).UserData(2);

dataStruct(i).phh3(:,1) = dataStruct(i).phh3(:,1) + f.Children(2).Children.Children(1).UserData(1);
dataStruct(i).phh3(:,2) = dataStruct(i).phh3(:,2) + f.Children(2).Children.Children(1).UserData(2);

degs = f.Children(2).Children.Children(1).UserData(3);
R = [cos(degs) -sin(degs); sin(degs) cos(degs)];
% k = boundary(dataStruct(i).data(:,1),dataStruct(i).data(:,2));
temp = dataStruct(i).data;
% centre = mean(temp(k,:));
centre = mean(temp);
temp = temp - ones(size(temp,1),1)*centre;
temp = temp*R;
temp = temp + ones(size(temp,1),1)*centre;
dataStruct(i).data = temp;

% dataStruct(i).data(:,1) = (dataStruct(i).data(:,1)-centre(1))*f.Children(2).Children.Children(1).UserData(4)+centre(1) ;

degs = f.Children(2).Children.Children(1).UserData(3);
R = [cos(degs) -sin(degs); sin(degs) cos(degs)];
k = boundary(dataStruct(i).phh3(:,1),dataStruct(i).phh3(:,2));
temp = dataStruct(i).phh3;
% centre = mean(temp(k,:));
temp = temp - ones(size(temp,1),1)*centre;
temp = temp*R;
temp = temp + ones(size(temp,1),1)*centre;
dataStruct(i).phh3 = temp;
% dataStruct(i).phh3(:,1) = (dataStruct(i).phh3(:,1)-ones(size(temp,1))*centre(1))*f.Children(2).Children.Children(1).UserData(4)+ones(size(temp,1))*centre(1) ;

assignin('base','dataStruct',dataStruct);
close
end