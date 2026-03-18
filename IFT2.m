function D=IFT2(F,H)
%------ 2D-Invers Fourier Transform
Hm=H{1};Hn=H{2}; D=F;
m=size(Hm,1);n=size(Hn,1);
%M=size(Hm,2);N=size(Hn,2);
%if M==m && N==n
   dm=zeros(1,m);dn=zeros(1,n);
   for i=1:m,dn(1,:)=D(i,:);
   dn=IFT1(dn,Hn); D(i,:)=dn(1,:);
   end
   for j=1:n,dm(1,:)=D(:,j);
   dm=IFT1(dm,Hm); D(:,j)=dm(1,:);
   end
%else % »нтерпол€ци€ в целом идет с биени€ми от границ
% в отсчетах - это можно использовать вместо выше 
%  D=zeros(M,N);HM=zeros(1,M);HN=zeros(1,N);
%    for i=1:m, HM(1,:)=Hm(i,:);
%    for j=1:n, HN(1,:)=Hn(j,:);
%        HMN=HM'*HN;
%       D=D+F(i,j)*HMN; 
%    end
%    end
   
%end