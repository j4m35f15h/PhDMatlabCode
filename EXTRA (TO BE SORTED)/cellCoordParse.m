%Converts the dataStructs the cell coordionates are stored in into an
%indexed list of cells.
CBDyn = [];
CADyn = [];
CBStat = [];
CAStat = [];

for i = 1:size(ModelInputStructDyn,2)
    CBDyn = [CBDyn; ModelInputStructDyn(i).CB];
    CADyn = [CADyn; ModelInputStructDyn(i).CA];
end

for i = 1:size(ModelInputStructStat,2)
    CBStat = [CBStat; ModelInputStructStat(i).CB];
    CAStat = [CAStat; ModelInputStructStat(i).CA];
end