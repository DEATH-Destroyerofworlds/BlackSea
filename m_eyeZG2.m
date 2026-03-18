function m_eyeZG2
TiDi=2;%0;1;2;ZG2.jpg;

im0='ZG2.jpg'; im1='ZGL_.bmp'; imB='ZGLB_.bmp';
coY=2; coX=80; szY=55;szX=55;

%im0='ZG2.jpg'; im1='ZGR_.bmp'; imB='ZGRB_.bmp';
%coY=2; coX=144; szY=55;szX=55;

%im0='ZG2.jpg'; im1='ZN_.bmp'; imB='ZNB_.bmp';
%coY=41; coX=110; szY=55;szX=55;


wd=1;%=0,1,2,3,4
%---------------------------
iP=imread(im0,'jpg');
Fimage('iP',iP,1);%return

Pc=FROM(iP,coY,coX,szY,szX);

Fimage('Pc',Pc,TiDi);%return

[R,G,B]=RGBf(Pc);Prgb={R,G,B};
TC=PTC(R,G,B);Fimage('Input',TC,TiDi);
FimP('R',R,TiDi);FimP('G',G,TiDi);FimP('B',B,TiDi);
%return
Fimage(im1,Pc,'bmp');
imwrite(Pc,im1,'bmp');

P=BND(iP,coY,coX,szY,szX,wd);
Fimage('P',P,1);
%imwrite(P,imB,'bmp');
