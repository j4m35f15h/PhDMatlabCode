%This script is to go through each of the limbs, load the stl file, load
%the transform variable, add the initial centre of the stl file to the
%tansfrom varialbe and move on to the next.

%Need a list of all the available limbs
    %Can sdo this manually, is there a way to automate?

%for all limbs
%add to path the appropriate folder
%Read the named stl file
%load transformG.mat
%add mean vertices to new value of transform.
%remove file from path
%add next file to path

temp = dir('EndG');

for i = 4:18
    listing1 = temp(i).name;
    addpath(['EndG\',listing1])
    temp2 = dir(['EndG\',listing1]);
    for j = 3:size(temp2,1)
        listing2 = temp2(j).name;
        addpath(['EndG\',listing1,'\',listing2])
        if isfile(['EndG\',listing1,'\',listing2,'\transformG.mat'])
            load transformG.mat
            [object1.vertices, object1.faces] = stlread([listing2,'G.stl']);
            dataStruct.transOrigin = mean(object1.vertices);
            save(['EndG\',listing1,'\',listing2,'\transformG.mat'],'dataStruct')
        end
        rmpath(['EndG\',listing1,'\',listing2])
    end
    rmpath(['EndG\',listing1])
end

% temp = dir('StartG\Dyn');
% 
% for i = 3:14
%     listing1 = temp(i).name;
%     addpath(['StartG\Dyn\',listing1])
%     temp2 = dir(['StartG\Dyn\',listing1]);
%     for j = 3:size(temp2,1)
%         listing2 = temp2(j).name;
%         addpath(['StartG\Dyn\',listing1,'\',listing2])
%         if isfile(['StartG\Dyn\',listing1,'\',listing2,'\transformG.mat'])
%             load transformG.mat
%             [object1.vertices, object1.faces] = stlread([listing2,'G.stl']);
%             dataStruct.transOrigin = mean(object1.vertices);
%             save(['StartG\Dyn\',listing1,'\',listing2,'\transformG.mat'],'dataStruct')
%         end
%         rmpath(['StartG\Dyn\',listing1,'\',listing2])
%     end
%     rmpath(['StartG\Dyn\',listing1])
% end