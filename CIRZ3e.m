function dir=CIRZ3e(n,pr,pnd)
%pnd perpendicular to radius  +- near 1;//    +-near 0
[ax,ay]=cirz3(n,pr,pnd);dir={ax,ay};

function [ax,ay]=cirz3(n,pr,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;pi2=pi/2;
ra1=pr(1)*no;ra2=pr(2)*no;ra3=pr(3)*no;
pp1=pnd(1)*pi2;pp2=pnd(2)*pi2;pp3=pnd(3)*pi2;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;r=sqrt(x*x+y*y);
        if r<ra1
         [ca,sa]=afun(y,x,pp1);ax(i,j)=ca;ay(i,j)=sa;
if r<ra2,[ca,sa]=afun(y,x,pp2);ax(i,j)=ca;ay(i,j)=sa;
        if r<ra3,[ca,sa]=afun(y,x,pp3);ax(i,j)=ca;ay(i,j)=sa;end 
end       
        end
    end
end
ax(no,no)=0;ay(no,no)=0;

function [ca,sa]=afun(y,x,pp)
a=atan2(y,x)+pp;ca=cos(a);sa=sin(a);

