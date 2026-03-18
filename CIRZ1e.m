function dir=CIRZ1e(n,pr,pnd)
%pnd perpendicular to radius  +- near 1;//    +-near 0
[ax,ay]=cirz1(n,pr,pnd);dir={ax,ay};

function [ax,ay]=cirz1(n,pr,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;
ra=pr*no;p2=pi/2;pp=pnd*p2;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;r=sqrt(x*x+y*y);
        if r<ra
        [ca,sa]=afun(y,x,pp);
        ax(i,j)=ca;ay(i,j)=sa;
        end
    end
end
ax(no,no)=0;ay(no,no)=0;

function [ca,sa]=afun(y,x,pp)
a=atan2(y,x)+pp;ca=cos(a);sa=sin(a);