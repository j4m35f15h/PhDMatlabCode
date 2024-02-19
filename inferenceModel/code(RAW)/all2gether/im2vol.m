function [object] = im2vol(tiff_stack)
% tiff_info = imfinfo(filename); % return tiff structure, one element per image
% tiff_stack = imread(filename, 1) ; % read in first image
% %concatenate each successive tiff to tiff_stack
% for ii = 2 : size(tiff_info, 1)
%     temp_tiff = imread(filename, ii);
%     tiff_stack = cat(3 , tiff_stack, temp_tiff);
% end
object.xRes = 1;
object.yRes = 1;
object.zRes = 1;
object.vertices = zeros(size(tiff_stack,1)*size(tiff_stack,2)*size(tiff_stack,3)*8,3);
object.faces = zeros(size(tiff_stack,1)*size(tiff_stack,2)*size(tiff_stack,3)*6,4);

% Threshold to remove some of the background noise.
for i = 1:size(tiff_stack,3)
    thresh = tiff_stack(:,:,i);
    [thresh,I] = sort(thresh);
    % thresh(find(thresh<thresh(round(.01*end)))) = 0;
    I = I(find(thresh<1000));
    thresh = thresh(floor(1*end/10));
    tiff_stack(find(tiff_stack<thresh)) = 0;
end
tiff_stack(1,1,1) = 0;
%Read along each puxel in the stack & convert a pixel into the coordinates 
% of a cube. Store these in a vertex array
validPixel = 0;
for k = 1:size(tiff_stack,3)
%     k
    for j = 1:size(tiff_stack,2)
%         j
        for i = 1:size(tiff_stack,1)
            if tiff_stack(i,j,k)
                
%                 object.vertices = [object.vertices;...
%                                     i*object.xRes,j*object.yRes,k*object.zRes;...              %1
%                                     (i-1)*object.xRes,j*object.yRes,k*object.zRes;...          %2
%                                     i*object.xRes,(j-1)*object.yRes,k*object.zRes;...         %3
%                                     i*object.xRes,j*object.yRes,(k-1)*object.zRes;...          %4
%                                     (i-1)*object.xRes,(j-1)*object.yRes,k*object.zRes;...      %5
%                                     (i-1)*object.xRes,j*object.yRes,(k-1)*object.zRes;...      %6
%                                     i*object.xRes,(j-1)*object.yRes,(k-1)*object.zRes;...      %7
%                                     (i-1)*object.xRes,(j-1)*object.yRes,(k-1)*object.zRes;...  %8
%                                     ];
                validPixel = validPixel + 1;
               object.vertices((validPixel-1)*8+1:(validPixel-1)*8+8,:) = [i*object.xRes,j*object.yRes,(k-.4)*object.zRes;...              %1
                                                    (i-1)*object.xRes,j*object.yRes,(k-.4)*object.zRes;...          %2
                                                    i*object.xRes,(j-1)*object.yRes,(k-.4)*object.zRes;...         %3
                                                    i*object.xRes,j*object.yRes,(k-0.6)*object.zRes;...          %4
                                                    (i-1)*object.xRes,(j-1)*object.yRes,(k-.4)*object.zRes;...      %5
                                                    (i-1)*object.xRes,j*object.yRes,(k-0.6)*object.zRes;...      %6
                                                    i*object.xRes,(j-1)*object.yRes,(k-0.6)*object.zRes;...      %7
                                                    (i-1)*object.xRes,(j-1)*object.yRes,(k-0.6)*object.zRes;...  %8
                                                    ];
                                                    
%                object.faces = [object.faces;...
%                                 1,2,5,3;...
%                                 1,4,6,2;...
%                                 1,3,7,4;...
%                                 8,7,3,5;...
%                                 8,5,2,6;...
%                                 8,7,4,6;...
%                                 ];


            end
            
        end
    end
end
for i = 1:validPixel
    object.faces((i-1)*6+1:(i-1)*6+1+5,:) = [1,2,5,3;...
        1,4,6,2;...
        1,3,7,4;...
        8,7,3,5;...
        8,5,2,6;...
        8,7,4,6;] + 8*(i-1);
end


object.vertices = object.vertices(any(object.vertices,2),:);            
object.faces = object.faces(any(object.faces,2),:);
end

