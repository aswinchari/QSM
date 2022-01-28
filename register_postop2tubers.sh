#!/bin/bash

export ANTSPATH=/opt/ANTs/bin/
export PATH=${ANTSPATH}:$PATH

cd ../TS_PostOp/

for sub in Sub-*; do

	# forward
	
	fslmaths $sub/${sub}_resection.nii.gz -mul -1 -add 1 -bin $sub/resection_inv.nii.gz

	antsRegistrationSyNQuick.sh -d 3 -m ../TS_Scans/$sub/t1_reg.nii.gz -f $sub/${sub}_PostOp_T1.nii.gz -t s -o $sub/output -x $sub/resection_inv.nii.gz

	# inverse

	antsApplyTransforms -d 3 -i $sub/${sub}_PostOp_T1.nii.gz -r ../TS_Scans/$sub/t1_reg.nii.gz -t [$sub/output0GenericAffine.mat, 1] -t $sub/output1InverseWarp.nii.gz -o ../TS_Scans/$sub/postop_reg.nii.gz
	
	antsApplyTransforms -d 3 -i $sub/${sub}_resection.nii.gz -r ../TS_Scans/$sub/t1_reg.nii.gz -t [$sub/output0GenericAffine.mat, 1] -t $sub/output1InverseWarp.nii.gz -o ../TS_Scans/$sub/resection_reg.nii.gz -n NearestNeighbor

done

