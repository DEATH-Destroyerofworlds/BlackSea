function m_BlaSea
[ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3;clr=gray;

uicontrol(gcf,'Style','text','BackgroundColor',[0.0 0.7 0.0],'Position',[20 10 400 200],...
    'FontName','Times New Roman','FontSize',30,...
    'String',{'Black sea vortex', 'in Image'});drawnow;

TabAll=1;%0;1
S_P=0;%0;1;
LW=2;
TiDi=2;

im0='BlSa0.bmp';%только с ste=1;
Pc=imread(im0,'bmp');[r,g,b]=RGBf(Pc);%Prgb={r,g,b};TC=PTC(r,g,b);Fimage('Input - a',TC,TiDi);
a=b;%for   r;g;b;
FimP('a',a,TiDi);

im1='BlSa1.bmp';%
Pc=imread(im1,'bmp');[R,G,B]=RGBf(Pc);%Prgb={R,G,B};TC=PTC(R,G,B);Fimage('Input - A',TC,TiDi);
A=B;%for   R;G;B;
FimP('A',A,TiDi);

n=size(a,2)
L=size(A,2)
forIIFAR(n);return
size(A)
%return
if mod(L,2)==0, Lo=L/2+1;else Lo=(L-1)/2+1; end;Lo
if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;n0
[H,DH]=BaFuHa(L);
forIRAF(L);return
ind=0;%1;2;3;
pr=0.80;%0.7;0.3;
sG=0.35;%0.1;0.2;
wd=0.90;pr=0.15;pnd=0;%0;1;
pF=0.55;%0.3;0.6;1.2;
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
%I0=Lo;J0=Lo; % in the center
I0=19+n0;J0=11+n0;
g=ouPCTe(G,I0,J0,n);
ag=absV2e(g);TiDi=1;FimP('abs(grad)',ag,TiDi);
Fig('g');ug=updn2e(g);QUIVERe(ug);
%return

%s=cSuGr3I(a,[0.15,0.65,0.80],1);s
s=snPfIe(diP,g,1);s
%s=cSuGr3I(ag,[0.15,0.65,0.80],1);s
%return

I0=Lo;J0=Lo;m=37    %m=67 ; 37-a;                                     
if mod(m,2)==0, m0=m/2+1;else m0=(m-1)/2+1; end;
maD=ones(m,m);
%return
for i=1:m,i0=i-m0;
    for j=1:m,j0=j-m0;
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

function forIIFAR(N)
N
TiDi=1;
%[H,DH]=BaFuHa(L);% не нужно
[H,DH]=BFH(N);
size(H)
k1=14;k2=22;
h=zeros(1,N); h1=h;h2=h;dh1=h;dh2=h;
K2=zeros(N,N);K2(k1,k2)=1;
FimP('H',H,TiDi);FimP('Ht',H',TiDi);FimP('Ht*H',H'*H,TiDi);

h1(1,:)=H(k1,:);h2(1,:)=H(k2,:);%2D(h1t*h2);
FimP('h1t*h2',h1'*h2,TiDi);FimP('K2(k1,k2)',K2,TiDi);

dh1(1,:)=DH(k1,:);h2(1,:)=H(k2,:);%2D(dh1t*h2);
FimP('dh1t*h2',dh1'*h2,TiDi);

h1(1,:)=H(k1,:);dh2(1,:)=DH(k2,:);%2D(h1t*dh2);
FimP('h1t*dh2',h1'*dh2,TiDi);

FimP('DH',DH,TiDi);


%===========================================================