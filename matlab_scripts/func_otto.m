function [Pow, Pdet] = func_otto(s1, rca, aae, aicb, pm)
% Initial operations
rpm = pm.rpm;
lambda = pm.lambda;
Ta = pm.Ta;
Tw = pm.Tw;
dcb = pm.dcb;
a = pm.a;
n = pm.n;
NO = pm.NO;
miter = pm.miter;
vd = pm.vd;
s=s1/1000;
b=sqrt(4*vd/(pi*1000*s1));
r2=s/2;
pa = pm.pa1*100000;
pe = pm.pe1*100000;
pres = pe;
qr=vd/1000000;
vpmi=pm.rg*qr/(pm.rg-1);
vpms=vpmi/pm.rg;
wrpm=rpm*pi/30;   
Avalv_a=0.4*pi*b^2/4;
Avalv_e=0.3*pi*b^2/4;
cw=1;
fequ= 1.2; %poder calorífico liberado
feq = 1.03;

RU=8.314472; % RU en J/mol/K
Freal=fequ/14.7;
MM=(1+Freal)/(1/28.9+Freal/114)/1000;  
RG=RU/MM;
Li=4.419E07; %en J/kg

maxiter=20000;
    
%Velocidad Media del émbolo
Up=rpm*s/30;

%Valor incicial de la temperatura al final de escape
Te=1000;

APTV=zeros(721,4);

ITERA=0;

CLAVE=0;
if miter==1
  CLAVE=1;
end

