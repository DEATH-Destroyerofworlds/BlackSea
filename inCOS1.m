function Y=inCOS1(X)
%X-чет или нечет длины n,Y-нечет длины N=n+n-1
n=size(X,2);N=n+n-1;Y=zeros(1,N);Y(1)=X(1);
for j=2:n,c=X(j);Y(j)=c;Y(N-j+2)=c;end