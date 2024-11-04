% Proceso de admisión considerando gas ideal con gamma y R igual a los del
% gas fresco

%% Condiciones iniciales

    disp('          *****     ESCAPE    *****')
    
    CD=0.7; %coeficiente descarga
   
    intervalo=1;
    npuntos=10;
    dtheta=intervalo/npuntos;
    dt=dtheta/(6*rpm) ;

    Trabajo_esc=0;
    Masa_esc=0;
    Hout=0;
    Uint=U4;
    
    vcil=V(r2,b,lambda,vpms,theta4); %Volumen inicial Angulo en radianes
    tcil=T4;
    pcil=P4;
    rhocil=pcil/RG/tcil;
    rhoe=pe/RG/T4;
    mcil=rhocil*vcil;    
    uyi=MT;
    
    
%% Cálculos
 for ang=theta4:intervalo:719
   
     for i=1 : npuntos   
         theta=ang+i*dtheta;
         pant=pcil;
         L1L2=L1L2esc(theta,aae,0);
         Av=Avalv_e*L1L2*2.6;       
         [machg,gastoe]=gasto(pcil,rhocil,Av,pe,rhoe,gamma);
 
         vcil0=vcil;
         vcil=V(r2,b,lambda,vpms,theta);
         dvcil=vcil-vcil0;  
         mcil0=mcil;
	     mct0=mcil*cv*tcil;
         mcil=mcil0-gastoe*dt;

         if (gastoe>=0)
             tinterf=tcil;
         else
             tinterf=tcil;
         end

         mct=mct0-pcil*dvcil-gastoe*cp*tinterf*dt;          
         tcil0=mct/mcil/cv;         
         pcil0=mcil*RG*tcil0/vcil;         
         mct=mct0-(pcil0+pant)/2*dvcil-gastoe*cp*tinterf*dt;         
         tcil=mct/mcil/cv;
         pcil=mcil*RG*tcil/vcil;         
         rhocil=mcil/vcil;
         
         Trabajo_esc=Trabajo_esc+(pcil+pant)/2*dvcil;
         Masa_esc=Masa_esc-gastoe*dt;
         Hout=Hout-gastoe*cp*tinterf*dt;
     end
    ind=round(theta+1);
     APTV(ind,1)=theta;
     APTV(ind,2)=pcil/100000;
     APTV(ind,3)=tcil;
     APTV(ind,4)=vcil*1000;
     APTV(ind,5)=gastoe*1000;
     APTV(ind,6)=machg;%Av*10000;%machg;%
 

   if (QANG==1)&&(CLAVE==1)  
     fprintf(APTVsal,'%-5.1f %-8.3f %-7.2f %-9.4f %-9.4f %-9.4f \r',APTV(ind,1:6));   
   end  
 end

T5=tcil;
P5=pcil;
V5=V(r2,b,lambda,vpms,180+rca);
U5=mcil*cv*tcil;
H5=U5+P5*V5;
    