for it=1:maxiter
    ITERA=ITERA+1;
    %disp(['ITERACIÓN= ',num2str(ITERA)])
  
    gamma=pm.gamma1;  
    
    % Admision
    intervalo=1;
    npuntos=10;
    dtheta=intervalo/npuntos;
    dt=dtheta/(6*rpm) ;

    Trabajo_adm=0;
    Masa_adm=0;
    
    vcil=V(r2,b,lambda,vpms,0); %Volumen inicial Angulo en radianes
    tcil=Te;
    pcil=pres;
    rhocil=pcil/RG/tcil;
    rhoa=pa/RG/Ta;
    mcil=rhocil*vcil;
 
    cp=RG*gamma/(gamma-1);
    cv=cp/gamma;
    
     APTV(1,1)=0;
     APTV(1,2)=pcil/100000;
     APTV(1,3)=tcil;
     APTV(1,4)=vcil*1000;

     for ang=0:intervalo:(179+rca)
         for i=1 : npuntos   
             theta=ang+i*dtheta;
             pant=pcil;
             L1L2=L1L2adm(theta,0,rca);
             Av=Avalv_a*L1L2*2.4;
             [~,gastoa]=gasto(pa,rhoa,Av,pcil,rhocil,gamma);
     
             vcil0=vcil;
             vcil=V(r2,b,lambda,vpms,theta);
             dvcil=vcil-vcil0;  
             mcil0=mcil;
	         mct0=mcil*cv*tcil;
             mcil=mcil0+gastoa*dt;
    
             if (gastoa>=0)
                 tinterf=Ta;
             else
                 tinterf=tcil;
             end
    
             mct=mct0-pcil*dvcil+gastoa*cp*tinterf*dt;          
             tcil0=mct/mcil/cv;         
             pcil0=mcil*RG*tcil0/vcil;         
             mct=mct0-(pcil0+pant)/2*dvcil+gastoa*cp*tinterf*dt;         
             tcil=mct/mcil/cv;
             pcil=mcil*RG*tcil/vcil;         
             rhocil=mcil/vcil;
             
             Trabajo_adm=Trabajo_adm+(pcil+pant)/2*dvcil;
             Masa_adm=Masa_adm+gastoa*dt;
         end
         
         ind=round(theta+1);
         APTV(ind,1)=theta;
         APTV(ind,2)=pcil/100000;
         APTV(ind,3)=tcil;
         APTV(ind,4)=vcil*1000;
     end

    T1P=tcil;
    P1P=pcil;
    V1P=V(r2,b,lambda,vpms,180+rca);
    MT=mcil;
    V2=0;
    P2=0;

    % Compresion
    Trabajo_comp=0;
    Q_comp=0;
    Tcil=T1P;
    Pcil=P1P;
    Pant=Pcil;
    vcil=V1P;
    vant=vcil;
    theta0=rca+180+1;
    theta2=360-aicb;
    dt=1/(6*rpm) ;
    
   
    for theta=theta0:theta2
    
        C1=2.28;
        C2=0;
        [qw,~]=calor(Pcil,Tcil,b,Up,C1,C2,gamma,vcil,P1P,qr/V1P,T1P,P2,V2,Tw,cw);
    
        vcil=V(r2,b,lambda,vpms,theta);    
        DT1=(-qw*dt-Pcil*(vcil-vant))/(MT*cv);
        T1=Tcil+DT1;
        RO=MT/vcil;
        P1=RO*RG*T1;
    
        DT2=(-qw*dt-P1*(vcil-vant))/(MT*cv);
        Tcil=Tcil+(DT1+DT2)/2;
        Pcil=RO*Tcil*RG;
        
        ind=round(theta+1);
        APTV(ind,1)=theta;
        APTV(ind,2)=Pcil/100000;
        APTV(ind,3)=Tcil;
        APTV(ind,4)=vcil*1000;
            
        INCV=(vcil-vant);
        Q_comp=Q_comp+qw*dt;
        Trabajo_comp=Trabajo_comp+(Pcil+Pant)/2*INCV;
        
        Pant=Pcil;
        vant=vcil;
    
    end
      
    T2=Tcil;
    P2=Pcil;
    V2=vcil;

    gamma=pm.gamma2;  

    % Combustion
    Freal=feq/14.7;
    %QTotal=Li*Freal/(1+Freal)*MT;
    QTotal=Li*Freal/(1+Freal)*Masa_adm;
   
    %masas molares 

    theta2=360-aicb;
    theta3=360-aicb+dcb;
    theta4=540-aae;
    dtheta=1; %un grado  
    dt=1/(6*rpm) ;

    cp=RG*gamma/(gamma-1);
    cv=cp/gamma;


    %Valor inical de variables    
    Trabajo_comb=0;
    Trabajo_exp=0;
    Q_comb=0;
    Q_exp=0;
       
    Tcil=T2;
  
    P0=P2;
    Pcil=P0;  
    V0=V2;
    
    X0=0;
 
    for theta=theta2+1:dtheta:theta4
        Vcil=V(r2,b,lambda,vpms,theta);    
        if theta<=theta3
        X1=X(a,n,theta2,dcb,theta);
        end
       
        C1=2.28;
        if theta<=theta3 
            C2=0.00324;
        else
            C2=0;
        end
        [qw,~]=calor(Pcil,Tcil,b,Up,C1,C2,gamma,Vcil,P1P,qr/V1P,T1P,P2,V2,Tw,cw);
    
        DT1=(-qw*dt-Pcil*(Vcil-V0)+QTotal*(X1-X0))/(MT*cv);
        T1=Tcil+DT1;
        RO=MT/Vcil;
        P1=RO*RG*T1;
        
        DT2=(-qw*dt-P1*(Vcil-V0)+QTotal*(X1-X0))/(MT*cv);
        Tcil0=Tcil+(DT1+DT2)/2;
        Pcil0=RO*Tcil0*RG;
        
        DT=(-qw*dt-(Pcil+Pcil0)/2*(Vcil-V0)+QTotal*(X1-X0))/(MT*cv);
        Tcil=Tcil+DT;
        Pcil=RO*Tcil*RG;
        
        ind=round(theta+1);
        APTV(ind,1)=theta;
        APTV(ind,2)=Pcil/100000;
        APTV(ind,3)=Tcil;
        APTV(ind,4)=Vcil*1000;
        APTV(ind,5)=0;
        APTV(ind,6)=0;
        
        DWT=(Pcil+P0)/2*(Vcil-V0);
        
        if theta<=theta3
         Trabajo_comb=Trabajo_comb+DWT;
         Q_comb=Q_comb+qw*dtheta/6/rpm;
        else
         Trabajo_exp=Trabajo_exp+DWT;
         Q_exp=Q_exp+qw*dtheta/6/rpm;
        end
        
        
        P0=Pcil;
        X0=X1;
        V0=Vcil;

    end
    T4=APTV(theta4+1,3);
    P4=APTV(theta4+1,2)*1E5;
    
    %% Escape
    intervalo=1;
    npuntos=10;
    dtheta=intervalo/npuntos;
    dt=dtheta/(6*rpm) ;

    Trabajo_esc=0;
    Masa_esc=0;
    
    vcil=V(r2,b,lambda,vpms,theta4); %Volumen inicial Angulo en radianes
    tcil=T4;
    pcil=P4;
    rhocil=pcil/RG/tcil;
    rhoe=pe/RG/T4;
    mcil=rhocil*vcil;    
        
     for ang=theta4:intervalo:719
       
         for i=1 : npuntos   
             theta=ang+i*dtheta;
             pant=pcil;
             L1L2=L1L2esc(theta,aae,0);
             Av=Avalv_e*L1L2*2.6;       
             [~,gastoe]=gasto(pcil,rhocil,Av,pe,rhoe,gamma);
     
             vcil0=vcil;
             vcil=V(r2,b,lambda,vpms,theta);
             dvcil=vcil-vcil0;  
             mcil0=mcil;
	         mct0=mcil*cv*tcil;
             mcil=mcil0-gastoe*dt;
             tinterf=tcil;
             mct=mct0-pcil*dvcil-gastoe*cp*tinterf*dt;          
             tcil0=mct/mcil/cv;         
             pcil0=mcil*RG*tcil0/vcil;         
             mct=mct0-(pcil0+pant)/2*dvcil-gastoe*cp*tinterf*dt;         
             tcil=mct/mcil/cv;
             pcil=mcil*RG*tcil/vcil;         
             rhocil=mcil/vcil;
             
             Trabajo_esc=Trabajo_esc+(pcil+pant)/2*dvcil;
             Masa_esc=Masa_esc-gastoe*dt;
         end
         ind=round(theta+1);
         APTV(ind,1)=theta;
         APTV(ind,2)=pcil/100000;
         APTV(ind,3)=tcil;
         APTV(ind,4)=vcil*1000;
         T5=tcil;
         P5=pcil;
     end
    

    %%
    Trabajo=(Trabajo_adm+Trabajo_comp+Trabajo_comb+Trabajo_exp+Trabajo_esc);

    if it==miter-1
        Te=T5;
        pres=P5;
        CLAVE=1;
    else
        if (abs(Te-T5)>20)&&(CLAVE==0)
            Te=T5;
            pres=P5;
        elseif CLAVE==0
            Te=T5;
            pres=P5;
            CLAVE=1;
        else
            break;
        end
    end
end

FMEP=1*(0.97+0.8*(Up/17.2)+0.6*(Up/17.2)^2); %Presión media de fricción en bar
IMEP=Trabajo/vd*10;  % PMI en bar
ETAM=(IMEP-FMEP)/IMEP;
BMEP=ETAM*IMEP;
Pow=BMEP*pm.ncil*vd/10*rpm/120/1000; %Potencia al freno en kW 

% Calculo detonacion
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

Pdet = Pdet/wrpm;

end