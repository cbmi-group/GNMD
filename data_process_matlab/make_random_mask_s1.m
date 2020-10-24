% random nearly all-blcak masks
% Generate inputs of P2P-NM to output generated global noise samples.

% close all
clear all
clc

mm = 1080; % the number of random masks
save_path = 'edge_random_masks/'; % saving to ...
if exist(save_path,'dir')==0
    mkdir(save_path)
end

for i=1:mm
    k = 5;
    result = random_mask(k);
%     figure;imshow(result);
    imwrite([result,result],[save_path,num2str(i),'.png'])
end

function mask = random_mask (k)
    height = 256;
    width = 256;
    mask = zeros(height,width);
    x1 = k;
    x2 = k;
    x3 = k;
    x4 = k;
    for j = 1:height
        x1 = change_edg(x1,k);
        mask(j,1:x1) = 255;
        x2 = change_edg(x2,k);
        mask(j,end-x2:end) = 255;
        x3 = change_edg(x3,k);
        mask(1:x3,j) = 255;
        x4 = change_edg(x4,k);
        mask(end-x4:end,j) = 255;
        mask = uint8(mask);
    end
    
end

function re = change_edg(x,k)
    x = x + randi([-1,1],1); % x is integer between -1 and 1
%     x = x + round(rand(1)*2)-1;   
    if x >= k
        x = k;
    elseif x <= 1
        x = 1;
    end
    re = x;
end

