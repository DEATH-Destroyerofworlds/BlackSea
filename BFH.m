function [H,DH]=BFH(N)
dx=1;
X0=0:dx:N-dx;H=HBSRow(N,X0,0);DH=HBSRow(N,X0,+1); 


