function [L,V,trainF]=akpca(fa,nk,ITE,llow,rlow)
%fa--training data
%fb--test data
%nk--number of krenels
%ITE--iteration steps
%llow---L reduced dim
%rlow--V reduced dim

%training
m=size(fa,2);
mfa=fa-mean(fa,2)*ones(1,m);
s0=sqrt(trace(mfa'*mfa)/(m-1));
K=zeros(m,nk,m);
for k=1:m,
    for j=1:nk,
        K(:,j,k)=kernel_exp(fa,fa(:,k),j,s0);
    end
end
Km=mean(K,3);
KK=zeros(m,m);
pK=KK+0.1*diag(diag(ones(m)));

% for k=1:nk,
%     KK=KK+kernel_exp(fa,fa,k,s0);
% end

I=diag(diag(ones(nk,nk)));
V=I(:,rlow)
for ite=1:ITE,
    ML=0;
    for i=1:m,
        TL=(K(:,:,i)-Km)*V;
        ML=ML+TL*TL';
    end
%     
    [L,D0]=eigs(ML,llow,'LM');
%     [U0,D0,L0]=svd(pinv(KK)*ML,0);
%     L=L0(:,1:llow);
%     [L,D0]=eigs(pinv(KK)*ML,llow,'LM');

    MV=0;
    for i=1:m,
        TV=L'*(K(:,:,i)-Km);
        MV=MV+TV'*TV;
    end
    [U1,D1,V1]=svd(MV,0);
    V=V1(:,1:rlow);
%     [V,D1]=eigs(MV,rlow,'LM');
end

%testing
% n=size(fb,2);
% Kt=zeros(m,nk,n);
% for k=1:n,
%     for j=1:nk,
%         Kt(:,j,k)=kernel_exp(fa,fb(:,k),j,s0);
%     end
% end
trainF=zeros(llow*rlow,m);
%testF=zeros(llow*rlow,n);
for k=1:m,
    T=L'*(K(:,:,k)-Km)*V;
    trainF(:,k)=T(:);
end
% for k=1:n,
%     T=L'*(Kt(:,:,k)-Km)*V;
%     testF(:,k)=T(:);
% end
