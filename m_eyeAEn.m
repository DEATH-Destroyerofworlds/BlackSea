function m_eyeAEn
%S_P=0;%0;1;
%ouP=0;%0;1;
%LW=2;
TiDi=1;%0;1;2;
uicontrol(gcf,'Style','text','BackgroundColor',[0.0 0.7 0.0],'Position',[20 10 400 200],...
    'FontName','Times New Roman','FontSize',30,...
    'String',{'Grad, Div & Rot', 'for Eye of AEn'});drawnow;

%En10;En0;kos0;
im0='En0.bmp';     %bd0;bd;%pMeMo0;En0;CA20;CB20;
Pc=imread(im0,'bmp');%v0;imf3;kos0;        v80;s70;
Fig('Input');image(Pc);
%return
[R,G,B]=RGBf(Pc);%Prgb={R,G,B};
TC=PTC(R,G,B);Fimage('Input',TC,TiDi);
%FimP('R',R,TiDi);%FimP('G',G,TiDi);FimP('B',B,TiDi);
a=B;%for   R;G;B;

PRO_eEn;
%PROd(a);
%PROc(a);



%===========================================================
function PRO_eEn
[ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3;clr=gray;gV=0.7*gV;
TabAll=1;%0;1
S_P=0;%0;1;
ouP=0;%0;1;
LW=2;
TiDi=1;%0;1;2;
%En10;En0;
im0='En0.bmp';     %bd0;bd;%pMeMo0;En0;CA20;CB20;
Pc=imread(im0,'bmp');%v0;imf3;kos0;        v80;s70;
Fig('Input a');image(Pc);[R,G,B]=RGBf(Pc);%Prgb={R,G,B};TC=PTC(R,G,B);Fimage('Input',TC,TiDi);
a=B;%for   R;G;B;

im0='En10.bmp'; 
Pc=imread(im0,'bmp');
Fig('Input A');image(Pc); [R,G,B]=RGBf(Pc);%Prgb={R,G,B};TC=PTC(R,G,B);Fimage('Input',TC,TiDi);
A=B;%for   R;G;B;

n=size(a,2)
L=size(A,2)
if mod(L,2)==0, Lo=L/2+1;else Lo=(L-1)/2+1; end;Lo
[H,DH]=BaFuHa(L);
ind=2;%1;2;3;
pr=0.65;%0.7;0.3;
sG=0.1;

%Dir=CIRZe(n,1.0);          Fig('1век кас.к.окр');Dir=updn2e(Dir);QUIVERe(Dir);
Dir=CIRZ1e(n,0.8,0.0);          Fig('1век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
Dir=CIRZ2e(n,[0.8,0.3],[0,-1]);   Fig('2век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%Dir=CIRZ3e(15,[0.8,0.5,0.4],[0.8,0.3,-0.8]);Fig('3век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
%Dir=CIRZ3e(15,[0.8,0.5,0.4],[1.0,0.0,-1.0]);Fig('3век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
Dir=CIRZ2e(15,[0.8,0.2],[-1,-1]);   Fig('2век кас.к.окр');uDir=updn2e(Dir);QUIVERe(uDir);
Dir=CIRZ4e(15,[0.8,0.6,0.4,0.2],[1.0,-1.0]);Fig('2 кольца в окр');uDir=updn2e(Dir);QUIVERe(uDir);
Dir=CIRZ4e(15,[0.8,0.6,0.4,0.2],[2.0, +0.0]);Fig('2 кольца в окр');uDir=updn2e(Dir);QUIVERe(uDir);

%return
diC=CIRCEe(ind,n,pr,sG,-1.0);    Fig('diC');udiC=updn2e(diC);QUIVERe(udiC);
%return



G=cgradIe(A,H,DH);
aG=absV2e(G);TiDi=1;FimP('abs(Grad)',aG,TiDi);
Fig('G');uG=updn2e(G);QUIVERe(uG);
I0=Lo;J0=Lo;  
g=ouPCTe(G,I0,J0,n);
ag=absV2e(g);TiDi=1;FimP('abs(grad)',ag,TiDi);
Fig('g');ug=updn2e(g);QUIVERe(ug);
%return


%s=SR_fPfIe(g,ind,pr,sG,1);s
s=SC_fPfIe(g,ind,pr,sG,1);s   
%s=cSuGr3I(a,[0.15,0.65,0.80],1);s
%s=cSuGr3I(ag,[0.15,0.65,0.80],1);s
%return

I0=Lo;J0=Lo;m=41                                         %1;3;5;21;Lo=35
if mod(m,2)==0, m0=m/2+1;else m0=(m-1)/2+1; end;
maD=ones(m,m);
%return
for i=1:m,i0=i-m0;
    for j=1:m,j0=j-m0;
g=ouPCTe(G,I0+i0,J0+j0,n);ag=absV2e(g);
a=ouPCT(A,I0+i0,J0+j0,n);
%s=SC_fPfIe(g,ind,pr,sG,0);%s
s=SR_fPfIe(g,ind,pr,sG,0);%s             % StoN(oG|X)
%s=cSuGr3I(ag,[0.15,0.65,0.80],0);       % Анализ контуров в |G|
%s=cSuGr3I(a,[0.15,0.65,0.80],0);       % Морфологический анализ А
maD(i,j)=+s;
    end
end
%FimP('d',d,TiDi);
FimP('maD',maD,TiDi);FSurPCT('maD',maD,AZI,ELE,clr,S_P);
max(max(maD))
mD=min(min(maD))
A=ones(L,L);A=A*mD;
B=inPCT(A,I0,J0,maD);
FimP('maD in P',B,TiDi);



%===========================================================
function [H,DH]=BaFuHa(n)
N=n+n-1;X0=0:N-1;H=HBSRow(N,X0,0);DH=HBSRow(N,X0,+1); 
%-----------------------------------------------------------
function p=ouPCT(P,I0,J0,n)
[M,N]=size(P);
if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;
p=zeros(n,n);
for i=1:n,i0=i-n0;Ii=I0+i0;
    if Ii<1,Ii=-Ii+1;end;if Ii>M,Ii=2*M+1-Ii;end
    for j=1:n,j0=j-n0;Jj=J0+j0;
    if Jj<1,Jj=-Jj+1;end;if Jj>N,Jj=2*N+1-Jj;end    
      p(i,j)=P(Ii,Jj);
    end
end

function p=ouPCTe(P,I0,J0,n)
p1=ouPCT(P{1},I0,J0,n);p2=ouPCT(P{2},I0,J0,n);p={p1,p2};

function B=inPCT(A,I0,J0,maD)
m=size(maD,1);
B=A;
if mod(m,2)==0, m0=m/2+1;else m0=(m-1)/2+1; end;
for i=1:m,i0=i-m0;
    for j=1:m,j0=j-m0;
        B(I0+i0,J0+j0)=maD(i,j);
    end
end

function p=inPCTe(P,I0,J0,n)
p1=inPCT(P{1},I0,J0,n);p2=inPCT(P{2},I0,J0,n);p={p1,p2};
%-----------------
function c=scaIe(a,b)
c=a{1}.*b{1}+a{2}.*b{2};

function cn=norI(a)
n=size(a,2);a2=a.^2;
s2=sum(sum(a2));cn=sqrt(s2)/n;


function cn=norIe(a)
n=size(a{1},2);
a2=a{1}.^2+a{2}.^2;
s2=sum(sum(a2));cn=sqrt(s2)/n;

function Pf=Pa_fIe(a,f)
n=size(a{1},2);
if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;
af=scaIe(a,f);
Pf1=af.*a{1};Pf2=af.*a{2};
Pf1(n0,n0)=f{1}(n0,n0);Pf2(n0,n0)=f{2}(n0,n0);
Pf={Pf1,Pf2};

function f_Pf=f_PfIe(a,f)
n=size(a{1},2);
if mod(n,2)==0, n0=n/2+1;else n0=(n-1)/2+1; end;
Pf=Pa_fIe(a,f);
g1=f{1}-Pf{1};g2=f{2}-Pf{2};
ar=sqrt(a{1}.^2+a{2}.^2);
g1=g1.*ar;g2=g2.*ar;
g1(n0,n0)=0;g2(n0,n0)=0;
f_Pf={g1,g2};


function StoN=SR_fPfIe(f,ind,pr,sG,ouP)
n=size(f{1},2);
diR=CIRCEe(ind,n,pr,sG,-0.0);f_=VREVEe(f,pr,diR);
Pf=Pa_fIe(diR,f_);f_Pf=f_PfIe(diR,f_);

aPf=absV2e(Pf);af_Pf=absV2e(f_Pf);
StoN=norIe(Pf)/norIe(f_Pf);
if ouP==1
af=absV2e(f);TiDi=1;FimP('abs(grad)',af,TiDi);
Fig('f_');uf_=updn2e(f_);QUIVERe(uf_);
af_=absV2e(f_);TiDi=1;FimP('abs(grad_)',af_,TiDi);
Fig('diR');udiR=updn2e(diR);QUIVERe(udiR);
adiR=absV2e(diR);TiDi=1;FimP('abs(diR)',adiR,TiDi);

Fig('signal - Pf');uPf=updn2e(Pf);QUIVERe(uPf);
Fig('Noise - f_Pf');uf_Pf=updn2e(f_Pf);QUIVERe(uf_Pf);
FimP('abs(Pf)',aPf,TiDi);
FimP('abs(f_Pf)',af_Pf,TiDi);
[ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3;clr=gray;S_P=0;
FSurPCT('abs(Pf)',aPf,AZI,ELE,clr,S_P);
FSurPCT('abs(f_Pf)',af_Pf,AZI,ELE,clr,S_P);

end

function StoN=SC_fPfIe(f,ind,pr,sG,ouP)
n=size(f{1},2);
f=ORTGe(f); 
diC=CIRCEe(ind,n,pr,sG,-1.0);f_=VREVEe(f,pr,diC);
Pf=Pa_fIe(diC,f_);f_Pf=f_PfIe(diC,f_);
aPf=absV2e(Pf);af_Pf=absV2e(f_Pf);
StoN=norIe(Pf)/norIe(f_Pf);
if ouP==1
af=absV2e(f);TiDi=1;FimP('abs(grad)',af,TiDi);
Fig('f_');uf_=updn2e(f_);QUIVERe(uf_);
Fig('diC');udiC=updn2e(diC);QUIVERe(udiC);

Fig('Signal - Pf');uPf=updn2e(Pf);QUIVERe(uPf);
Fig('Noise - f_Pf');uf_Pf=updn2e(f_Pf);QUIVERe(uf_Pf);
FimP('abs(Pf)',aPf,TiDi);
FimP('abs(f_Pf)',af_Pf,TiDi);
end

%-------------------------------------

function StoN=cSuGr3I(a,pr,ouP)
n=size(a,2);
if mod(n,2)==2, no=n/2+1;else no=(n-1)/2+1;end
r1=pr(1);r2=pr(2);r3=pr(3);A1=zeros(n,n);A23=A1;
v1=0;v23=0;

for i=1:n,y=i-no;
    for j=1:n,x=j-no;r=sqrt(x*x+y*y);c=r/no;
        if c<r1,A1(i,j)=1;v1=v1+a(i,j);end
        if c<r3 && c>r2; A23(i,j)=1;v23=v23+a(i,j);end
    end
end
s1=sum(sum(A1));s23=sum(sum(A23));c1=v1/s1;c23=v23/s23;
Pf=c1*A1+c23*A23;f_Pf=a-Pf;
StoN=norI(Pf)/norI(f_Pf);
if ouP==1,
   TiDi=1;FimP('A1',A1,TiDi);FimP('A23',A23,TiDi);
   FimP('f',a,TiDi);FimP('Pf',Pf,TiDi);FimP('f_Pf',f_Pf,TiDi);
end
 