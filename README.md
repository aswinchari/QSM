# QSM Mapping in Tuberous Sclerosis

This repository contains processed data and analysis code for the manucript: 

*'Epileptogenic tubers are associated with more homogeneous calcium content: A combined quantitative susceptibility mapping (QSM) and stereoelectroencephalography (SEEG) pilot study' by Chari et al.*

## Data

Individual patient scans and data are not publicly available but the extracted QSM data and tuber classifications are provided in the data files tuberdata.csv and tuberqsm.mat files. 

## Code

The bash scripts allow for co-registration of processed QSM/R2*, SEEG and post-operative scans to the pre-operative MRI scans.

The MATLAB scripts extract QSM/R2* vales from the imaging, prepare the exracted data from each tuber for GEE analysis (which was performed in SPSS) and supsequently use the data for figure generation. 
