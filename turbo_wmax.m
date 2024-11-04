rpm=1500;
pe1=1;
Ta=320;
pa1=2;
fequ=1.25;
if (fequ>1.03)
    feq=1.03;
else
    feq=fequ;
end
Freal=fequ/14.7;

QANG=1;
ORIG=0;

%% Llamada al programa
pa=pa1*100000;
rendc=0.75;
rendt=0.8;
aicb=-15;
gammac=1.4;
gammat=1.28;
Tescape=1500;
pit=0.5;
for i=1:10
    pe=1/pit*100000;
   
    pit=(1-1/(1+Freal)*298/Tescape/rendc/rendt*(pa1^((gammac-1)/gammac)-1))^(gammat/(gammat-1))

    princotto

    Tescape1=APTV(630,3);
    if abs(Tescape1-Tescape)<1 
        break
    end
    Tescape=Tescape1;
end

      FMEP=1*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2); %Presión media de fricción en bar
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
 tret1=0.01806*(98/100)^3.4017*APTV(ide+1,2)^-1.7*exp(3800/APTV(ide+1,3));
 
  for ide=180+rca+1:360-aicb
      p=APTV(ide+1,2);
      T=APTV(ide+1,3);
      tret2=0.01806*(95/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end
    
  for ide=360-aicb+1:360-aicb+dcb
      p=APTV(ide+1,2);
      T=T2*(p*100000/P2)^((gamma-1)/gamma);
      tret2=0.01806*(95/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end

  Pdet=Pdet/wrpm
  Rend_vol=Masa_adm/(1+fequ/14.7)/(pa/287/Ta)/vd*1000000

  gasto_aire=ncil*Masa_adm/(1+fequ/14.7)*rpm/120;
  gasto_comb=fequ/14.7*gasto_aire;

gt=(gasto_aire+gasto_comb);

Aturbina=gt*sqrt(RG*Tescape/gammat)/pe/sqrt(2/(gammat-1)*(pit^(2/gammat)-pit^((gammat+1)/gammat)))


