function dir=CPOLYe(ind,n,pr,wd,pnd)
%ind=0;3;4;6 угольник; 0-окружность
%pr - part of radius (0-1)
%wd - wids relative (0-1)
%pnd perpendicular to radius  +- near 1;//    +-near 0
[ax,ay]=CPOLY(ind,n,pr,wd,pnd);dir={ax,ay};

function [ax,ay]=CPOLY(ind,n,pr,wd,pnd)
if ind==0,[ax,ay]=Cir(n,pr,wd,pnd);return;end
if ind==4,[ax,ay]=Qua(n,pr,wd,pnd);return;end% absent
if ind==6,[ax,ay]=Hex(n,pr,wd,pnd);return;end% absent
[ax,ay]=Tri(n,pr,wd,pnd);

function [ax,ay]=Cir(n,pr,wd,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;p2=pi/2;pp=pnd*p2;
pw=pr+wd;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;r=sqrt(x*x+y*y);
[ca,sa]=Rfun(y,x,pr,pw,no,pp);
ax(i,j)=ca;ay(i,j)=sa;
    end
end
ax(no,no)=0;ay(no,no)=0;

function [ca,sa]=Rfun(y,x,pr,pw,no,pp)
a=atan2(y,x)+pp;r=sqrt(x*x+y*y);ro=r/no;ca=0;sa=0;
if ro>pr && ro<pw,ca=cos(a);sa=sin(a);end


function [ax,ay]=Tri(n,pr,wd,pnd)
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
ax=zeros(n,n);ay=ax;p6=pi/6;cp6=cos(p6);sp6=sin(p6);
e1=[cp6,sp6];e2=[-cp6,sp6];e3=[0,-1];
ep1=[-sp6,cp6];ep2=[-sp6,-cp6];ep3=[1,0];
if pnd==0, ep1=e1;ep2=e2;ep3=e3;end
pw=pr+wd;%pw=pr+wd/no;
for i=1:n,y=i-no;
    for j=1:n,x=j-no;v=[x,y];tx=ax(i,j);ty=ay(i,j);
[tx,ty]=ang1(e1,ep1,v,tx,ty,no,pr,pw); ax(i,j)=tx;ay(i,j)=ty;
[tx,ty]=ang2(e2,ep2,v,tx,ty,no,pr,pw); ax(i,j)=tx;ay(i,j)=ty;
[tx,ty]=ang3(e3,ep3,v,tx,ty,no,pr,pw); ax(i,j)=tx;ay(i,j)=ty;
    end
end
ax(no,no)=0;ay(no,no)=0;

function [tx,ty]=ang1(e,ep,v,tx,ty,no,pr,pw)
av=atan2(v(2),v(1));s=sum(e.*v)/no;p6=pi/6;p2=pi/2;
if s>pr && s<=pw && av>-p6 && av<=p2, tx=ep(1);ty=ep(2);end

function [tx,ty]=ang2(e,ep,v,tx,ty,no,pr,pw)
av=atan2(v(2),v(1));s=sum(e.*v)/no;p6=pi/6;p2=pi/2;
if s>pr && s<=pw && av>+p2 && av<=+pi, tx=ep(1);ty=ep(2);end
if s>pr && s<=pw && av>-pi && av<=-pi+p6, tx=ep(1);ty=ep(2);end

function [tx,ty]=ang3(e,ep,v,tx,ty,no,pr,pw)
av=atan2(v(2),v(1));s=sum(e.*v)/no;p6=pi/6;
if s>pr && s<pw && av>-pi+p6 && av<=-p6, tx=ep(1);ty=ep(2);end