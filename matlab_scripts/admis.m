% Proceso de admisión considerando gas ideal con gamma y R igual a los del
% gas fresco

%% Condiciones iniciales

    disp('          *****     ADMISION    *****')
    
    CD=0.6; %coeficiente descarga
   
    intervalo=1;
    npuntos=10;
    dtheta=intervalo/npuntos;
    dt=dtheta/(6*rpm) ;

    Trabajo_adm=0;
    Masa_adm=0;
    Hin=0;
    
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
     APTV(1,5)=0;
     APTV(1,6)=0;


       if (QANG==1)&&(CLAVE==1)  
     fprintf(APTVsal,'%-5.1f %-8.3f %-7.2f %-9.4f %-9.4f %-9.4f \r',APTV(1,1:6));   

       end  


%% Cálculos
 for ang=0:intervalo:(179+rca)
   
     for i=1 : npuntos   
         theta=ang+i*dtheta;
         pant=pcil;
         L1L2=L1L2adm(theta,0,rca);
         Av=Avalv_a*L1L2*2.4;
         [machg,gastoa]=gasto(pa,rhoa,Av,pcil,rhocil,gamma);
 
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
         
         dhin=gastoa*cp*tinterf*dt;
         dtrab=(pcil+pant)/2*dvcil;
         Trabajo_adm=Trabajo_adm+(pcil+pant)/2*dvcil;
         Masa_adm=Masa_adm+gastoa*dt;
         Hin=Hin+dhin;
         Uint=mcil*cv*tcil;
     end
     
     ind=round(theta+1);
     APTV(ind,1)=theta;
     APTV(ind,2)=pcil/100000;
     APTV(ind,3)=tcil;
     APTV(ind,4)=vcil*1000;
     APTV(ind,5)=gastoa*1000;
     APTV(ind,6)=machg;%Av*10000;%machg;
     
     if (QANG==1)&&(CLAVE==1)   
     fprintf(APTVsal,'%-5.1f %-8.3f %-7.2f %-9.4f %-9.4f %-9.4f \r',APTV(ind,1:6));   
   end  
 end

T1P=tcil;
P1P=pcil;
V1P=V(r2,b,lambda,vpms,180+rca);


    MT=mcil;
H1P=MT*cp*T1P;
U1P=MT*cv*T1P;
    