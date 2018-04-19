clear all
clc
lamdashu=10;
%Read the pssm of the protein sequence
WEISHU=317;
for i=1:317
    nnn=num2str(i);
    name = strcat(nnn,'pssm.txt');
    fid{i}=importdata(name);
end
%All protein sequences are normalized
c=cell(WEISHU,1);
for t=1:WEISHU
    clear shu d
shu=fid{t}.data;
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
%PSSM-AAC
for i=1:WEISHU
[MM,NN]=size(c{i});
 for  j=1:20
   x(i,j)=sum(c{i}(:,j))/MM;
 end
end
%PsePSSM 20*lamda
xx=[];
sheta=[];
shetaxin=[];
% lamda=1;
for lamda=1:lamdashu;
for t=1:WEISHU
  [MM,NN]=size(c{t});
  clear xx
   for  j=1:20
      for i=1:MM-lamda
       xx(i,j)=(c{t}(i,j)-c{t}(i+lamda,j))^2;
      end
      sheta(t,j)=sum(xx(1:MM-lamda,j))/(MM-lamda);
   end
end
shetaxin=[shetaxin,sheta];
end
psepssm=[x,shetaxin];
save xin317psepssm10 psepssm 
      