clear all
clc
load('317psepssm.mat')
load('xin317LFDA.mat')
load('317he.mat')
load('317dcca.mat')
% load('225psepssm.mat')
% load('xin225lfda.mat')
% load('225he.mat')
% load('225dcca.mat')
%auc
x1=x1';
y1=y1';
x2=x2';
y2=y2';
x3=x3';
y3=y3';
y4=y4';
x4=x4';
auc1= sum((x1(2:length(x1),1)-x1(1:length(x1)-1,1)).*y1(2:length(y1),1))
auc2= sum((x2(2:length(x2),1)-x2(1:length(x2)-1,1)).*y2(2:length(y2),1))
auc3= sum((x3(2:length(x3),1)-x3(1:length(x3)-1,1)).*y3(2:length(y3),1))
auc4= sum((x4(2:length(x4),1)-x4(1:length(x4)-1,1)).*y4(2:length(y4),1))
 plot(x1,y1,x2,y2,x3,y3,x4,y4);
 %auc = sum((stack_x(2:length(roc_y),1)-stack_x(1:length(roc_y)-1,1)).*stack_y(2:length(roc_y),1))
 %Comment the above lines if using perfcurve of statistics toolbox
  %[stack_x,stack_y,thre,auc]=perfcurve(label_y,deci,1);
	%plot(stack_x,stack_y);
	xlabel('False positive rate');
	ylabel('True positive rate');
% legend('PseACC  AUC= 0.882','PsePSSM AUC=0.939','PseACC-PsePSSM AUC=0.934','WD-PseACC-PsePSSM AUC= 0.981');
%legend('PseACC  AUC= 0.936','PsePSSM AUC=0.954','PseACC-PsePSSM AUC=0.953','WD-PseACC-PsePSSM AUC= 0.984');
legend('PsePSSM','DCCA','PsePSSM-DCCA','PsePSSM-DCCA-LFDA');
	%title(['ROC curve of (AUC = ' num2str(auc) ' )']);