%if the zoomed in image was taken at 512 rather than 1024;
localRes = 1024;

%z correction. may need negative sign for inverted stls
M(:,3) = ( ((stepGlobal*(stepCountGlobal-1))+zdif)-(M(:,3)-1)*stepLocal );

% M(:,3) = -zdif+(M(:,3)-1)*stepLocal ;


%y flip correction
M(:,2) = yResLocal*localRes-M(:,2);

%xy offset correction - add the difference in stage pos and the zoom
%offset
M(:,1) = M(:,1) + 0.5*(yResGlobal*512-yResLocal*localRes);
M(:,2) = M(:,2) + 0.5*(yResGlobal*512-yResLocal*localRes);
% M(:,1) = M(:,1) + stagePosXDiff;
% M(:,2) = M(:,2) + stagePosYDiff;

%convert to stl with final transform
test = M;
% test(:,1) = M(:,3);
% test(:,2) = M(:,1);
% test(:,3) = M(:,2);
% test(:,1) = M(:,1);
% test(:,2) = M(:,3);
% test(:,3) = M(:,2);
test(:,1) = M(:,1);
test(:,2) = M(:,3);
test(:,3) = M(:,2);
% test(:,1) = M(:,3);
% test(:,2) = M(:,1);
% test(:,3) = M(:,2);
M = test;

%transpose to fix x-y axis reversal!!!!!!!!!!!!!!!!!!!!!Need a variable for this
temp = test;
M(:,1) = temp(:,2);
M(:,2) = temp(:,1);

%x/y/z flip - additional
% M(:,1) = mean(M(:,1))-(M(:,1)-mean(M(:,1)));
% 
% M(:,2) = mean(M(:,2))-(M(:,2)-mean(M(:,2)));
% M(:,3) = mean(M(:,3))-(M(:,3)-mean(M(:,3)));

% M = M*[1 0 0;0 0 -1; 0 -1 0];


%test plot
figure
patch('Faces',object2.faces,'Vertices',object2.vertices,'FaceColor','red','LineStyle','none','FaceAlpha',0.3)
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
scatter3(M(:,1),M(:,2),M(:,3))
hold off