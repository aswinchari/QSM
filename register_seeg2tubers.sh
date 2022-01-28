#!/bin/bash

cd ../TS_Electrodes

for sub in Sub-*; do

	reg_aladin -flo $sub/t1_reg.nii.gz -ref ../TS_Scans/$sub/t1_reg.nii.gz -aff $sub/seeg2tubers.txt -res ../TS_Scans/$sub/seegT1_reg.nii.gz

	reg_resample -flo $sub/seegsubthresh.nii.gz -ref ../TS_Scans/$sub/t1_reg.nii.gz -aff $sub/seeg2tubers.txt -res ../TS_Scans/$sub/seegCT_reg.nii.gz -NN

	cd $sub/ElectrodesTransformed_images

	for elec in *dilated.nii.gz; do 

		reg_resample -flo $elec -ref ../../../TS_Scans/$sub/t1_reg.nii.gz -aff ../seeg2tubers.txt -res ../../../TS_Scans/$sub/${elec} -NN

		done

	cd ../..

done
