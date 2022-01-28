%% This code extracts QSM volumes from TS data

clc;
clear all;

folder = '/Volumes/AswinChari/TS_SWI/TS_Scans';
cd(folder);
addpath ../Code;
addpath /Users/aswinchari/Documents/MATLAB/spm12/;
patients = dir('Sub*');


%% Kernel model (needed later for ROI dilations)

kernel = cat(3,[0 0 0; 0 1 0; 0 0 0],[0 1 0; 1 1 1; 0 1 0],[0 0 0; 0 1 0; 0 0 0]);

%% Extract QSM values for each of those layers

all_tubers = [];

for a=1:length(patients) %%PATIENT BY PATIENT
    
    disp(strcat('Working on:',patients(a).name));
    
    PatFolder = ([folder '/' patients(a).name '/']);
    mkdir([PatFolder 'Matlabspace'])
    savefolder = ([folder '/' patients(a).name '/Matlabspace/']);

    %ADD IMAGING DATA

    qsm = niftiread([folder '/' patients(a).name '/QSM_reg.nii.gz']);
    R2star = niftiread([folder '/' patients(a).name '/R2star_reg.nii.gz']);
    t1 = niftiread([folder '/' patients(a).name '/t1_reg.nii.gz']); 
    flair = niftiread([folder '/' patients(a).name '/flair_reg.nii.gz']); 
    mask = niftiread([folder '/' patients(a).name '/mask_reg.nii.gz']);  

    niftiwrite(t1,[savefolder 't1_in_matlabspace'])
    niftiwrite(flair,[savefolder 'flair_in_matlabspace']);
    niftiwrite(mask,[savefolder 'mask_in_matlabspace']);


    %%%%REMOVE EXTRACRANIAL DATA
    [mlocc(:,1),mlocc(:,2),mlocc(:,3)] = findND(mask==0);
        for mlocc_idx = 1:length(mlocc)
            qsm(mlocc(mlocc_idx,1),mlocc(mlocc_idx,2),mlocc(mlocc_idx,3),:) = NaN;
            R2star(mlocc(mlocc_idx,1),mlocc(mlocc_idx,2),mlocc(mlocc_idx,3),:) = NaN;
        end
    niftiwrite(qsm,[savefolder 'qsm_in_matlabspace'])    
    niftiwrite(R2star,[savefolder 'R2star_in_matlabspace'])
    clear mlocc_idx    

    %%%QSM SIGNAL EXCRATION%%%%
    
    cd(patients(a).name);
    
    tubers = dir('tuber*');
    
    for b=1:length(tubers) %tuber by tuber
        tuber{b} = niftiread(tubers(b).name); %load ROI for each tuber
        disp(strcat('Working on:',tubers(b).name));
        niftiwrite(tuber{b},[savefolder '/' patients(a).name '_tuber' num2str(b) 'roi']); %save a copy of the ROI in matlab space for reference

        [locc(:,1),locc(:,2),locc(:,3)] = findND(tuber{b}==1); %where the tuber is
        for locc_idx = 1:length(locc)
            qsm_tuber(locc_idx,:) = qsm(locc(locc_idx,1),locc(locc_idx,2),locc(locc_idx,3),:);
            R2star_tuber(locc_idx,:) = R2star(locc(locc_idx,1),locc(locc_idx,2),locc(locc_idx,3),:);
        end

        qsm_tuber(qsm_tuber==0)=NaN; % CRITICAL POINT - removes the voxels included in the ROI but not included in the QSM map
        R2star_tuber(R2star_tuber==0)=NaN; % CRITICAL POINT - removes the voxels included in the ROI but not included in the QSM map
        
        patient_tuber(b).patient = patients(a).name;
        patient_tuber(b).tuber = tubers(b).name;
        patient_tuber(b).qsm = qsm_tuber;
        patient_tuber(b).R2star = R2star_tuber;
         
        clear locc_idx locc qsm_tuber R2star_tuber tuber
       
    end
    
    clear mlocc qsm R2star t1 flair mask mlocc_idx
    all_tubers = [all_tubers patient_tuber];
    clear patient_tuber
    
    cd ..
end

clear a b c 

%% Save the output

save('tubersqsm.mat','all_tubers')

