function m_eyeGoG2
[ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3;clr=gray;

uicontrol(gcf,'Style','text','BackgroundColor',[0.0 0.7 0.0],'Position',[20 10 400 200],...
    'FontName','Times New Roman','FontSize',30,...
    'String',{'grad B', 'for Eye of GG2'});drawnow;

TabAll=1;%0;1
S_P=0;%0;1;
LW=2;
TiDi=2;

im0='ZGRo_.bmp';%ZGRo_;ZGLo_;%*****************
Pc=imread(im0,'bmp');[r,g,b]=RGBf(Pc);%Prgb={r,g,b};TC=PTC(r,g,b);Fimage('Input - a',TC,TiDi);
a=g;%for   r;g;b;
FimP('a',a,TiDi);

im1='ZGR_.bmp';%%ZGR_;ZGL_;ZN_:%*******************
Pc=imread(im1,'bmp');[R,G,B]=RGBf(Pc);%Prgb={R,G,B};TC=PTC(R,G,B);Fimage('Input - A',TC,TiDi);
A=G; %for   R;G;B;
FimP('A',A,TiDi);

n=size(a,2)
L=size(A,2)
size(A)
%return
if mod(L,2)==0, Lo=L/2+1;else Lo=(L-1)/2+1; end;Lo
if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;n0
[H,DH]=BaFuHa(L);
ind=0;%1;2;3;
pr=0.80;%0.7;0.3;
sG=0.35;%0.1;0.2;

wd=0.45;pr=0.30;pnd=0;%0.15;0.55;%R %*****************
%wd=0.75;pr=0.05;pnd=0;%0;1;%L%*****************
%wd=0.75;pr=0.05;pnd=0;%0;1;%N%*****************



pF=0.75;%0.3;0.6;1.2;%ќставл€ем Ќ„ и pF =0.55 и выше обнул€ем
%Dir=CIRZe(n,1.0);          Fig('1век кас.к.окр');Dir=updn2e(Dir);QUIVERe(Dir);
%Dir=CIRZ1e(n,0.9,0.0);          Fig('1век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%Dir=CIRZ2e(n,[0.8,0.3],[0,-1]);   Fig('2век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%Dir=CIRZ3e(n,[0.8,0.5,0.4],[0.8,0.3,-0.8]);Fig('3век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%diC=CIRCEe(ind,n,pr,sG,-1.0);    Fig('diC');udiC=updn2e(diC);QUIVERe(udiC);
diP=CPOLYe(ind,n,pr,wd,pnd); Fig('diP');udiP=updn2e(diP);QUIVERe(udiP);
%return

%G=cgradIe(A,H,DH);%for pnd=1;
[G,pA]=cgraFIe(A,H,DH,pF);TiDi=1;FimP('pA',pA,TiDi);drawnow;%for pnd=1;
%return
%G=ORTGe(G);Fig('oG');uG=updn2e(G);QUIVERe(uG);% for pnd=0;
aG=absV2e(G);TiDi=1;FimP('abs(Grad)',aG,TiDi);
Fig('G');uG=updn2e(G);QUIVERe(uG);

I0=Lo-7;    %R=[-7;0]%L=[-15;0]%N=[+4;+10];[Lo,Lo]-центр квадрата
J0=Lo+0;   % центр области сканировани€   [I0,J0]

g=ouPCTe(G,I0,J0,n);
ag=absV2e(g);TiDi=1;FimP('abs(grad)',ag,TiDi);
Fig('g');ug=updn2e(g);QUIVERe(ug);
%return

%s=cSuGr3I(a,[0.15,0.65,0.80],1);s
s=snPfIe(diP,g,1);s
%s=cSuGr3I(ag,[0.15,0.65,0.80],1);s
%return

mI=21;mJ=21    %S -область скан. пр€м. [mI,mJ] с центром в[I0,J0]                                 
if mod(mI,2)==0, mI0=mI/2+1;else mI0=(mI-1)/2+1; end;
if mod(mJ,2)==0, mJ0=mJ/2+1;else mJ0=(mJ-1)/2+1; end;
maD=ones(mI,mJ);
%return
for i=1:mI,i0=i-mI0;
    for j=1:mJ,j0=j-mJ0;
g=ouPCTe(G,I0+i0,J0+j0,n);ag=absV2e(g);
a=ouPCT(A,I0+i0,J0+j0,n);
s=snPfIe(diP,g,0);
maD(i,j)=+s;
    end
end
%FimP('d',d,TiDi);
FimP('maD',maD,TiDi);FSurPCT('maD',maD,AZI,ELE,clr,S_P);
'maxD'
max(max(maD))
mD=min(min(maD));
A=ones(L,L);A=A*mD;
B=inPCT(A,I0,J0,maD);
FimP('maD in P',B,TiDi);

%===========================================================