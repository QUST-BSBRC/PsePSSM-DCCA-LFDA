clear all   
clc
load xin317psepssm3
load('dcca40.mat')
X=[psepssm dcca40];
b=[112,47,55,34,52,17];
label=[ones(b(1),1);2*ones(b(2),1);3*ones(b(3),1);4*ones(b(4),1);5*ones(b(5),1);6*ones(b(6),1)];
%LFDA
[T,Z]=LFDA(X',label,10,'orthonormalized',7);
yuanshuSHU=T'*X';
yuanshu=yuanshuSHU';
shu=zscore(yuanshu);
b=[112,47,55,34,52,17];
label=[ones(b(1),1);2*ones(b(2),1);3*ones(b(3),1);4*ones(b(4),1);5*ones(b(5),1);6*ones(b(6),1)];
for i=2:316
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
a=shu(1:i-1,:);
b=shu(i+1:end,:);
train_shu=[a;b];
c=label(1:i-1,:);
d=label(i+1:end,:);
train_label=[c;d];
model=svmtrain(train_label,train_shu,'-t 2 -b 1 ');
% model=svmtrain(train_label,train_shu,'-s 0');
[predict_label(i),accuracy,dec(i,:)]=svmpredict( test_label(i),test_shu(i,:),model,'-b 1');
end
model=svmtrain(label(2:317),shu(2:317,:),'-t 2 -b 1 ');
[predict_label(1),accuracy,dec(1,:)]=svmpredict( label(1),shu(1,:),model,'-b 1');
model=svmtrain(label(1:316),shu(1:316,:),'-t 2 -b 1 ');
[predict_label(317),accuracy,dec(317,:)]=svmpredict( label(317),shu(317,:),model,'-b 1');
ACC=sum(label==predict_label')/317
ZONG=sum(label==predict_label')
for i=1:length(label)
    switch label(i)
        case 1
            tar_label(i,:)=[1,0,0,0,0,0];
        case 2
            tar_label(i,:)=[0,1,0,0,0,0];
        case 3
            tar_label(i,:)=[0,0,1,0,0,0];
        case 4
            tar_label(i,:)=[0,0,0,1,0,0];
        case 5
            tar_label(i,:)=[0,0,0,0,1,0];
        case 6
            tar_label(i,:)=[0,0,0,0,0,1];

    end
end
[tpr,fpr,thresholds] =roc(tar_label',dec');
sum1=fpr{1}+fpr{2}+fpr{3}+fpr{4}+fpr{5}+fpr{6};
false=sum1/6;
sum2=tpr{1}+tpr{2}+tpr{3}+tpr{4}+tpr{5}+tpr{6};
positive=sum2/6;
x4=false;
y4=positive;

save xin317LFDA.mat x4 y4
