clear all
clc
%% load data
load xin317psepssm3
load('10cl317dcca.mat')
% Fusion
X=[psepssm dcca];
b=[112,47,55,34,52,17];
label=[ones(b(1),1);2*ones(b(2),1);3*ones(b(3),1);4*ones(b(4),1);5*ones(b(5),1);6*ones(b(6),1)];
%Dimensionality reduction
[T,Z]=LFDA(X',label,10);
yuanshuSHU=T'*X';
yuanshu=yuanshuSHU';
%Jackknife test
shu=zscore(yuanshu);
for i=2:316
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
a=shu(1:i-1,:);
b=shu(i+1:end,:);
train_shu=[a;b];
c=label(1:i-1,:);
d=label(i+1:end,:);
train_label=[c;d];
%SVM
 model=svmtrain(train_label,train_shu,'-t 2 ');
 [predict_label(i),accuracy]=svmpredict( test_label(i),test_shu(i,:),model);
%knn
 %predict_label(i)=knnclassify(shu(i,:),train_shu,train_label,5,'euclidean');
%DT
%  tree=fitctree(train_shu,train_label);
%  predict_label(i)=predict(tree,shu(i,:));
% RF
%  Factor = TreeBagger( 100,train_shu,train_label);
%  [predict_label(i),Scores] = predict(Factor, shu(i,:));
%Naive Bayes£©
%  Factor = NaiveBayes.fit(train_shu,train_label);
% [Scores,predict_label(i)] = posterior(Factor, shu(i,:));
end
%%SVM
% model=svmtrain(label(2:317),shu(2:317,:),'-t 2');
% [predict_label(1),accuracy]=svmpredict( label(1),shu(1,:),model);
% model=svmtrain(label(1:316),shu(1:316,:),'-t 2');
% [predict_label(317),accuracy]=svmpredict( label(317),shu(317,:),model);
% %knn
  predict_label(1)=knnclassify(shu(1,:),shu(2:317,:),label(2:317,:),5,'euclidean');
 predict_label(317)=knnclassify(shu(317,:),shu(1:316,:),label(1:316,:),5,'euclidean');
%DT
%  tree=fitctree(shu(2:317,:),label(2:317,:));
%   [predict_label(1)]=predict(tree,shu(1,:));
%   tree=fitctree(shu(1:316,:),label(1:316,:));
%   [predict_label(317)]=predict(tree,shu(317,:));
  %RF
%   Factor = TreeBagger( 100,shu(2:317,:),label(2:317,:));
% [predict_label(1),Scores] = predict(Factor, shu(1,:));
% Factor = TreeBagger( 100,shu(1:316,:),label(1:316,:));
% [predict_label(317),Scores] = predict(Factor, shu(317,:));
%  for i=1:317
% jieguo(i)=str2num(predict_label{i});
%  end
%  ACC=sum(label==jieguo')/317
%  [Sn,Sp,MCC]=JGCL(label,jieguo);
%  JIEGUO=[Sn;ACC];
 %output=[mean(Sn),mean(Sp),mean(MCC),ACC]
%Naive Bayes
% Factor = NaiveBayes.fit(shu(2:317,:),label(2:317,:));
% [Scores,predict_label(1)] = posterior(Factor, shu(1,:));
% Factor = NaiveBayes.fit(shu(1:316,:),label(1:316,:));
% [Scores,predict_label(317)] = posterior(Factor, shu(317,:));
 ACC=sum(label==predict_label')/317
 ZONG=sum(label==predict_label')
 [Sn,Sp,MCC]=JGCL(label,predict_label);
% % %pssmjieguo=[Sn;ACC;ZONG];
 te=Sn';
 jieguo=[te,ACC]
%output=[mean(Sn),mean(Sp),mean(MCC),ACC]
% aaaaaa=100.*[Sn;ACC]
