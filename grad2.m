function [Px,Py]=grad2(F2,H,DH)
Px=D_P2(F2,DH,H);
Py=D_P2(F2,H,DH);