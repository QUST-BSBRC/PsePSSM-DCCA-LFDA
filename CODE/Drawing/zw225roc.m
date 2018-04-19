clear all
load xin225psepssm3
load('zw40dcca.mat')
X=[psepssm dcca40];
b=[70,89,25,41];
label=[ones(b(1),1);2*ones(b(2),1);3*ones(b(3),1);4*ones(b(4),1)];
%LFDA
[T,Z]=LFDA(X',label,10,'orthonormalized',7);
yuanshuSHU=T'*X';
yuanshu=yuanshuSHU';
shu=zscore(yuanshu);
for i=2:224
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
model=svmtrain(label(2:225),shu(2:225,:),'-t 2 -b 1');
[predict_label(1),accuracy,dec(1,:)]=svmpredict( label(1),shu(1,:),model,'-b 1');
model=svmtrain(label(1:224),shu(1:224,:),'-t 2 -b 1');
[predict_label(225),accuracy,dec(225,:)]=svmpredict( label(225),shu(225,:),model,'-b 1');
ACC=sum(label==predict_label')/225
ZONG=sum(label==predict_label')
for i=1:length(label)
    switch label(i)
        case 1
            tar_label(i,:)=[1,0,0,0];
        case 2
            tar_label(i,:)=[0,1,0,0];
        case 3
            tar_label(i,:)=[0,0,1,0];
        case 4
            tar_label(i,:)=[0,0,0,1];
        
    end
end
[tpr,fpr,thresholds] =roc(tar_label',dec');
sum1=fpr{1}+fpr{2}+fpr{3}+fpr{4};
false=sum1/4;
sum2=tpr{1}+tpr{2}+tpr{3}+tpr{4};
positive=sum2/4;
x4=false;
y4=positive;
% plot(x1,y1);

save xin225lfda.mat x4 y4
