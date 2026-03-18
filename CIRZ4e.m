function dir=CIRZ4e(n,pr,pnd)
%двойное кольцо (r1,r2)и (r3,r4)
%pnd perpendicular to radius  +- near 1;//    +-near 0
[ax,ay]=cirz4(n,pr,pnd);dir={ax,ay};

function [ax,ay]=cirz4(n,pr,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;pi2=pi/2;
r1=pr(1)*no;r2=pr(2)*no;r3=pr(3)*no;r4=pr(4)*no;
pp1=pnd(1)*pi2;pp2=pnd(2)*pi2;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;r=sqrt(x*x+y*y);
ca=0;sa=0;
        if r<r1 && r>r2; [ca,sa]=afun(y,x,pp1);end
        if r<r3 && r>r4; [ca,sa]=afun(y,x,pp2);end
ax(i,j)=ca;ay(i,j)=sa;    
    end
end
function [ca,sa]=afun(y,x,pp)
a=atan2(y,x)+pp;ca=cos(a);sa=sin(a);