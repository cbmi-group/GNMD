% crop and resize P2P-NM outputs to obtain global noise samples

close all
clear all
clc

img_path = 'edge_random_masks_latest/images/'; % output folder of P2P-NM 
dirs = dir([img_path,'*.png']);
img_name = {dirs.name}';

save_path = 'global_noise/';
if exist(save_path,'dir')==0
    mkdir(save_path)
end
p = 15;

for i=1:length(dirs)/3
    
    noise_1 = rgb2gray(imread([img_path,num2str(i),'_fake_B.png']));
    [height width] = size(noise_1);
      
    noise_2 = noise_1(p:end-p,p:end-p);
    global_noise = imresize(noise_2,[height width]);
    imwrite(global_noise,[save_path,num2str(i),'.png']);
end