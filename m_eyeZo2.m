function m_eyeZo2
TiDi=2;%0;1;2;ZG2.jpg;

im0='ZGL_.bmp'; im1='ZGLo_.bmp'; 
coY=2; coX=17; szY=21;szX=21;

%im0='ZGR_.bmp'; im1='ZGRo_.bmp'; 
%coY=10; coX=17; szY=21;szX=21;

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
%imwrite(Pc,im1,'bmp');


