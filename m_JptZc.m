function m_JptZc
%JupiterZ
TiDi=1;%0;1;2;
ste=1;%1;2;3;4;5;6;
wd=1;%=0,1,2;

%imI='JptZ.jpg'; im0='JptZc0.bmp';im1='JptZc1.bmp';%;
imI='JptZc1.bmp'; im0='JptZc0.bmp';im1='FptZc1.bmp';
imB='JptZcB.bmp';

%iP=imread(imI,'jpg');FimP('iP в исходной сетке ',iP,1);
iP=imread(imI,'bmp');FimP('iP в исходной сетке ',iP,1);
[R,G,B]=RGBf(iP); 
%return

TC=PTC(R,G,B);Fimage('в исх сетке',TC,TiDi);
%FimP('R',R,1);FimP('G',G,1);FimP('B',B,1);
p=INTRe(ste,{R,G,B});Pc=PTC(p{1},p{2},p{3});
Fimage('в ste сетке',Pc,TiDi);
%FimP('r -ste',p{1},1);FimP('g -ste',p{2},1);FimP('b -ste',p{3},1);
%FimP('B',B,1);Pc=B;
%return


%coY=17; coX=2; szY=71;szX=71;%for JptZa1;%ste=1;
coY=43; coX=24; szY=15;szX=15;%for JptZa0;%ste=1;

%---------------------------
pc=FROM(Pc,coY,coX,szY,szX);FimP('pc',pc,1);
%return
%imwrite(pc,im0,'bmp');%im0;
%imwrite(pc,im1,'bmp');%im1;
PB=BND(Pc,coY,coX,szY,szX,wd);FimP('PB',PB,TiDi);
%imwrite(PB,imB,'bmp');
%============================================

function p=INTRe(ste,P)
p{3}=INTR(ste,P{3});
p{2}=INTR(ste,P{2});
p{1}=INTR(ste,P{1});

function p=INTR(ste,P)
P=double(P);
[M,N]=size(P);I=1:ste:M;m=size(I,2);J=1:ste:N;n=size(J,2);
p=zeros(m,n);i=0;
for I=1:ste:M,i=i+1;j=0;
    for J=1:ste:N,j=j+1;
        p(i,j)=P(I,J);
    end
end
p=u8d(p);

