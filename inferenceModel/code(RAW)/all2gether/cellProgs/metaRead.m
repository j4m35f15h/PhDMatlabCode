filename = '8.4RG.stl';

[object2.vertices, object2.faces] = stlread(filename);
M = csvread('CB.csv',1,1);
% offset = 0;
offset = -1;

offset2 = 0;
% offset2 = 1;

rawMeta = xlsread('preMeta.csv');
stepCountGlobal = rawMeta(11);
stepCountLocal = rawMeta(22);
yResGlobal = rawMeta(200-3+offset2)*10^6;
yResLocal = rawMeta(414-3+offset)*10^6;
stepGlobal = rawMeta(202-3+offset2)*10^6;
stepLocal = rawMeta(416-3+offset)*10^6;
zWideGlobal = rawMeta(203-3+offset2)*10^6;
zWideLocal = rawMeta(417-3+offset)*10^6;

zStartGlobal = zWideGlobal - stepGlobal*stepCountGlobal;
zStartLocal = zWideLocal - stepLocal*stepCountLocal;
zdif = zStartGlobal - zStartLocal;
% zdif = 0;

% yResLocal = 5.0505002339681E-07*10^6;
% yResGlobal = 3.03326810176125E-06*10^6;
% stepLocal = 0.0000162032*10^6;
% stepGlobal = 0.0000258856*10^6;
% zWideLocal = 0.0039507802*10^6;
% zWideGlobal = 0.0039993366*10^6;
% 
% zStartGlobal = zWideGlobal - stepGlobal*stepCountGlobal;
% zStartLocal = zWideLocal - stepLocal*stepCountLocal;
% zdif = zStartGlobal - zStartLocal;