
s1.Max = size(dataStruct.cellCoordPost,1);
matchesTemp = getappdata(f,'matches');
[ax2.Children(1).XData ax2.Children(1).YData ax2.Children(1).ZData] = deal(dataStruct.cellCoordPost(matchesTemp(s1.Value),1),dataStruct.cellCoordPost(matchesTemp(s1.Value),2),dataStruct.cellCoordPost(matchesTemp(s1.Value),3));
matchesTemp(matchInd) = s1.Value;
setappdata(f,'matches',matchesTemp)