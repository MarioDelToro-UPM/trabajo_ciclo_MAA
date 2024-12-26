clear

s1=62;
b1=101;
lambda=0.3;
rg=9.5;
rca=30;
aae=40;
aicb=10;
dcb1=40;
rpm=1000;
Ta=300;
TURBO = 0;
fequ=1.2;
Tw=500;
a=5.4;
n=3;
NO=100;
gamma1=1.3;
gamma2=1.3;
miter=3;
ncil=6;

if TURBO == 1
    pa1=3;
    pe1=0.8*pa1;
else 
    pa1=1;
    pe1=1;
end

%r21=s1/2;
%vd=3.1415927*b1^2/4*s1/1000;
vd=3000/ncil;

% ******************************************************
% *   QANG : ESCRITURA DE FICHEROS (SI=1,NO=resto)     *
% ******************************************************
QANG=1;
ORIG=0;

%% Llamada al programa

jjj=0;
 
for pav=0.2:0.01:0.3

       s=s1/1000;
       b=b1/1000;
       r2=s/2;
       lb=2*s;
       dcb=round(dcb1*b/s);
       %aicb=round(0.4*dcb);
       Avalv_a=0.4*pi*b^2/4;
       Avalv_e=pav*pi*b^2/4;
   
 iii=0;
 jjj=jjj+1;  
 for rpm=1000:500:9000

 iii=iii+1;
  
 pa=pa1*100000;
 pe=pe1*100000;
 qr=vd/1000000;

  princotto

  %Estimación de pérdidas por rozamiento sin bombeo

      FMEP=1*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2); %Presión media de fricción en bar
      IMEP=Trabajo/vd*10;  % PMI en bar
      ETAM=(IMEP-FMEP)/IMEP;
      BMEP=ETAM*IMEP;
      Pow=BMEP*ncil*vd/10*rpm/120/1000; %Potencia al freno en kW para 4 cilindros
      Par=BMEP*ncil*vd/4/pi/10;   %Par motor en Nm
      Rend_e=Rend*ETAM;
      BSFC=3600000000/Rend_e/Li;  %BSFC en g/kWh

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

  Pdet=Pdet/wrpm;
  Rend_vol=Masa_adm/(1+fequ/14.7)/(pa/287/Ta)/vd*1000000

  gasto_aire=ncil*Masa_adm/(1+fequ/14.7)*rpm/120;
  gasto_comb=fequ/14.7*gasto_aire;
      
 VEC(1,jjj,iii)=rpm;
 VEC(2,jjj,iii)=BMEP;%3600000/Li/Rend_e;
 VEC(3,jjj,iii)=Pow;
 VEC(4,jjj,iii)=Par;
 VEC(5,jjj,iii)=Rend_vol;
 PelDet(jjj,iii)=Pdet;
 EXTRADATA(jjj)=aval;
  end
end

plot_VEC
