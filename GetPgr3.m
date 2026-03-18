function [ceXY,ceGI,grV,grH,gV,gH,AZI,ELE,npt,clr,fs]=GetPgr3
%angles & sizes of domains for all the output graphics
AZI=-36;ELE=24;npt=100;fs=13;
clr=jet;%hsv;gray;jet
ceXY(1)={[50  20]};ceXY(2)={[320  20]};grV=135;
ceXY(3)={[50 230]};ceXY(4)={[320 230]};grH=195;
ceXY(5)={[50 440]};ceXY(6)={[320 440]};
ceGI=cell(3,3);
ceGI(3,1)={[50  20]};ceGI(3,2)={[230  20]};ceGI(3,3)={[410  20]}; gV=180;%220;390;170;
ceGI(2,1)={[50 240]};ceGI(2,2)={[230 240]};ceGI(2,3)={[410  240]};gH=125;
ceGI(1,1)={[50 460]};ceGI(1,2)={[230 460]};ceGI(1,3)={[410  460]};