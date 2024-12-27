%% Cabecera

 disp('**************************************************')
 disp('*      MODELO COMPLETO CUATRO TIEMPOS            *')
 disp('*                 VERSIÓN 1.00                   *')
 disp('**************************************************')

if QANG==1
    datasal=fopen('data.sal','w');
    APTVsal=fopen('aptv.sal','w');
end

QPTR=0;
QDISP=0;
Q1=1;
APTV=zeros(721,6);
cw=1;

%% Operaciones 

pres=pe;
vpmi=rg*qr/(rg-1);
vpms=vpmi/rg;
wrpm=rpm*pi/30;   
v1=V(r2,b,lambda,vpms,180+rca);
vaae=V(r2,b,lambda,vpms,540-aae);
rc=v1/vpms;
dt=1/6/rpm; %Dtheta es 1 grado

if (fequ>1.03)
    feq=1.03; %poder calorífico liberado
else
    feq=fequ;
end

RU=8.314472; % RU en J/mol/K
RT=0.08205746; % RT en atm*l/mol/k
Freal=fequ/14.7;
MM=(1+Freal)/(1/28.9+Freal/114)/1000;  
RG=RU/MM;
Li=4.419E07; %en J/kg

maxiter=20000;
eps=1e-6;    
eps2=1e-6;
    
disp(' ')
disp(' ')
disp('     *****  COMIENZO DE LOS CÁLCULOS  *****')
disp(' ')
disp(' ')

%Velocidad Media del émbolo
Up=rpm*s/30;

%Valor incicial de la temperatura al final de escape
Te=1000;
%    ***** COMIENZO DE LAS ITERACIONES      *****
 
ITERA=0;
CLAVE=0;
if miter==1
  CLAVE=1;
end

for it=1:maxiter
   ITERA=ITERA+1;
   if ORIG==0
       disp(' ')
       disp(['ITERACIÓN= ',num2str(ITERA)])
       disp(' ')
   else
       set(handles.text27,'string',num2str(ITERA));
       pause(0)
   end

  
    hgm=0;
    Tgm=0;
  
%     ***** PROCESO DE ADMISION. PUNTO 1'    *****
    gamma=gamma1;  
    admis

    if ORIG==0
        disp(['T1=',num2str(T1P),' K         P1=',num2str(P1P/100000),' bar'])
        disp(['H1=',num2str(H1P),' J         U1=',num2str(U1P),' J'])
        disp(['WAd=',num2str(Trabajo_adm),' J']);
        disp(['Hin=',num2str(Hin),' J']);
        disp(['Masa=',num2str(1000*MT),' g']);
    end
    
     if (QANG==1)&&(CLAVE==1)
        fprintf(datasal,'  \n'); 
        fprintf(datasal,'  ADMISIÓN: \n');
        fprintf(datasal,'T1P= %-9.2f K         P1P= %-9.2f bar\n',T1P,P1P/100000); 
        fprintf(datasal,'H1P= %-9.2f J         U1P= %-9.2f J\n',H1P,U1P); 
        fprintf(datasal,'Wadm= %-9.2f J\n',Trabajo_adm);
        fprintf(datasal,'Hin= %-9.2f J\n',Hin);
        fprintf(datasal,'Masa= %-9.4f g\n',1000*MT);
    end
   

