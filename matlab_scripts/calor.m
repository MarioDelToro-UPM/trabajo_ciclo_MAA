% -------------------------- TRANSFERENCIA DE CALOR -----------------------
%      EVALUA LAS PERDIDAS POR TRANSFERENCIA DE CALOR SEGUN LA FORMULA DE
%      WOSCHNI ,PUDIENDO UTILIZARSE EN (SIEMPRE CON PRECAMARA) :
%         COMPRESION    :    C1=2.28  ; C2= 0
%         COMBUSTION    :    C1=2.28  ; C2=6.22E-03
%         EXPANSION     :    C1=2.28  ; C2=6.22E-03
%         BARRIDO       :    C1=6.18  ; C2= 0
%      VAR.ENTRADA     :
%         C1,C2         = SIGNIFICADO ANTERIOR
%         PC,VC         = VALORES DE REFERENCIA
%         P,T           = PRESION(atm.) Y TEMPERATURA EN CADA INSTANTE
%         ALFA          = ANGULO DE GIRO CIGUEÑAL EN RAD.
%         QR            = CILINDRADA UNITARIA EN LITROS
%      VAR.INTERNAS    :
%         D,L           = CALIBRE,CARRERA EN m
%         CM            = VELOCIDAD MEDIA DEL EMBOLO EN m/s
%         PBAR          = PRESION EN bar
%      VAR.SALIDA      :
%         HW            = COEF.CONVECCION, UNIDADES W*/K*m^2
%         QW            = CALOR TRANSFERIDO J/s (Watios)
%  CW ENGLOBA VARIACIONES DE AREA MOJADA E IMPORTANCIA DE LA TRANS.DE CALOR
% -------------------------------------------------------------------------
%       SUBROUTINE CALOR(T,P,ALFA,C1,C2,GAMMAN2,QW,HW)
%       IMPLICIT DOUBLE PRECISION (A-Z)
% 	COMMON /E1/RG,QR,CILS,LD,LA,DR,RCA,AAE
%       COMMON /E2/PA,PE,FR,RPM,TA,TC,TS,NO,CW,LIQUID
%       COMMON /V1/CL,RC,L,D,VPMI,VPMS
%       COMMON /P1/P1P,PN2,PY
%       COMMON /T1/T1P,TN2,TY
%       COMMON /VO1/V1P,VN2,VY,vx

function [qw,hg]=calor(P,T,b,Up,C1,C2,GAMMA,Vol,P1p,rv,T1p,P2,V2,Tw,Cw)
 
Pbar=P/100000;
P2bar=P2/100000;
Pm=P2bar*(V2/Vol)^GAMMA;
P1pbar=P1p/100000;
%Para Ugas no sé si es Vol/V1p o Vd/V1p!!!!!!!!
Ugas=C1*Up+C2*rv*T1p/P1pbar*(Pbar-Pm);
hg=0.0130*b^(-0.2)*P^.8*T^(-0.55)*Ugas^0.8;
Amojada=pi*b^2/2+4*Vol/b;
%     QPP ES EL CALOR cedido POR EL GAS
qw=Cw*Amojada*hg*(T-Tw);

end