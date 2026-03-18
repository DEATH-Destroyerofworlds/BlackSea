function HBS=HBSRow(N,x,n)
% n== 0 : for function;
% n > 0 : differentiation;
% n < 0 : integration
%RHBS0/1->RHBS->HBSRow, BS - "BASE STATIC"
Nx=length(x); HBS=zeros(N,Nx);
for ind=1:N;
 HAS=RHBS(ind,N,x,n);
 HBS(ind,:)=HAS(:);
end
%STATIC:  HBS Integ with "C*X^(-n)"
%DYNAMIC: HBD Integ with only saved "C".