s1=90.5;
b1=75;
lambda=0.3;
rg=9;
rca=30;
aae=30;
aicb=25;
dcb1=60;
rpm=1500;
pe1=1;
Ta=325;
pa1=2.6;
fequ=1.25;
Tw=450;
a=5;
n=3;
gamma1=1.3;
gamma2=1.3;
miter=3;
ncil=4;  % Resultados para un motor de 3 cilindros.

if (fequ>1.03)
    feq=1.03;
else
    feq=fequ;
end
Freal=fequ/14.7;


r21=s1/2;
vd=pi*b1^2/4*s1/1000;
%vd=600;

% ******************************************************
% *   QANG : ESCRITURA DE FICHEROS (SI=1,NO=resto)     *
% ******************************************************
QANG=1;
ORIG=0;

%% Llamada al programa
s=s1/1000;
b=b1/1000;
dcb=round(60*b/s);
r2=s/2;
pa=pa1*100000;
qr=vd/1000000;
rendc=0.75;
rendt=0.8;
aicb=-18;
gammac=1.4;
gammat=1.28;
Tescape=1500;

Avalv_a=0.4*pi*b^2/4;
Avalv_e=0.3*pi*b^2/4;
dcb=round(dcb1*b/s);

for i=1:20
    pit=(1-1/(1+Freal)*298/Tescape/rendc/rendt*(pa1^((gammac-1)/gammac)-1))^(gammat/(gammat-1))
    pe=1/pit*100000;

    princotto

    Tescape1=APTV(630,3);
    if abs(Tescape1-Tescape)<1 
        break
    end
    Tescape=Tescape1;
end

      FMEP=1.2*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2); %Presión media de fricción en bar
      IMEP=Trabajo/vd*10;  % PMI en bar
      ETAM=(IMEP-FMEP)/IMEP;
      BMEP=ETAM*IMEP;
      Pow=BMEP*ncil*vd/10*rpm/120/1000 %Potencia al freno en kW 
      Rend_e=Rend*ETAM;
      BSFC=3600000000/Rend_e/Li  %BSFC en g/kWh
      Par=BMEP*ncil*vd/10/4/pi
      %Cálculo detonación
 Pdet=0;
 gamma=1.3;
 ide=180+rca;
 tret1=0.01869*(95/100)^3.4017*APTV(ide+1,2)^-1.7*exp(3800/APTV(ide+1,3));
 
  for ide=180+rca+1:360-aicb
      p=APTV(ide+1,2);
      T=APTV(ide+1,3);
      tret2=0.01869*(95/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end
    
  for ide=360-aicb+1:360-aicb+dcb
      p=APTV(ide+1,2);
      T=T2*(p*100000/P2)^((gamma-1)/gamma);
      tret2=0.01869*(95/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end

  Pdet=Pdet/wrpm
%   Rend_vol=Masa_adm/rhoa/vd*1000000    

ga=Masa_adm*ncil*rpm/120;
gc=Freal*ga;
gt=(ga+gc)

Aturbina=gt*sqrt(RG*Tescape/gammat)/pe/sqrt(2/(gammat-1)*(pit^(2/gammat)-pit^((gammat+1)/gammat)))
pa
pe

PotC=ga*1000*298*((pa1^((gammac-1)/gammac)-1))/rendc
PotT=gt*1000*Tescape*rendt*(1-pit^((gammat-1)/gammat))


