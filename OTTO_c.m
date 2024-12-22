
clear


s1=60;
b1=103;
lambda=0.3;
rg=7.5;
rca=30;
aae=40;
aicb=10;
dcb=40;
rpm=1000;
pa1=1;
Ta=300;
pe1=1;
fequ=1.2; %dosado equivalente, combustible quemado
Tw=500;
a=5.4;
n=3;
NO=100;
gamma1=1.3;
gamma2=1.3;
miter=3;
ncil=6;% 

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
%b=(4*vd/s/100/pi)^(1/2)/100;
b=b1/1000;
    %  dcb=round(50*b/s);
    %  aicb=round(0.4*dcb);

r2=s/2;

pa=pa1*100000;
pe=pe1*100000;
qr=vd/1000000;

Avalv_a=0.4*pi*b^2/4;
Avalv_e=0.3*pi*b^2/4;
%dcb=round(dcb1*b/s);
%aicb=round(dcb*.4);
princotto

%Estimación de pérdidas por rozamiento sin bombeo

      FMEP=1*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2) %Presión media de fricción en bar
      IMEP=Trabajo/vd*10  % PMI en bar
      ETAM=(IMEP-FMEP)/IMEP
      BMEP=ETAM*IMEP
      Pow=BMEP*ncil*vd/10*rpm/120/1000 %Potencia al freno en kW 
      Rend_e=Rend*ETAM
      BSFC=3600000000/Rend_e/Li  %BSFC en g/kWh
      Par=BMEP*ncil*vd/10/4/pi
      %Cálculo detonación
 Pdet=0;
 gamma=1.3;
 ide=180+rca;
 tret1=0.01806*(NO/100)^3.4017*APTV(ide+1,2)^-1.7*exp(3800/APTV(ide+1,3));
 
  for ide=180+rca+1:360-aicb
      p=APTV(ide+1,2);
      T=APTV(ide+1,3);
      tret2=0.01806*(NO/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end
    
  for ide=360-aicb+1:360-aicb+dcb
      p=APTV(ide+1,2);
      T=T2*(p*100000/P2)^((gamma-1)/gamma);
      tret2=0.01806*(NO/100)^3.4017*p^-1.7*exp(3800/T);
      Pdet=Pdet+(1/tret1+1/tret2)/2*pi/180;
      tret1=tret2;
  end

  Pdet=Pdet/wrpm
  Rend_vol=Masa_adm/(1+fequ/14.7)/(pa/287/Ta)/vd*1000000

  gasto_aire=ncil*Masa_adm/(1+fequ/14.7)*rpm/120;
  gasto_comb=fequ/14.7*gasto_aire*3600
  
save vars.mat APTV 

Pow
BSFC

plot_P_T
plot_P_V
plot_T_T
