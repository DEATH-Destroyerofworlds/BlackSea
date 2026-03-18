function a=CIRZe(n,pnd)
%pnd perpendicular to radius  +- near 1;//    +-near 0
[ax,ay]=cirz(n,pnd);a={ax,ay};

function [ax,ay]=cirz(n,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;pp=pnd*pi/2;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;
       [ca,sa]=afun(y,x,pp);
        ax(i,j)=ca;ay(i,j)=sa;
    end
end
ax(no,no)=0;ay(no,no)=0;

function [ca,sa]=afun(y,x,pp)
a=atan2(y,x)+pp;ca=cos(a);sa=sin(a);