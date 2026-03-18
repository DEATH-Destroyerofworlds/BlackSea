function m_eyezg2a
TiDi=2;%0;1;2;ZG2.jpg;

%im0='ZG2.jpg'; im1='zgL.bmp'; imB='zgLB.bmp';
%coY=2; coX=94; szY=27;szX=27;

%im0='ZG2.jpg'; im1='zgR.bmp'; imB='zgRB.bmp';
%coY=8; coX=158; szY=27;szX=27;

im0='ZG2.jpg'; im1='zn.bmp'; imB='znB.bmp';
coY=55; coX=114; szY=27;szX=27;


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
%imwrite(Pc,im1,'bmp');

P=BND(iP,coY,coX,szY,szX,wd);
Fimage('P',P,1);
%imwrite(P,imB,'bmp');
