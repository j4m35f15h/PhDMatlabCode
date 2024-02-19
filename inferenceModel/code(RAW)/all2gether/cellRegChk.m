% function [dataStruct] = cellRegChk(dataStruct)
%At this point, data struct contains the ekll coordinates before and after
%growth, with another component indicating which cells are matches.

%The structure of this should be pretty simple. 2 panel ui arranged 
%vertically has plots for two parts. The first part will have a no fill
%scatter held with a fill scatter. The fill scatter will be for the
%highlighted coordinate. This will be the same in the second plot, with
%each being for the pre and post cell coordinates.

%The second panle will contain the buttons/slider for the manipulation of
%the coordinate being used. The slider will use a range between 1 to the
%number of elements in matches. The slider will need an update function
%that changes which cell is filled in. This will be done by editing the
%second scatter object. For the pre plot, this will simply mean moving
%through the data struct to the next element. For the post plot, this will
%involve looking up the appropriate index forom matches and looking up the
%corresponding coordinate from the post cell list.

%Which elemenets will need to be included in the second panel? wE'll need
%the slider for the cell selection which will be for viewing, but wee also
%wanted to asdd expanded functionality. This would include a re-write
%system.What I wantede was for the suer to be able to say that they don#'t
%agree with a match, then provide them an easy way of correcting it. So we
%give them a button. How about this locks the first plot, so selection
%remains with the current pre cell, but then allows you to move through the
%members of the second set. Ideally it would arrange them in terms of
%proximity, but that would be more effort to do - pass index of initial
%guess, find power difference, obtain index from sort, move through index.

f = figure;
setappdata(f,'matches',dataStruct.matches)
b4 = uicontrol(f,'String','Next','Units','normalized','Position',[0.1 0 0.8 0.1]);
b4.Callback = 'b4Callback';
p1 = uipanel(f,'Position',[0.1 0.2 0.8 0.7]);
p2 = uipanel(f,'Position',[0.1 0.1 0.8 0.1]);
ax1 = axes(p1);
subplot(1,2,1,ax1)
ax2 = axes(p1);
subplot(1,2,2,ax2)
hold(ax1,'on')
scatter3(ax1,dataStruct.cellCoordPre(:,1),dataStruct.cellCoordPre(:,2),dataStruct.cellCoordPre(:,3))
scatter3(ax1,dataStruct.cellCoordPre(1,1),dataStruct.cellCoordPre(1,2),dataStruct.cellCoordPre(1,3),'Filled')
hold(ax1,'off')
hold on
scatter3(ax2,dataStruct.cellCoordPost(:,1),dataStruct.cellCoordPost(:,2),dataStruct.cellCoordPost(:,3))
scatter3(ax2,dataStruct.cellCoordPost(dataStruct.matches(1),1),dataStruct.cellCoordPost(dataStruct.matches(1),2),dataStruct.cellCoordPost(dataStruct.matches(1),3),'Filled')
hold off

s1 = uicontrol(p2,'Style','slider','Min',1 ,'Max',size(dataStruct.cellCoordPre,1),'Units','normalized','Position',[0.3 0.1 0.6 0.1],'Value',1,'SliderStep',[1/(size(dataStruct.cellCoordPre,1)-1) 1]);
% s1.Callback = '[ax1.Children(1).XData ax1.Children(1).YData ax1.Children(1).ZData] = deal(dataStruct.cellCoordPre(s1.Value,1),dataStruct.cellCoordPre(s1.Value,2),dataStruct.cellCoordPre(s1.Value,3))';
s1.Callback = 's1Callback';
%ax2.Children(1).XData ax2.Children(1).YData ax2.Children(1).ZData          dataStruct.cellCoordPost(matches(s1.Value),1) dataStruct.cellCoordPost(matches(s1.Value),2) dataStruct.cellCoordPost(matches(s1.Value),3) 
% end

b1 = uicontrol(p2,'Style','push','String','Change?','Units','normalized','Position',[0.1 0.1 0.2 0.2]);
b1.Callback = "s1.Callback = 's1CallbackChange'";
b2 = uicontrol(p2,'Style','push','String','set','Units','normalized','Position',[0.1 0.3 0.2 0.2]);
b2.Callback = "s1.Callback = 's1Callback'";

