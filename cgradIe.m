function b=cgradIe(a,H,DH)
%BW Image, 2D- output, a - скал€р
%a,H,DH;without FDST
A=inCOS2(a);F=FT2(A,{H,H});
[Bx,By]=grad2(F,H,DH);
bx=ouCOS2(Bx);by=ouCOS2(By);
b={bx,by};