% **********************************************************************      
%   HGM Y TGM EN EL PROCESO DE ADMISIàN
    
    V2=0;
    P2=0;
    C1=6.18;
    C2=0;
    Vol=vpmi;
    [qw,hg]=calor(P1P,T1P,b,Up,C1,C2,gamma,Vol,P1P,V1P,T1P,P2,V2,Tw,cw);
    hgm=hgm+hg*(180+rca);
    Tgm=Tgm+hg*T1P*(180+rca);
    disp(' ')
    
    compres

    if ORIG==0
   
       disp(['T2=',num2str(T2),' K         P2=',num2str(P2/100000),' bar']);
       disp(['H2=',num2str(H2),' J         U2=',num2str(U2),' J']);
       disp(['WC=',num2str(Trabajo_comp),' J         QC=',num2str(Q_comp),' J']);
    end
   
     if (QANG==1)&&(CLAVE==1)
        
        fprintf(datasal,'  \n'); 
        fprintf(datasal,'  COMPRESIÓN: \n'); 
        fprintf(datasal,'T2= %-9.2f K         P2= %-9.2f bar\n',T2,P2/100000); 
        fprintf(datasal,'H2= %-9.2f J         U2= %-9.2f J\n',H2,U2); 
        fprintf(datasal,'WC= %-9.2f J         QC= %-9.2f J\n',Trabajo_comp,Q_comp); 
        
     end

     gamma=gamma2;  

    comb
    

    if ORIG==0
        disp(['T3=',num2str(T3),' K         P3=',num2str(P3/100000),' bar'])
        disp(['H3=',num2str(H3),' J         U3=',num2str(U3),' J'])
        disp(['WCB=',num2str(Trabajo_comb),' J         QCB=',num2str(Q_comb),' J'])
    disp(' ')
 
        disp(['T4=',num2str(T4),' K         P4=',num2str(P4/100000),' bar'])
        disp(['H4=',num2str(H4),' J         U3=',num2str(U4),' J'])
        disp(['WEX=',num2str(Trabajo_exp),' J         Qex=',num2str(Q_exp),' J'])
    
    end

    if (QANG==1)&&(CLAVE==1)
        
        fprintf(datasal,'  \n'); 
        fprintf(datasal,'  COMBUSTIÓN: \n'); 
        fprintf(datasal,'T3= %-9.2f K         P3= %-9.2f bar\n',T3,P3/100000); 
        fprintf(datasal,'H3= %-9.2f J         U3= %-9.2f J\n',H3,U3); 
        fprintf(datasal,'WComb= %-9.2f J      QComb= %-9.2f J\n',Trabajo_comb,Q_comb); 

        fprintf(datasal,'  \n'); 
        fprintf(datasal,'  EXPANSIÓN: \n'); 
        fprintf(datasal,'T4= %-9.2f K         P4= %-9.2f bar\n',T4,P4/100000); 
        fprintf(datasal,'H4= %-9.2f J         U4= %-9.2f J\n',H4,U4); 
        fprintf(datasal,'Wexp= %-9.2f J       Qexp= %-9.2f J\n',Trabajo_exp,Q_exp); 

    end         

escape    

    if ORIG==0
        disp(['T5=',num2str(T5),' K         P1=',num2str(P5/100000),' bar'])
        disp(['H5=',num2str(H5),' J         U1=',num2str(U5),' J'])
        disp(['Wesc=',num2str(Trabajo_esc),' J']);
        disp(['Hout=',num2str(-Hout),' J']);
    end
    
     if (QANG==1)&&(CLAVE==1)
        fprintf(datasal,'  \n'); 
        fprintf(datasal,'  ESCAPE: \n');
        fprintf(datasal,'T5= %-9.2f K         P5= %-9.2f bar\n',T5,P5/100000); 
        fprintf(datasal,'H5= %-9.2f J         U5= %-9.2f J\n',H5,U5); 
        fprintf(datasal,'Wesc= %-9.2f J\n',Trabajo_esc);
        fprintf(datasal,'Hout= %-9.2f J\n',-Hout);
    end
    


Trabajo=(Trabajo_adm+Trabajo_comp+Trabajo_comb+Trabajo_exp+Trabajo_esc);
Calor=Q_comp+Q_comb+Q_exp;
Hesc=-round(Hout*10)/10;
Hadm=round(Hin*10)/10;
QTx=round(QTotal*(1-exp(-a))*10)/10;
Rend=Trabajo/QTotal*feq/fequ;

   if ORIG==0
       disp(' ')
       disp(['Trabajo de Ciclo= ',num2str(Trabajo),'  J'])
       disp(' ')
   else
       set(handles.text30,'string',[num2str(Trabajo),' J']);
       set(handles.text32,'string',[num2str(Calor),' J']);
       set(handles.text42,'string',[num2str(Hesc),' J']);
       set(handles.text43,'string',[num2str(Hadm),' J']);
       set(handles.text45,'string',[num2str(QTx),' J']);
       set(handles.text35,'string',[num2str(round(Te)),' K']);
       set(handles.text39,'string',[num2str(round(T5)),' K']);
       pause(0)
   end



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

if QANG==1
    fprintf(datasal,'  \n');
    fprintf(datasal,'Trabajo realizado %-9.2f J\n',Trabajo);
    fprintf(datasal,'Calor cedido    %-9.2f J\n',Calor);
    
    fclose(datasal);
    fclose(APTVsal);
end

