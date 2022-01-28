#!/bin/bash

cd ../TS_Scans/Sub-06

		for elec in tuber*; do 

		reg_resample -flo $elec -ref flair_reg2.nii.gz -aff tubers.txt -res ${elec}_new.nii.gz -NN

		done
