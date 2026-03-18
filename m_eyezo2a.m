function m_eyezo2a
TiDi=2;%0;1;2;ZG2.jpg;

%im0='zgL.bmp'; im1='zgLo.bmp'; 
%coY=6; coX=8; szY=13;szX=13;

im0='zgR.bmp'; im1='zgRo.bmp'; 
coY=8; coX=7; szY=13;szX=13;

wd=1;%=0,1,2,3,4
%---------------------------
iP=imread(im0,'bmp');
Fimage('iP',iP,1);%return

Pc=FROM(iP,coY,coX,szY,szX);

Fimage('Pc',Pc,TiDi);%return

[R,G,B]=RGBf(Pc);Prgb={R,G,B};
TC=PTC(R,G,B);Fimage('Input',TC,TiDi);
FimP('R',R,TiDi);FimP('G',G,TiDi);FimP('B',B,TiDi);
%return
Fimage(im1,Pc,'bmp');
imwrite(Pc,im1,'bmp');


