%% This code extracts cavernoma QSM values and plots them
clc;
clear all;

folder = '/Volumes/AswinChari/TS_SWI/TS_Scans';
cd(folder);
addpath ../Code;

%% Load QSM data

load('tubersqsm.mat');

all_tubers = all_tubers({all_tubers.patient} == string('Sub-03'));

%% Plot histogram

edges = [-0.15:0.01:0.15];

subplot(1,3,1)
hold on
for a = [1:3,5,7:13,15:18]
    histogram(all_tubers(a).qsm,edges,'FaceColor','w','Normalization','probability')
end
histogram(all_tubers(4).qsm,edges,'FaceColor','r','Normalization','probability')
xlabel('QSM Value')
ylabel('Normalised Probability')
title('Resected Tuber #1')
set(gca,'FontSize',12)

subplot(1,3,2)
hold on
for a = [1:3,5,7:13,15:18]
    histogram(all_tubers(a).qsm,edges,'FaceColor','w','Normalization','probability')
end
histogram(all_tubers(6).qsm,edges,'FaceColor','r','Normalization','probability')
title('Resected Tuber #2')
xlabel('QSM Value')
ylabel('Normalised Probability')
set(gca,'FontSize',12)

subplot(1,3,3)
hold on
for a = [1:3,5,7:13,15:18]
    histogram(all_tubers(a).qsm,edges,'FaceColor','w','Normalization','probability')
end
histogram(all_tubers(14).qsm,edges,'FaceColor','g','Normalization','probability')
title('Unresected Tuber Predicted by Model')
xlabel('QSM Value')
ylabel('Normalised Probability')
set(gca,'FontSize',12)

sgtitle('QSM Values from Example Tubers')
set(gcf,'position',[0,0,1200,400])

%% 

saveas(gcf,'/Users/aswinchari/Desktop/GOSH/35. TS-SWI/Figure4b.png')
