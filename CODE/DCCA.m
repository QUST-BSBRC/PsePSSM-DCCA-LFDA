clear all
clc
%%% load data
load('clxulie.mat')
%All protein sequences are normalized
c=cell(317,1);
for t=1:317
shu=fidcl{t}.data;
%Know the number of each protein, extract the matrix, and pay attention to the order of the proteins
% shuju=shu(1:i,1:20);
[M,N]=size(shu);
shuju=shu(1:M-5,1:20);
d=[];
for i=1:M-5
   for j=1:20
       d(i,j)=1/(1+exp(-shuju(i,j)));
   end
end
c{t}=d(:,:);
end
dcca=zeros(317,190);
for i=1:317
 dcca(i,:)=DCCAfunxin(c{i},5);
end 
%dcca(1,:)=DCCAfunxin(c{1},4);
save 5cl317dcca.mat dcca