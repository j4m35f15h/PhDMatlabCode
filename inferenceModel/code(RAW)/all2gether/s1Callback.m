s1.Max = size(dataStruct.cellCoordPre,1);
[ax1.Children(1).XData ax1.Children(1).YData ax1.Children(1).ZData] = deal(dataStruct.cellCoordPre(s1.Value,1),dataStruct.cellCoordPre(s1.Value,2),dataStruct.cellCoordPre(s1.Value,3));
matchesTemp = getappdata(f,'matches');
[ax2.Children(1).XData ax2.Children(1).YData ax2.Children(1).ZData] = deal(dataStruct.cellCoordPost(matchesTemp(s1.Value),1),dataStruct.cellCoordPost(matchesTemp(s1.Value),2),dataStruct.cellCoordPost(matchesTemp(s1.Value),3));
matchInd = s1.Value;