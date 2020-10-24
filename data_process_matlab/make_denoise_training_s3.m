% Make noisy-clean pairs for denoising training.

close all
clear all
clc

load('mito_dist.mat')

mask_path = 'mask_1080/'; 
dirs = dir([mask_path,'*.png']);
mask_name = {dirs.name}';
noise_path = 'global_noise/';
dirs = dir([noise_path,'*.png']);
noise_name = {dirs.name}';

save_path = 'denoise_train_1080/'; % saving data pairs to....
if exist(save_path,'dir')==0
   mkdir(save_path);
end

for i = 1:length(mask_name)
    %% Simulate clean targets based on masks
    % read masks.
    mask = double(imread([mask_path,mask_name{i}]))/255;
    [height,width] = size(mask);
    num = sum(sum(mask));    
    % fill masks by random sampling.
    img1 = zeros(height,width);
    temp = random(pd_gamma,[num,1]);   
    img1(mask==1) = temp;  
    % conduct gaussian filtering.
    sigma = 3 + round(5.*rand(1));
    img2 = imgaussfilt(img1,sigma);
    % normalization
    img2 = (img2-min(img2(:)))/(max(img2(:))-min(img2(:)));
    img = uint8(img2 * 255);
    
    %% Add GAN-Based global noise samples on clean targets
    noise = imread([noise_path,noise_name{i}]);
    noise_rate = randi([70,100],1)/100;
    noisy = noise_rate * noise + img;
    
    img = uint8(img);
    imwrite([img,noisy],[save_path,num2str(i),'.png'])
    
end