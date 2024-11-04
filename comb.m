
%% Condiciones iniciales

    disp('          *****   COMBUSTIÓN   *****')
    
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
    WR0=0;
    QWR0=0;
    HOUTR0=0;
    WT0=0;
    QWT0=0;
    Trabajo_comb=0;
    Trabajo_exp=0;
    Q_comb=0;
    Q_exp=0;
       
    Tcil=T2;
  
    P0=P2;
    T0=T2;
    Pcil=P0;  
    V0=V2;
    
    X0=0;
 
for theta=theta2+1:dtheta:theta4
    %set(handles.ang, 'string', [num2str(theta),'º'])
 %   handles.angulo=theta;
 %   guidata(hObject,handles);  
 %   set(handles.mass, 'String', [num2str(theta),'º'])
    flag=0;
    if ORIG==0
     %   disp(theta)
    else
        set(handles.text25,'string',num2str(theta));
    end
    pause(0)
    theta0=theta-dtheta;
    Vcil=V(r2,b,lambda,vpms,theta);    
   
 %   X0=X(a,n,theta2,dcb,theta0);
   if theta<=theta3
    X1=X(a,n,theta2,dcb,theta);
   end
   
   
    C1=2.28;
    if theta<=theta3 
        C2=0.00324;
    else
        C2=0;
    end
     [qw,hg]=calor(Pcil,Tcil,b,Up,C1,C2,gamma,Vcil,P1P,qr/V1P,T1P,P2,V2,Tw,cw);

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

    if (QANG==1)&&(CLAVE==1)
     fprintf(APTVsal,'%-5.1f %-8.3f %-7.2f %-9.4f %-9.4f %-9.4f \r',APTV(theta+1,1:6));   
    end

    Uant=MT*cv*T0;
    DQ=qw*dt;
    Qlib=QTotal*(X1-X0);
    Uact=MT*cv*Tcil;
    Uprev=Uant-DQ-DWT+Qlib;
    
P0=Pcil;
T0=Tcil;
X0=X1;
V0=Vcil;

% if theta==theta3
%   U3=MT*cv*Tcil;
%   H3=U3+Pcil*Vcil;
% end
U3=0;
H3=0;
end

  U4=MT*cv*Tcil;
  H4=U4+Pcil*Vcil;


T3=APTV(theta3+1,3);
P3=APTV(theta3+1,2)*1E5;
T4=APTV(theta4+1,3);
P4=APTV(theta4+1,2)*1E5;