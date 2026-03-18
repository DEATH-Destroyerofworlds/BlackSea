function d=IFT1(f,H)
%------ 1D-Inverse Fourier Transform
%[M,N]=size(H);
%d=zeros(1,N);
d=f*H;%f & d are the rows!
%for j=1:N
%    s=0;
%    for i=1:M
%    s=s+f(i)*H(i,j);
%    end
%    d(j)=s;
%end