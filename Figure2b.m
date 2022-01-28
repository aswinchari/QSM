%% This code extracts cavernoma QSM values and plots them
clc;
clear all;

folder = '/Volumes/AswinChari/TS_SWI/TS_Scans';
cd(folder);
addpath ../Code;

%% Load outputfiles

modeltable = readtable('/Users/aswinchari/SPSS/tubermodeltable_output.csv');
testtable = readtable('/Users/aswinchari/SPSS/tubertesttable_output.csv');

all_tubers_results = [modeltable; testtable];
all_tubers_results = sortrows(all_tubers_results,2);
all_tubers_results = sortrows(all_tubers_results,1);

load('tubersqsm.mat');
all_tubers(118:138) = []; %Delete subject 9s tubers

%% Use this code to make specificity and sensitivity (interictal)

i.intertp = (modeltable(and([modeltable.interictal]==1,[modeltable.PredictedValue_Interictal]==1),:));
i.interfp = (modeltable(and([modeltable.interictal]==0,[modeltable.PredictedValue_Interictal]==1),:));
i.interfn = (modeltable(and([modeltable.interictal]==1,[modeltable.PredictedValue_Interictal]==0),:));
i.intertn = (modeltable(and([modeltable.interictal]==0,[modeltable.PredictedValue_Interictal]==0),:));

i.icttp = (modeltable(and([modeltable.ictal]==1,[modeltable.PredictedValue_Ictal]==1),:));
i.ictfp = (modeltable(and([modeltable.ictal]==0,[modeltable.PredictedValue_Ictal]==1),:));
i.ictfn = (modeltable(and([modeltable.ictal]==1,[modeltable.PredictedValue_Ictal]==0),:));
i.icttn = (modeltable(and([modeltable.ictal]==0,[modeltable.PredictedValue_Ictal]==0),:));

%% plot kurtosis values across tubers - ictal

cols = cbrewer('qual','Dark2',6);
cols = cols(3:6,:);

ictal = all_tubers_results(and([all_tubers_results.ictal]==1,[all_tubers_results.implant]==1),:);
extraictal = all_tubers_results(and([all_tubers_results.PredictedValue_Ictal]==1,[all_tubers_results.implant]==0),:);
nonictal = all_tubers_results(and([all_tubers_results.ictal]==0,[all_tubers_results.implant]==1),:);
extranonictal = all_tubers_results(and([all_tubers_results.PredictedValue_Ictal]==0,[all_tubers_results.implant]==0),:);

ictalqsm{1} = vertcat(ictal.kurtosisqsm);
ictalqsm{2} = vertcat(nonictal.kurtosisqsm);
ictalqsm{3} = vertcat(extraictal.kurtosisqsm);
ictalqsm{4} = vertcat(extranonictal.kurtosisqsm);

labels1 = {'Ictal Tubers', 'Non-Ictal Tubers','Predicted Ictal Tubers','Predicted Non-Ictal Tubers'};

subplot(1,2,1)
hold on
violin(ictalqsm,'mc',[],'medc',[],'facecolor',cols,'facealpha',0.6);
scatter(ones(length(ictalqsm{1}),1),ictalqsm{1},[],cols(1,:),'filled')
scatter(ones(length(ictalqsm{2}),1).*2,ictalqsm{2},[],cols(2,:),'filled')
scatter(ones(length(ictalqsm{3}),1).*3,ictalqsm{3},[],cols(3,:),'filled')
scatter(ones(length(ictalqsm{4}),1).*4,ictalqsm{4},[],cols(4,:),'filled')
ylim([0 14])
xlim([0.5 4.5])
xticks([1 2 3 4])
xticklabels(labels1);
xtickangle(60)
ylabel('Kurtosis of QSM histogram')
title('Ictal & Non-Ictal Tubers')
set(gca,'FontSize',12);

%% plot kurtosis values across tubers - interictal

interictal = all_tubers_results(and([all_tubers_results.interictal]==1,[all_tubers_results.implant]==1),:);
extrainterictal = all_tubers_results(and([all_tubers_results.PredictedValue_Interictal]==1,[all_tubers_results.implant]==0),:);
noninterictal = all_tubers_results(and([all_tubers_results.interictal]==0,[all_tubers_results.implant]==1),:);
extranoninterictal = all_tubers_results(and([all_tubers_results.PredictedValue_Interictal]==0,[all_tubers_results.implant]==0),:);

interictalqsm{1} = vertcat(interictal.kurtosisqsm);
interictalqsm{2} = vertcat(noninterictal.kurtosisqsm);
interictalqsm{3} = vertcat(extrainterictal.kurtosisqsm);
interictalqsm{4} = vertcat(extranoninterictal.kurtosisqsm);

labels2 = {'Interictal Tubers', 'Non-Interictal Tubers','Predicted Interictal Tubers','Predicted Non-Interictal Tubers'};

subplot(1,2,2)
hold on
violin(interictalqsm,'mc',[],'medc',[],'facecolor',cols,'facealpha',0.6);
scatter(ones(length(interictalqsm{1}),1),interictalqsm{1},[],cols(1,:),'filled')
scatter(ones(length(interictalqsm{2}),1).*2,interictalqsm{2},[],cols(2,:),'filled')
scatter(ones(length(interictalqsm{3}),1).*3,interictalqsm{3},[],cols(3,:),'filled')
scatter(ones(length(interictalqsm{4}),1).*4,interictalqsm{4},[],cols(4,:),'filled')
ylim([0 14])
xlim([0.5 4.5])
xticks([1 2 3 4])
xticklabels(labels2);
xtickangle(60)
ylabel('Kurtosis of QSM histogram')
title('Interictal & Non-Interictal Tubers')
set(gca,'FontSize',12);

set(gcf,'position',[0,0,1000,600])
sgtitle('Kurtosis of QSM Histograms')

%% Save

saveas(gcf,'/Users/aswinchari/Desktop/GOSH/35. TS-SWI/Figure2b.png')

