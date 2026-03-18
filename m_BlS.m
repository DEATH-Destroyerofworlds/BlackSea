function m_BlS
%„ерное море
TiDi=2;%0;1;2;
ste=1;%1;2;3;4;5;6;
wd=1;%=0,1,2;

imI='BlaSea.jpg'; im0='BlS0.bmp';im1='BlS1.bmp';%;
imB='BlaSeaB.bmp';

iP=imread(imI,'jpg');%FimP('iP в исходной сетке ',iP,1);
[R,G,B]=RGBf(iP); TC=PTC(R,G,B);%Fimage('в исх сетке',TC,1);
%FimP('R',R,1);FimP('G',G,1);FimP('B',B,1);
p=INTRe(ste,{R,G,B});Pc=PTC(p{1},p{2},p{3});Fimage('в ste сетке',Pc,1);
%FimP('r -ste',p{1},1);FimP('g -ste',p{2},1);FimP('b -ste',p{3},1);
%return


coY=258; coX=250; szY=111;szX=111;%for BlS1;%ste=1;
%coY=310; coX=250; szY=61;szX=61;%for BlS0;%ste=1;

%---------------------------
pc=FROM(Pc,coY,coX,szY,szX);FimP('pc',pc,1);
%return
%imwrite(pc,im0,'bmp');%im0;im00;
imwrite(pc,im1,'bmp');%im1;
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

