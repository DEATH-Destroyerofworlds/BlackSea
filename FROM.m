function P=FROM(iP,coY,coX,szY,szX)
iP=double(iP);
[he wi le]=size(iP);
P=zeros(szY,szX,le);
for k=1:le
for i=1:szY
   ii=i+coY;
   for j=1:szX
      jj=j+coX;
      P(i,j,k)=iP(ii,jj,k);
   end
end
end
P=uint8(P);