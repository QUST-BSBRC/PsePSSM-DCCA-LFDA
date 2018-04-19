clear all
clc
load xin317psepssm3
load('10cl317dcca.mat')
X=[psepssm dcca];
b=[112,47,55,34,52,17];
label=[ones(b(1),1);2*ones(b(2),1);3*ones(b(3),1);4*ones(b(4),1);5*ones(b(5),1);6*ones(b(6),1)];
shu=zscore(X);
for i=2:316
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
a=shu(1:i-1,:);
b=shu(i+1:end,:);
train_shu=[a;b];
c=label(1:i-1,:);
d=label(i+1:end,:);
train_label=[c;d];
model=svmtrain(train_label,train_shu,'-t 2');
[predict_label(i),accuracy]=svmpredict( test_label(i),test_shu(i,:),model);
end
%%SVM
model=svmtrain(label(2:317),shu(2:317,:),'-t 2');
[predict_label(1),accuracy]=svmpredict( label(1),shu(1,:),model);
model=svmtrain(label(1:316),shu(1:316,:),'-t 2');
[predict_label(317),accuracy]=svmpredict( label(317),shu(317,:),model);
 ACC=100*sum(label==predict_label')/317
 [Sn,Sp,MCC]=JGCL(label,predict_label);
jieguo=100.*Sn;
zuizhongjieguo=[jieguo;ACC]

