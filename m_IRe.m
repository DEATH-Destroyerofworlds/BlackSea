function m_IRe
%Вихрь в ИК
TiDi=2;%0;1;2;
ste=4;%1;2;3;4;5;6;%ste=4 только для imI='850kZ.jpg';
wd=1;%=0,1,2;

imI='850kZ.jpg'; im1='850kF.bmp';imB='850kZB.bmp';
%imI='850kF.bmp'; im0='850kf0.bmp';

iP=imread(imI,'jpg');FimP('iP в исходной сетке ',iP,1);
[R,G,B]=RGBf(iP); TC=PTC(R,G,B);%Fimage('в исх сетке',TC,1);
FimP('R',R,1);FimP('G',G,1);FimP('B',B,1);
p=INTRe(ste,{R,G,B});Pc=PTC(p{1},p{2},p{3});Fimage('в ste сетке',Pc,1);
%FimP('r -ste',p{1},1);FimP('g -ste',p{2},1);FimP('b -ste',p{3},1);
%return


coY=81; coX=103; szY=133;szX=133;%for 850kF;%ste=4;
%coY=44; coX=40; szY=51;szX=51;%for 850kF;%ste=1;




%---------------------------
pc=FROM(Pc,coY,coX,szY,szX);FimP('pc',pc,1);
[rp,gp,bp]=RGBf(pc);FimP('r',rp,1);FimP('g',gp,1);FimP('b',bp,1);
%return
%imwrite(pc,im1,'bmp');%im1;
%imwrite(pc,im0,'bmp');%im0;
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

