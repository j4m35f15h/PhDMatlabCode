function cellTrackF(dataStruct)
post = 0;
f = figure;
b4 = uicontrol(f,'String','Next','Units','normalized','Position',[0.1 0 0.8 0.1]);
b4.Callback = @(src,event)nextFun(dataStruct);
p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
ax = axes(p1);
hold on
imshow(dataStruct.lImagePre(:,:,1))
hold off

s1 = uicontrol(p2,'Style','slider','Units','normalized','Position',[0.2 0.1 0.8 0.1],'SliderStep',[1/(size(dataStruct.lImagePre,3)-1) 1]);
s1.Min = 1;
s1.Max = size(dataStruct.lImagePre,3);
% s1.Callback = 'updateFig';
s1.Value = 1;
s1.Callback = @(src,event)updateFig(s1.Value,dataStruct,0);

b13 = uicontrol(p2,'String','Mark Cell','Units','normalized','Position',[0.4 0.5 0.1 0.1]);
b13.Callback = @(src,event)cellMark(dataStruct,s1,0);

end

function updateFig(val,dataStruct,Post)

if Post==0
    imshow(dataStruct.lImagePre(:,:,val))
elseif Post == 1
    imshow(dataStruct.lImagePost(:,:,val))
end
end

function cellMark(dataStruct,s1,Post)
if Post == 0
    zoomCentre = floor(ginput());
    imshow(dataStruct.lImagePre(zoomCentre(2)-50:zoomCentre(2)+50,zoomCentre(1)-50:zoomCentre(1)+50,s1.Value))
    dataStruct.cellCoordPre = [dataStruct.cellCoordPre;ginput()+[zoomCentre(1)-50 zoomCentre(2)-50],s1.Value];
    imshow(dataStruct.lImagePre(:,:,s1.Value));
elseif Post == 1
    dataStruct.cellCoordPost = [dataStruct.cellCoordPost;ginput(),s1.Value];
end
end

function nextFun(dataStruct)

closereq()

f = figure;
b4 = uicontrol(f,'String','Next','Units','normalized','Position',[0.1 0 0.8 0.1]);
b4.Callback = nextFun(dataStruct);
p1 = uipanel(f,'Position',[0.1 0.1 0.4 0.8]);
p2 = uipanel(f,'Position',[0.5 0.1 0.4 0.8]);
ax = axes(p1);
hold on
plot(ax,dataStruct.lImagePost(:,:,1))
hold off

s1 = uicontrol(p1,'Style','slider','Units','normalized','Position',[0.2 0.1 0.8 0.1]);
s1.Limits = [1 size(dataStruct.lImagePost,3)];
s1.ValueChangedFcn = @(src,event)updateFig(s1.Value,ax,dataStruct,1);

b13 = uicontrol(p2,'String','Mark Cell','Units','normalized','Position',[0.4 0.5 0.1 0.1]);
b13.Callback = @(src,event)cellMark(dataStruct,s1,1);



end