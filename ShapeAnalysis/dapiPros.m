imDat = imread('7RSS4S1I1COMB.tif');
imDat(:,:,[1 2]) = 0;
temp = imDat(:,:,3);
temp(find(temp < 100)) = 0;
temp(find(temp >= 100)) = 255;
imshow(temp)
figure

%Need to create the convolution kernel from the example sets. Create an
%array with the max dimensions of any of the example triplets. Place the
%examples from the temp image into this array, at the centre of the
%sections. Average across all cells. Any elements below a certain value,
%set to -1 rest to 1.

%The first coordinat provides the bottom and left value, the second
%provides right and third provides top.