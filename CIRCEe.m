function dir=CIRCEe(ind,n,pr,sG,pnd)
%ind=1;2;3; множеств
%pr - part of radius (0-1)
%sG - sigma in Gauss - exp(-((r-pr)/(2*sG))^2) in radius lenghts
%pnd perpendicular to radius  +- near 1;//    +-near 0
[ax,ay]=circ1(ind,n,pr,sG,pnd);dir={ax,ay};

function [ax,ay]=circ1(ind,n,pr,sG,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;p2=pi/2;pp=pnd*p2;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;r=sqrt(x*x+y*y);ro=pr-r/no;Er=ro/sG;
        %er=exp(-Er*Er/2);
        %if Er>0; er=1;end
        er=indF(ind,Er);
        [ca,sa]=Efun(y,x,pp);
        ax(i,j)=ca*er;ay(i,j)=sa*er;
        
    end
end
ax(no,no)=0;ay(no,no)=0;

function er=indF(ind,Er)
er=1;%if ind==1 or NO (2 or 3)
if ind==2;er=exp(-Er*Er);if Er>0;er=1;end;end
if ind==3;er=exp(-Er*Er);end

function [ca,sa]=Efun(y,x,pp)
a=atan2(y,x)+pp;ca=cos(a);sa=sin(a);
