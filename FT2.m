function F=FT2(D,H)
%------ 2D-Fourier Transform
Hm=H{1};Hn=H{2};F=D;
m=size(Hm,1);n=size(Hn,1);
fm=zeros(1,m);fn=zeros(1,n);
for i=1:m,fn(:)=F(i,:);
fn=FT1(fn,Hn);  F(i,:)=fn(:);
end
for j=1:n,fm(:)=F(:,j);
fm=FT1(fm,Hm);  F(:,j)=fm(:);
end