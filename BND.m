function P=BND(iP,coY,coX,szY,szX,wd)
P=double(iP);le=size(P,3);
[c0,c1,X]=m01BW(iP);cz=0.5*(c0+c1);
cc=c0;%cc=c0,c1; c0- for astronom pictures 
for i=coY-wd:coY+szY+wd
    for j=coX-wd:coX
    ct=X(i,j);
    if ct<cz
    P(i,j,1)=c1;  if le==3,P(i,j,2)=c1;P(i,j,3)=c1;end 
    else
    P(i,j,1)=cc;  if le==3,P(i,j,2)=cc;P(i,j,3)=cc;end 
    end
    end
    for j=coX+szX:coX+szX+wd
    ct=X(i,j);
    if ct<cz
    P(i,j,1)=c1;  if le==3,P(i,j,2)=c1;P(i,j,3)=c1;end 
    else
    P(i,j,1)=cc;  if le==3,P(i,j,2)=cc;P(i,j,3)=cc;end 
    end
    end
end

for j=coX+1:coX+szX-1
    for i=coY-wd:coY
    ct=X(i,j);
    if ct<cz
    P(i,j,1)=c1;  if le==3,P(i,j,2)=c1;P(i,j,3)=c1;end 
    else
    P(i,j,1)=cc;  if le==3,P(i,j,2)=cc;P(i,j,3)=cc;end 
    end
    end
    
    for i=coY+szY:coY+szY+wd
    ct=X(i,j);
    if ct<cz
    P(i,j,1)=c1;  if le==3,P(i,j,2)=c1;P(i,j,3)=c1;end 
    else
    P(i,j,1)=cc;  if le==3,P(i,j,2)=cc;P(i,j,3)=cc;end 
    end
    end
end
P=uint8(P);