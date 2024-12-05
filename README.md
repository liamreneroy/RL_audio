# RL Audio
Codebase for audio communication reinforcement learning (RL) bandit algorithm. This repository enables a virtual robot to learn to communicate different functional robot states using parameterized audio.

### Link to Research Paper
IEEE Explore: https://ieeexplore.ieee.org/document/10487862

ARXIV: https://arxiv.org/abs/2404.19253
 

## Main Files
This method was deployed and tested in a user study. This study took the form of a Jupyter notebook. We provide the original interactive survey (Jupyter Notebook) with added step-by-step markdown comments describing the study procedure to enable reproducibility. 

### The Jupyter notebook used for our study is here:
https://github.com/liamreneroy/RL_audio/blob/main/notebooks/study_notebook.ipynb

### The sound libraries used for each robot are here:
https://github.com/liamreneroy/RL_audio/tree/main/notebooks/audio

### The arrays and images for Informed Initializations are here:
https://github.com/liamreneroy/RL_audio/tree/main/notebooks/arrays

### The statistical analyses for our three hypotheses (H1, H2, H3) are here:
https://github.com/liamreneroy/RL_audio/blob/main/stats/

### All the raw data collected throughout our study is here:
https://github.com/liamreneroy/RL_audio/blob/main/notebooks/user_data/response_book.xlsx



## Packages to Install:
pygame   (see this webpage ~ https://www.pygame.org/wiki/GettingStarted)  
jupyterlab, numpy, termcolor, openpyxl, nbconvert-webpdf  

Either use:    
>> sudo apt-get install <package_name>  
>> python3 -m pip install <package_name>  
>> conda install -c conda-forge <package_name>  

Example using conda:  
>> conda install -c conda-forge <package_name>  

* jupyterlab or notebook  
* numpy  
* termcolor  
* openpyxl  
* nbconvert-webpdf              



## Owner: 
Liam Rene Roy
Liamreneroy@gmail.com