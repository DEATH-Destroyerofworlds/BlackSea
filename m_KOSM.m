function m_KOSM
TiDi=2;%0;1;2;
ste=2;%1;2;3;4;5;
wd=2;%=0,1,2;

imI='KOSX.jpg'; im0='KS0.bmp';im1='KS1.bmp'; imB='KS1B.bmp';

iP=imread(imI,'jpg');%FimP('iP в исходной сетке ',iP,1);
[R,G,B]=RGBf(iP); TC=PTC(R,G,B);Fimage('в исх сетке',TC,1);
%FimP('R',R,1);FimP('G',G,1);FimP('B',B,1);
p=INTRe(ste,{R,G,B});Pc=PTC(p{1},p{2},p{3});Fimage('в ste сетке',Pc,1);
%FimP('r -ste',p{1},1);FimP('g -ste',p{2},1);FimP('b -ste',p{3},1);
%return


%------------Правый и Левы вихри-----------
%coY=205; coX=85; szY=37;szX=37;%for KS0;%ste=2;
%coY=195; coX=75; szY=57;szX=57;%for KS1;%ste=2;
%-----Правый
%coY=115; coX=316; szY=73;szX=73;%for KS0;%ste=2;%*****Правый большой
%coY=90; coX=290; szY=133;szX=133;%for KS1;%ste=2;
%------------------------------------------
%coY=205; coX=85; szY=37;szX=37;%for KS0;%ste=2;%<<<<<Маленький левый
coY=195; coX=75; szY=57;szX=57;%for KS1;%ste=2;
%-----Левый
%coY=410; coX=170; szY=73;szX=73;%for KS0;%ste=1;
%coY=360; coX=110; szY=197;szX=197;%for KS1;%ste=1;
%-----------------------------------------------
pc=FROM(Pc,coY,coX,szY,szX);FimP('pc',pc,1);
%return
imwrite(pc,im1,'bmp');%im0;im1;
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

