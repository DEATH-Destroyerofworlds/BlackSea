function [b,pa]=cgraFIe(a,H,DH,pF)
%BW Image, 2D- output, a - скал€р
%a,H,DH;without FDST
A=inCOS2(a);F=FT2(A,{H,H});
n=size(a,2);zF=zerF(F,n,pF);
pA=IFT2(zF,{H,H});pa=ouCOS2(pA);
[Bx,By]=grad2(zF,H,DH);
bx=ouCOS2(Bx);by=ouCOS2(By);
b={bx,by};

function zF=zerF(F,n,pF)
zF=F;
for i=1:n,y=n-i;
    for j=1:n,x=n-j;r=sqrt(x^2+y^2)/n;
if r>=pF,zF(i,j)=0;end   
    end
end
