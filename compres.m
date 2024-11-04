% ***********************************************************************
%     VAR.INTERNAS :
%            D  : Calibre del ‚mbolo (dm)
%            L : Carrera del ‚mbolo (dm)
%     VAR.SALIDA :
%            PY(atm),TY(K),UY(J),HY(J):valores al inicio de inyecci¢n
%            QCOMP  : calor total transferido en compresi¢n (J)
%            WCP    : trabajo realizado en compresi¢n (J)
% ***********************************************************************

%     INICIALIZACION

Trabajo_comp=0;
Q_comp=0;
Tcil=T1P;
Pcil=P1P;
Pant=Pcil;
vcil=V1P;
vant=vcil;
theta0=rca+180+1;
theta2=360-aicb;
INCAL=1;
dt=1/(6*rpm) ;



% EN CADA PASO DEL BUCLE SE CALCULA Tcil,LA TEMPERATURA EN EL PUNTO
% theta

disp('          *****   COMPRESION    *****')

for theta=theta0:theta2

    C1=2.28;
    C2=0;
    [qw,hg]=calor(Pcil,Tcil,b,Up,C1,C2,gamma,vcil,P1P,qr/V1P,T1P,P2,V2,Tw,cw);

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
     APTV(ind,5)=0;
     APTV(ind,6)=0;
 
  
    if (QANG==1)&&(CLAVE==1)
     fprintf(APTVsal,'%-5.1f %-8.3f %-7.2f %-9.4f %-9.4f %-9.4f \r',APTV(ind,1:6));   
    end
        
    INCV=(vcil-vant);
    Q_comp=Q_comp+qw*dt;
    Trabajo_comp=Trabajo_comp+(Pcil+Pant)/2*INCV;
    hgm=hgm+hg;
    Tgm=Tgm+hg*Tcil;
    
    Pant=Pcil;
    Tant=Tcil;
    vant=vcil;

end

%***************************************************************
  
T2=Tcil;
P2=Pcil;
V2=vcil;
H2=MT*cp*T2;
U2=MT*cv*T2;
