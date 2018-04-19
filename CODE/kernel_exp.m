function k=kernel_exp(x,y,n,s0)

sigma=n*s0;
%k=exp(-dist2(x',y')/(2*sigma^2));
for i=1:size(x,2),
    for j=1:size(y,2),
        k(i,j)=exp(-(x(:,i)-y(:,j))'*(x(:,i)-y(:,j))/(2*sigma^2));
    end
end
