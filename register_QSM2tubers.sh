#!/bin/bash

cd ../TS_Output

for sub in Sub-*; do

	reg_aladin -flo $sub/01_mag_firstTE.nii.gz -ref ../TS_Scans/$sub/t1_reg.nii.gz -aff $sub/qsm2t1.txt -res ../TS_Scans/$sub/mag_reg.nii.gz

	reg_resample -flo $sub/04_QSM_iterTik_PDF.nii.gz -ref ../TS_Scans/$sub/t1_reg.nii.gz -aff $sub/qsm2t1.txt -res ../TS_Scans/$sub/QSM_reg.nii.gz -NN

	reg_resample -flo $sub/01_BETmask.nii.gz -ref ../TS_Scans/$sub/t1_reg.nii.gz -aff $sub/qsm2t1.txt -res ../TS_Scans/$sub/mask_reg.nii.gz -NN

	reg_resample -flo $sub/02_R2star_pinv.nii.gz -ref ../TS_Scans/$sub/t1_reg.nii.gz -aff $sub/qsm2t1.txt -res ../TS_Scans/$sub/R2star_reg.nii.gz -NN

done
