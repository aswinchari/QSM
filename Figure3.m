%% This code extracts cavernoma QSM values and plots them
clc;
clear all;

folder = '/Volumes/AswinChari/TS_SWI/TS_Scans';
cd(folder);
addpath ../Code;

%% Get data for unresected predicted ictal and interictal tubers

modeltable = readtable('/Users/aswinchari/SPSS/tubermodeltable_output.csv');
testtable = readtable('/Users/aswinchari/SPSS/tubertesttable_output.csv');

all_tubers_results = [modeltable; testtable];
all_tubers_results = sortrows(all_tubers_results,2);
all_tubers_results = sortrows(all_tubers_results,1);

ict = all_tubers_results(and([all_tubers_results.resected]==0,[all_tubers_results.PredictedValue_Ictal]==1),:);
interict = all_tubers_results(and([all_tubers_results.resected]==0,[all_tubers_results.PredictedValue_Interictal]==1),:);


%% Add data of total ictal and interictal predicted unresected tubers per patient

% manually count from ict and interict above to get 

cols = cbrewer('qual','Dark2',8);

outcome = [1,1,4;3,1,2;3,2,3;4,3,6;2,1,3;2,1,5;4,3,7;2,1,3;3,0,2;1,2,7];

% Linear models
ictal = fitlm(outcome(:,1),outcome(:,2));
interictal = fitlm(outcome(:,1),outcome(:,3));
[ictalp,ictalf] = coefTest(ictal);
[interictalp,interictalf] = coefTest(interictal);

scatter(outcome(:,1),outcome(:,2),80,cols(3,:),'filled');
hold on
scatter(outcome(:,1),outcome(:,3),80,cols(6,:),'filled');
a = plot(ictal);
b = plot(interictal);
for c=1:4
    a(c).Color = cols(3,:)
    b(c).Color = cols(6,:)
end

a(2).LineWidth = 6;
b(2).LineWidth = 6;
a(3).LineWidth = 3;
b(3).LineWidth = 3;
a(4).LineWidth = 3;
b(4).LineWidth = 3;
legend({'Ictal Model','Interictal Model'})
xlabel('Engel Outcome')
ylabel('Number of Predicted Ictal/Interictal Unresected Tubers')
title('Association Between Outcome and Predicted Ictal/Interictal Unresected Tubers')
set(gca,'FontSize',20)
xlim([0.5 4.5])
xticks([1:4])

set(gcf,'position',[0,0,1200,600])

%% Save

saveas(gcf,'/Users/aswinchari/Desktop/GOSH/35. TS-SWI/Figure3.png')
