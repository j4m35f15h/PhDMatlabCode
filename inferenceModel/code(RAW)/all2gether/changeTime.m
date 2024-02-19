ax

hold on
temp = im2vol(dataStruct.gImagePost);
temp.vertices(:,1) = temp.vertices(:,1)*dataStruct.xResP;
temp.vertices(:,2) = temp.vertices(:,2)*dataStruct.yResP;
temp.vertices(:,3) = temp.vertices(:,3)*dataStruct.zResP;
patch('Faces',temp.faces,'Vertices',temp.vertices,'FaceColor','red','LineStyle','none')
patch('Faces',object1.faces,'Vertices',object1.vertices,'FaceColor','red','LineStyle','none')
hold off
post = 1;