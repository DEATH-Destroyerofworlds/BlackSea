function m_IReVortex
[ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3;clr=gray;

uicontrol(gcf,'Style','text','BackgroundColor',[0.0 0.7 0.0],'Position',[20 10 400 200],...
    'FontName','Times New Roman','FontSize',30,...
    'String',{'Atmospheric vortex', 'in Earth'});drawnow;

TabAll=1;%0;1
S_P=0;%0;1;
LW=2;
TiDi=2;

im0='850kf0.bmp';% с ste=1;
Pc=imread(im0,'bmp');[r,g,b]=RGBf(Pc);%Prgb={r,g,b};TC=PTC(r,g,b);Fimage('Input - a',TC,TiDi);
a=g;%for   r;g;b;                                                          %WWWWWWWWWWWWWWWWWW
FimP('a',a,TiDi);

im1='850kF.bmp';%
Pc=imread(im1,'bmp');[R,G,B]=RGBf(Pc);%Prgb={R,G,B};TC=PTC(R,G,B);Fimage('Input - A',TC,TiDi);
A=G;%for   R;G;B;                                                          %WWWWWWWWWWWWWWWW
FimP('A',A,TiDi);

n=size(a,2)
L=size(A,2)
size(A)
S_Len=67;
%return
if mod(L,2)==0, Lo=L/2+1;else Lo=(L-1)/2+1; end;
if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;
[H,DH]=BaFuHa(L);
ind=0;%1;2;3;
pr=0.80;%0.7;0.3;
sG=0.35;%0.1;0.2;
wd=0.20;pr=0.15;pnd=0;%0;1;%(0.20;0.55 - R=2.64) (0.20;0.15 - G=3.51)(0.15; 0.40 -B=5.46)%WWWWWWWWW
pF=0.60;%0.3;0.6;1.2;
%Dir=CIRZe(n,1.0);          Fig('1век кас.к.окр');Dir=updn2e(Dir);QUIVERe(Dir);
%Dir=CIRZ1e(n,0.9,0.0);          Fig('1век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%Dir=CIRZ2e(n,[0.8,0.3],[0,-1]);   Fig('2век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%Dir=CIRZ3e(n,[0.8,0.5,0.4],[0.8,0.3,-0.8]);Fig('3век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%diC=CIRCEe(ind,n,pr,sG,-1.0);    Fig('diC');udiC=updn2e(diC);QUIVERe(udiC);
diP=CPOLYe(ind,n,pr,wd,pnd); Fig('diP');udiP=updn2e(diP);QUIVERe(udiP);
%return

%G=cgradIe(A,H,DH);%for pnd=1;
[G,pA]=cgraFIe(A,H,DH,pF);TiDi=1;FimP('pA',pA,TiDi);drawnow;%for pnd=1;

%G=ORTGe(G);Fig('oG');uG=updn2e(G);QUIVERe(uG);% for pnd=0;
aG=absV2e(G);TiDi=1;FimP('abs(Grad)',aG,TiDi);
Fig('G');uG=updn2e(G);QUIVERe(uG);

[y0,x0]=maxSNR(diP,n,G,pA,S_Len,S_P,TabAll); 
y0
x0

function [y0,x0]=maxSNR(diP,n,pG,pA,S_Len,S_P,TabAll)

[ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3;clr=gray;

L=size(pA,2);
if mod(L,2)==0, Lo=L/2+1;else Lo=(L-1)/2+1; end;%Lo
%if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;%n0

I0=Lo;J0=Lo; % центр фрагмента F=pA
%pg=ouPCTe(pG,I0,J0,n);
%apg=absV2e(pg);TiDi=1;FimP('abs(grad)',apg,TiDi);
%Fig('g');upg=updn2e(pg);QUIVERe(upg);
%return
%s=cSuGr3I(a,[0.15,0.65,0.80],1);s

%snr=snPfIe(diP,pg,1);%snr

%s=cSuGr3I(ag,[0.15,0.65,0.80],1);s
%return

I0=Lo;J0=Lo;m=S_Len;    %                                 
if mod(m,2)==0, m0=m/2+1;else m0=(m-1)/2+1; end;
maD=ones(m,m);
tsnr=-1;
for i=1:m,i0=i-m0;iy0=i0;
    for j=1:m,j0=j-m0;jx0=j0;
g=ouPCTe(pG,I0+i0,J0+j0,n);%ag=absV2e(g);
a=ouPCT(pA,I0+i0,J0+j0,n);
s=snPfIe(diP,g,0);maD(i,j)=s;
if s>tsnr, tsnr=s;tg=g;ta=a;ty0=iy0;tx0=jx0;end
    end
end
y0=ty0;x0=tx0;a=ta;g=tg;
Fig('g(x0,y0)');ug=updn2e(g);QUIVERe(ug);
ag=absV2e(g);TiDi=1;FimP('ag',ag,TiDi);FimP('a',a,TiDi);
snPfIe(diP,g,1);
FimP('maD',maD,TiDi);FSurPCT('maD',maD,AZI,ELE,clr,S_P);
'maxD'
max(max(maD))
mD=min(min(maD));
A=ones(L,L);A=A*mD;
B=inPCT(A,I0,J0,maD);
FimP('maD in P',B,TiDi);
%===========================================================