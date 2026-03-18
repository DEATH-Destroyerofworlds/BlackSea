function [H,DH]=BaFuHa(n)
N=n+n-1;X0=0:N-1;H=HBSRow(N,X0,0);DH=HBSRow(N,X0,+1); 
