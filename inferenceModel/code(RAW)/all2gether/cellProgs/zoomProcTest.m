% % zdif = (0.000105355*10^6);
% stepCount = 10;
% stepLocal = 0.0000153634*10^6;
% stepGlobal = 0.0000257868*10^6;
% zWideGlobal = 0.00379655*10^6;
% zWideLocal = 0.0036911946*10^6;
% zStartGlobal = zWideGlobal - stepGlobal*10;
% zStartLocal = zWideLocal - stepLocal*10;
% zdif = zStartGlobal - zStartLocal;
% M = csvread('CB.csv',1,1);
% [object2.vertices, object2.faces] = stlread('R:\projects\nowlan_group_data\live\James\morishita2021\StartG\Stat\4.3TO6.3\4.3L\4.3LG.stl');
% 
% %z correction. may need negative sign for inverted stls
% M(:,3) = ( ((stepGlobal*(stepCount-1))-zdif)-(M(:,3)-1)*stepLocal );
% 
% % figure
% % patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)
% % xlabel('X')
% % ylabel('Y')
% % zlabel('Z')
% 
% %y flip correction
% % temp2 = M;
% % yResZoom = 0.0000006291591759884*10^6;
% % temp2(:,2) = yResZoom*1024-temp2(:,2);
% % figure
% % scatter3(M(:,1),M(:,2),M(:,3))
% % hold on
% % scatter3(temp2(:,1),temp2(:,2),temp2(:,3))
% % hold off
% 
% M(:,2) = yResZoom*1024-M(:,2);
% 
% %xy offset correction - add the difference in stage pos
% zoom = 2.40821651018796;
% stagePosXDiff = 0.000047675757*10^6;
% stagePosYDiff = 0.000166948*10^6;
% M(:,1) = M(:,1) + stagePosXDiff;
% M(:,2) = M(:,2) + stagePosYDiff;
% 
% %convert to stl with fional transform
% test = M;
% test(:,1) = M(:,3);
% test(:,2) = M(:,1) + yResZoom*1024/zoom;
% test(:,3) = M(:,2) + yResZoom*1024/zoom;
% 
% %test plot
% figure
% patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% hold on
% scatter3(test(:,1),test(:,2),test(:,3))
% hold off














% % zdif = (0.000105355*10^6);
% stepCountGlobal = 10;
% stepCountLocal = 10;
% stepLocal = 0.0000153634*10^6;
% stepGlobal = 0.0000257868*10^6;
% zWideGlobal = 0.00379655*10^6;
% zWideLocal = 0.0036911946*10^6;
% zStartGlobal = zWideGlobal - stepGlobal*10;
% zStartLocal = zWideLocal - stepLocal*10;
% zdif = zStartGlobal - zStartLocal;
% zoom = 2.40821651018796;
% yResLocal = 0.0000006291591759884*10^6;
% yResGlobal = 3.03326810176125;
% % stagePosXDiff = -0.000047675757*10^6;
% % stagePosYDiff = -0.000166948*10^6;
% stagePosYDiff = +0.000047675757*10^6;
% stagePosXDiff = -0.000166948*10^6;
% 
% [object2.vertices, object2.faces] = stlread('R:\projects\nowlan_group_data\live\James\morishita2021\StartG\Stat\4.3TO6.3\4.3L\4.3LG.stl');
% 
% M = csvread('CB.csv',1,1);

% zdif = (0.000105355*10^6);
stepCountGlobal = 15;
stepCountLocal = 10;
stepLocal = 0.000012597*10^6;
stepGlobal = 0.0000255398*10^6;
zWideGlobal = 0.0039048724*10^6;
zWideLocal = 0.00367992*10^6;
zStartGlobal = zWideGlobal - stepGlobal*stepCountGlobal;
zStartLocal = zWideLocal - stepLocal*stepCountLocal;
zdif = zStartGlobal - zStartLocal;
zoom = 3;
yResGlobal = 0.0000030332681017613*10^6;
yResLocal = 0.0000006291591759884*10^6;
stagePosXDiff = 0*10^6;
stagePosYDiff = -0.000112388*10^6;

M = csvread('CA.csv',1,1);
[object2.vertices, object2.faces] = stlread('R:\projects\nowlan_group_data\live\James\morishita2021\EndG\Group1\4.3L\4.3LG.stl');

%z correction. may need negative sign for inverted stls
M(:,3) = ( ((stepGlobal*(stepCountGlobal-1))-zdif)-(M(:,3)-1)*stepLocal );

% figure
% patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)
% xlabel('X')
% ylabel('Y')
% zlabel('Z')

%y flip correction
% temp2 = M;
yResLocal = 0.0000006291591759884*10^6;
% temp2(:,2) = yResZoom*1024-temp2(:,2);
% figure
% scatter3(M(:,1),M(:,2),M(:,3))
% hold on
% scatter3(temp2(:,1),temp2(:,2),temp2(:,3))
% hold off

M(:,2) = yResLocal*1024-M(:,2);

%xy offset correction - add the difference in stage pos and the zoom
%offset

M(:,1) = M(:,1) + 0.5*yResGlobal*512*(1-1/zoom);
M(:,2) = M(:,2) + 0.5*yResGlobal*512*(1-1/zoom);
M(:,1) = M(:,1) + stagePosXDiff;
M(:,2) = M(:,2) + stagePosYDiff;

%convert to stl with final transform
test = M;
test(:,1) = M(:,3);
test(:,2) = M(:,1);
test(:,3) = M(:,2);

%transpose to fix x-y axis reversal!!!!!!!!!!!!!!!!!!!!!Need a variable for this
temp = test;
test(:,1) = temp(:,2);
test(:,2) = temp(:,1);
% temp = object2;
% object2.vertices(:,1) = temp.vertices(:,2);
% object2.vertices(:,2) = temp.vertices(:,1);


%test plot
figure
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
scatter3(test(:,1),test(:,2),test(:,3))
hold off