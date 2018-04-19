function [Sn,Sp ,MCC] =JGZD( test_label,predict_label )
tp=zeros(6,1);
tn=zeros(6,1);
fn=zeros(6,1);
fp=zeros(6,1);
for j=1:6
    for i=1:317
        if  test_label(i)==j
            if  predict_label(i)==j
            tp(j)=tp(j)+1;
        else
            fn(j)=fn(j)+1;
        end
        else  if predict_label(i)==j
                fp(j)=fp(j)+1;
            end
    end
end
end
tn(1)=tp(2)+tp(3)+tp(4)+tp(5)+tp(6);
tn(2)=tp(1)+tp(3)+tp(4)+tp(5)+tp(6);
tn(3)=tp(2)+tp(1)+tp(4)+tp(5)+tp(6);
tn(4)=tp(2)+tp(3)+tp(1)+tp(5)+tp(6);
tn(5)=tp(2)+tp(3)+tp(1)+tp(4)+tp(6);
tn(6)=tp(2)+tp(3)+tp(1)+tp(5)+tp(4);
Sn=zeros(6,1);
Sp=zeros(6,1);
MCC=zeros(6,1);
for i=1:6
     Sn(i)=tp(i)/(tp(i)+fn(i));
    Sp(i)=tn(i)/(tn(i)+fp(i));
    MCC(i)=(tp(i)*tn(i)-fp(i)*fn(i))/sqrt((tp(i)+fp(i))*(tp(i)+fn(i))*(tn(i)+fp(i))*(tn(i)+fn(i)));
end
end

