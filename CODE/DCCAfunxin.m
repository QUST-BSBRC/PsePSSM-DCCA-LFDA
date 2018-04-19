function pdcca=DCCAfunxin(data,buchang)
S=buchang;
[M,N]=size(data);
%New matrix
for j=1:N   %Row
    for i=1:M      %Column, for each column, row elements accumulated
        DATA(i,j)=sum(data(1:i,j));
    end
end
%The matrix is covered by L-S stackable boxes to generate a (L-S) * 210 matrix
cc=cell(M-S,1); %Build a cell array
for  i=1:M-S  %Make the matrix L-S boxes
    for j=1:20  
        for y=j:20
%Each box is least squares fit
%Extract the least squares data each time
a1=i:i+S;
a=a1';
b=DATA(i:i+S,j);
%Least squares fitting
p=polyfit(a,b,1);
b1=polyval(p,a);
ERCHENG(i:i+S,j)=b1;
c=DATA(i:i+S,y);
p1=polyfit(a,c,1);
c1=polyval(p1,a);
ERCHENG(i:i+S,y)=c1;
    fxy2(j,y)=sum((DATA(i:i+S,j)-ERCHENG(i:i+S,j)).*(DATA(i:i+S,y)-ERCHENG(i:i+S,y)))/(S+1);
         end
    end
     cc{i}=fxy2;
end
%Summation
he=zeros(20,20);
 for y=1:20
for x=y:20
for i=1:M-S
he(y,x)=he(y,x)+cc{i}(y,x);
end
end
end
%PDCCA
PDCCA=zeros(20,20);
for x=1:20
    for y=x:20
        PDCCA(x,y)=he(x,y)/sqrt((he(x,x)*he(y,y)));
    end
end
%Expand
pdcca=[PDCCA(1,2:20),PDCCA(2,3:20),PDCCA(3,4:20),PDCCA(4,5:20),PDCCA(5,6:20),PDCCA(6,7:20),PDCCA(7,8:20),PDCCA(8,9:20),PDCCA(9,10:20),PDCCA(10,11:20),PDCCA(11,12:20),PDCCA(12,13:20),PDCCA(13,14:20),PDCCA(14,15:20),PDCCA(15,16:20),PDCCA(16,17:20),PDCCA(17,18:20),PDCCA(18,19:20),PDCCA(19,20)];