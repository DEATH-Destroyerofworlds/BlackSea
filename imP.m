function imP(X,TiDi)
%output for gray image
imagesc(X);colormap(gray);
if TiDi==0,TiDi0;end;%имено так
if TiDi==2,TiDi2(X);end% снимаем размер