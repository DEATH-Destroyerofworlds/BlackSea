function m_Ensh
TiDi=2;%0;1;2;Enah1.jpg;
%im0='Ensh1.jpg; im1='Ensh10.bmp'; imB='Ensh1B.bmp';
%coY=210; coX=333; szY=71;szX=71;%Ensh1->Ensh10;

im0='Ensh10.bmp'; %im0='Ensh1.jpg'; 

im1='En0.bmp'; imB='En0B.bmp';
coY=18; coX=17; szY=35;szX=35;%Ensh10->En0;En0B

wd=1;%=0,1,2,3,4
%---------------------------
iP=imread(im0,'bmp');
Fimage('iP',iP,1);%return

Pc=FROM(iP,coY,coX,szY,szX);

Fimage('Pc',Pc,TiDi);

%[R,G,B]=RGBf(Pc);Prgb={R,G,B};
%TC=PTC(R,G,B);Fimage('Input',TC,TiDi);
%FimP('R',R,TiDi);FimP('G',G,TiDi);FimP('B',B,TiDi);
%return
Fimage(im1,Pc,'bmp');
imwrite(Pc,im1,'bmp');

P=BND(iP,coY,coX,szY,szX,wd);
Fimage('P',P,1);
%imwrite(P,imB,'bmp');
