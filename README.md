# Blind Denoising of Fluorescence Microscopy Images Using GAN-Based Global Noise Modeling
  This repos provides a denoising method for fluorescence microscopy images based on GAN global noise modeling.
  
  <img src="https://github.com/cbmi-group/BlindDenoising/blob/main/Fig1.png" width="70%">

## Dependencies
  - torch>=1.4.0
  - torchvision>=0.5.0
  - dominate>=2.4.0
  - visdom>=0.1.8.8
  - matlab  
## How to use
### 1. P2P-NM train/test
   - Put source data into folder *P2P-NM/datasets/* (e.g. our dataset named *mask_mito_1080*)
   - To view training results and loss plots, run `python -m visdom.server`
   - Train a model
  
    python train.py --batch_size 1 --model pix2pix --direction BtoA --dataroot ./datasets/ --phase mask_mito_1080 --name trained_on_1080 --niter 500 --niter_decay 500   
   
   More options are list in `options/base_options.py` and `train_options.py`.  
   Model weights will be saved to *P2P-NM/checkpoints/trained_on_1080* 
   - Run `Data_process_matlab/make_random_mask_s1.m` to generate test dataset named *edge_random_masks*
   - Test the model using *edge_random_masks*
     
    python test.py --model pix2pix --direction BtoA --num_test 99999 --dataroot ./datasets/ --phase edge_random_masks --name trained_on_1080
    
   More options are list in `options/base_options.py` and `test_options.py`
   - The test results will be saved to *P2P-NM/results/trained_on_1080/edge_random_masks_latest*
 ### 2. Build data for training P2P-DN
   - Put P2P-NM results *edge_random_masks_latest/* into *Data_process_matlab/* 
   - Run `get_global_noise_s2.m` to output global_noise
   - Prepare 1080 masks
   - Run `make_denoise_training_s3.m` to output dataset *denoise_train_1080/* to train P2P-DN
 ### 3. P2P-DN train/test
   - Put dataset *denoise_train_1080/* into P2P-DN/datasets/
   - Train a model
   
    python train.py --batch_size 1 --model pix2pix --direction BtoA --dataroot ./datasets/ --phase denoise_train_1080 --name trained_on_1080 --niter 100 --niter_decay 100 --gpu_ids 1
   Weights will be saved to* P2P-DN/checkpoints/trained_on_1080*  
   - Test the model using real fluorescence microscopy images
   
    python test.py --model pix2pix --direction BtoA --num_test 99999 --dataroot ./datasets/ --phase mito_real_156 --name trained_on_1080
   - Results will be saved to *P2P-DN/results/trained_on_1080/*
 ## Contributing
   Code for this projects developped at CBMI Group (Computational Biology and Machine Intelligence Group).  
   CBMI at National Laboratory of Pattern Recognition, INSTITUTE OF AUTOMATION, CHINESE ACADEMY OF SCIENCES.  
   Bug reports and pull requests are welcome on GitHub at https://github.com/cbmi-group/BlindDenoising
  
