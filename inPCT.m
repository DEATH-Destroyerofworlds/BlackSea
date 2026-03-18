function B=inPCT(A,I0,J0,maD)
m=size(maD,1);
B=A;
if mod(m,2)==0, m0=m/2+1;else m0=(m-1)/2+1; end;
for i=1:m,i0=i-m0;
    for j=1:m,j0=j-m0;
        B(I0+i0,J0+j0)=maD(i,j);
    end
end