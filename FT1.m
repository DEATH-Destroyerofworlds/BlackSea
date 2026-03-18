function f=FT1(d,H)
%------ 1D-Fourier Transform
%[M,N]=size(H);
%f=zeros(1,M);
f=(H*d')'; %f & d are the rows!
%for i=1:M
%    s=0;
%    for j=1:N
%    s=s+H(i,j)*d(j);
%    end
%    f(i)=s;
%end