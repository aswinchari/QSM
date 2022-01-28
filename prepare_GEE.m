%% This code extracts cavernoma QSM values and plots them
clc;
clear all;

folder = '/Volumes/AswinChari/TS_SWI/TS_Scans';
cd(folder);
addpath ../Code;

load('tubersqsm.mat');

%% Add data from the tuberdata.csv file

tuberinfo = readtable('TuberData.csv');

for a = 1:length(all_tubers)
    %all_tubers(a).pat = table2array(tuberinfo(a,1));
    %all_tubers(a).tub = table2array(tuberinfo(a,2));
    all_tubers(a).implant = table2array(tuberinfo(a,3));
    all_tubers(a).interictal = table2array(tuberinfo(a,4));
    all_tubers(a).ictal = table2array(tuberinfo(a,5));
    all_tubers(a).resected = table2array(tuberinfo(a,6));
    all_tubers(a).age = table2array(tuberinfo(a,7));
end    

clear tuberinfo a

%% Calculate metrics for each of the tubers (top, middle bottom quartiles + curtosis and skew

for a = 1:length(all_tubers)
    
    all_tubers(a).tubersize = size(all_tubers(a).qsm,1);
    all_tubers(a).qsmdropout = size(all_tubers(a).qsm(~isnan(all_tubers(a).qsm)),1);
    all_tubers(a).qsmdropoutperc = all_tubers(a).qsmdropout/all_tubers(a).tubersize;
    all_tubers(a).medqsm = quantile(all_tubers(a).qsm(~isnan(all_tubers(a).qsm)),0.5);
    all_tubers(a).topqsm = quantile(all_tubers(a).qsm(~isnan(all_tubers(a).qsm)),0.75);
    all_tubers(a).bottomqsm = quantile(all_tubers(a).qsm(~isnan(all_tubers(a).qsm)),0.25);
    all_tubers(a).kurtosisqsm = kurtosis(all_tubers(a).qsm(~isnan(all_tubers(a).qsm)));
    all_tubers(a).skewnessqsm = skewness(all_tubers(a).qsm(~isnan(all_tubers(a).qsm)));
    
    
    R2star = all_tubers(a).R2star(:,1);
    all_tubers(a).R2stardropout = size(R2star(~isnan(R2star)),1);
    all_tubers(a).R2stardropoutperc = all_tubers(a).R2stardropout/all_tubers(a).tubersize;
    all_tubers(a).medR2star = quantile(R2star(~isnan(R2star)),0.5);
    all_tubers(a).topR2star = quantile(R2star(~isnan(R2star)),0.75);
    all_tubers(a).bottomR2star = quantile(R2star(~isnan(R2star)),0.25);
    all_tubers(a).kurtosisR2star = kurtosis(R2star(~isnan(R2star)));
    all_tubers(a).skewnessR2star = skewness(R2star(~isnan(R2star)));
    
    clear R2star;
end

clear a

%% Delete tubers from Sub-09 as degraded by braces artefact

all_tubers(118:138) = [];

%% Save as csv for export

tubertable = struct2table(all_tubers);
tubertable = removevars(tubertable,{'qsm','R2star'});
writetable(tubertable,'tubersforGEE.csv');

%% Save as csv in SPSS folder for model development and testing

modeltable = tubertable([tubertable.implant]==1,:);
testtable = tubertable([tubertable.implant]==0,:);

writetable(modeltable,'/Users/aswinchari/SPSS/tubermodeltable.csv');
writetable(testtable,'/Users/aswinchari/SPSS/tubertesttable.csv');
