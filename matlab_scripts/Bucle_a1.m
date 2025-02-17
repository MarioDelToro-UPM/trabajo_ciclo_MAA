clear

s1=111;
b1=130;
lambda=0.25;
rg=8.5;
rca=30;
aae=40;
aicb=10;
dcb1=50;
rpm=2700;
pe1=1;
Ta=300;
pa1=1;
fequ=1.2;
Tw=500;
a=5;
n=3;
NO=95;
gamma1=1.3;
gamma2=1.3;
miter=3;
ncil=4;% 

r21=s1/2;
vd=3.1415927*b1^2/4*s1/1000;


% ******************************************************
% *   QANG : ESCRITURA DE FICHEROS (SI=1,NO=resto)     *
% ******************************************************
QANG=1;
ORIG=0;

%% Llamada al programa

jjj=0;

   s=s1/1000;
   b=(4*vd/s/100/pi)^(1/2)/100;
   r2=s/2;
   lb=2*s;

   Avalv_a=0.35*pi*b^2/4;
   Avalv_e=0.25*pi*b^2/4;
   dcb=round(dcb1*b/s);

for rca=30:10:80
 
 iii=0;
 jjj=jjj+1;  
 for rpm=1000:1000:6000
     

 iii=iii+1;
  
 pa=pa1*100000;
 pe=pe1*100000;
 qr=vd/1000000;

  princotto

  %Estimaci�n de p�rdidas por rozamiento sin bombeo

      FMEP=1*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2); %Presi�n media de fricci�n en bar
      IMEP=Trabajo/vd*10;  % PMI en bar
      ETAM=(IMEP-FMEP)/IMEP;
      BMEP=ETAM*IMEP;
      Pow=BMEP*ncil*vd/10*rpm/120/1000; %Potencia al freno en kW para 4 cilindros
      Par=BMEP*ncil*vd/4/pi/10;   %Par motor en Nm
      Rend_e=Rend*ETAM;
      BSFC=3600000000/Rend_e/Li;  %BSFC en g/kWh

  %C�lculo detonaci�n
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


  Pdet=Pdet/wrpm;
  Rend_vol=Masa_adm/(1+fequ/14.7)/(pa/287/Ta)/vd*1000000

  gasto_aire=ncil*Masa_adm/(1+fequ/14.7)*rpm/120;
  gasto_comb=fequ/14.7*gasto_aire;
      
 VEC(1,jjj,iii)=rpm;
 VEC(2,jjj,iii)=BMEP;%3600000/Li/Rend_e;
 VEC(3,jjj,iii)=Pow;
 VEC(4,jjj,iii)=BSFC;
 VEC(5,jjj,iii)=Pdet; 

  end
end

plot_VEC
