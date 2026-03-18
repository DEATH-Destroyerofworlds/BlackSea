function Y=inCOS2(X)
%2D
%X-чет или нечет длины m,n;Y-нечет длины M=m+m-1;N=n+n-1
[m,n]=size(X);M=m+m-1;N=n+n-1;Y=zeros(M,N);
ym=zeros(1,m);xn=zeros(1,n);
for i=1:m,xn(:)=X(i,:);xN=inCOS1(xn);Y(i,:)=xN(:);end
for j=1:N
    for i=1:m,ym(i)=Y(i,j);end
    yM=inCOS1(ym);Y(:,j)=yM(:);
end