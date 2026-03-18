function m_CaF
%Camomile flower %ромашка цветок
TiDi=2;%0;1;2;
ste=1;%1;2;3;4;5;6;
wd=1;%=0,1,2;

imI='CamFlo.jpg'; im0='CaF0.bmp';im1='CaF1.bmp';%;
imB='CaF1B.bmp';

iP=imread(imI,'jpg');FimP('iP в исходной сетке ',iP,1);
[R,G,B]=RGBf(iP); TC=PTC(R,G,B);Fimage('в исх сетке',TC,1);
%FimP('R',R,1);FimP('G',G,1);FimP('B',B,1);
p=INTRe(ste,{R,G,B});Pc=PTC(p{1},p{2},p{3});Fimage('в ste сетке',Pc,1);
%FimP('r -ste',p{1},1);FimP('g -ste',p{2},1);FimP('b -ste',p{3},1);
%return


coY=88; coX=213; szY=81;szX=81;%for CaF0;%ste=1;
%coY=58; coX=183; szY=141;szX=141;%for CaF1;%ste=1;

%coY=44; coX=107; szY=41;szX=41;%for CaF0;%ste=2;
%coY=29; coX=92; szY=71;szX=71;%for CaF1;%ste=2;


%---------------------------
pc=FROM(Pc,coY,coX,szY,szX);FimP('pc',pc,1);
%return
imwrite(pc,im0,'bmp');%im0;im1;
%imwrite(pc,im1,'bmp');%im0;im1;
PB=BND(Pc,coY,coX,szY,szX,wd);FimP('PB',PB,TiDi);
%imwrite(PB,imB,'bmp');
%============================================

function p=INTRe(ste,P)
p{3}=INTR(ste,P{3});
p{2}=INTR(ste,P{2});
p{1}=INTR(ste,P{1});

function p=INTR(ste,P)
[M,N]=size(P);I=1:ste:M;m=size(I,2);J=1:ste:N;n=size(J,2);
p=zeros(m,n);i=0;
for I=1:ste:M,i=i+1;j=0;
    for J=1:ste:N,j=j+1;
        p(i,j)=P(I,J);
    end
end

