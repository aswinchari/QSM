%% Figure 1b

clc;
clear all;

folder = '/Volumes/AswinChari/TS_SWI/TS_Scans';
cd(folder);
addpath ../Code;

%% Load outputfiles

load('tubersqsm.mat');

%% Plot histograms

cols = cbrewer('qual','Dark2',3);

subplot(1,2,1)
histogram(all_tubers(114).qsm,30,'EdgeColor','none','FaceColor',cols(1,:),'FaceAlpha',1)
title('QSM values')
xlabel('QSM signal intensity','Color','w')
ylabel('Number of voxels','Color','w')
set(gca,'Color','k');
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'FontSize',12)

subplot(1,2,2)
histogram(all_tubers(114).R2star(:,1),30,'EdgeColor','none','FaceColor',cols(2,:),'FaceAlpha',1)
title('R2* values')
xlabel('R2* signal intensity','Color','w')
ylabel('Number of voxels','Color','w')
set(gca,'Color','k');
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'FontSize',12)

set(gcf, 'InvertHardCopy', 'off'); 
set(gcf,'Color',[0 0 0]);
sgtitle('Histogram of QSM and R2* signal from single tuber','Color','w');
set(gcf,'position',[0,0,1200,400])

%% Save

saveas(gcf,'/Users/aswinchari/Desktop/GOSH/35. TS-SWI/Figure1b.png')
