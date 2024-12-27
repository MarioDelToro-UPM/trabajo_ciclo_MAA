%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%     DIN�TICA DEL MOTOR      %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% DATOS DE OTTO
F1=zeros(721,1);
 
 for v=1:721
    
 F1(v,1)=-(APTV(v,2)-0)*100000*pi*b^2/4; %[N]
 
 end
 %% SISTEMA DEL P�NDULO PARA HALLAR LA INERCIA DE LA BIELA
% m1=229/1000; % Masa del �mbolo [kg]
% m3=294/1000; % Masa del �mbolo [kg]
%I_pe=m3*(0.85*r3*(1-delta)*r3-(1-delta)^2*r3^2); % Sistema del p�ndulo
I_pe=0.01;
m3=0.56;
m1=0.9;
%%  OBTENCI�N DEL PAR MOTOR Y PAR MOTOR TOTAL
T2_motor=(1/w2)*(transpose(-F1).*r1_punto+I_pe.*alpha3.*w3+m3*r3x_cdg_punto_punto.*r3x_cdg_punto+m3*r3y_cdg_punto_punto.*r3y_cdg_punto+m1*r1_punto.*r1_punto_punto); 

T2_tot(1:90)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720); % 8 cilindros
T2_tot(91:180)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(181:270)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(271:360)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(361:450)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(451:540)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(541:630)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(631:720)=T2_motor(1:90)+T2_motor(91:180)+T2_motor(181:270)+T2_motor(271:360)+T2_motor(361:450)+T2_motor(451:540)+T2_motor(541:630)+T2_motor(631:720);
T2_tot(721)=T2_tot(1);

%% REPRESENTACI�N GR�FICA

figure
plot(theta2,F1)
title('Fuerza de los gases [N] en funci�n de \theta_2 [�]','fontweight','bold','fontsize',16)
xlabel('\theta_2 [�]','fontweight','bold','fontsize',16)
ylabel('F_1 [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,-T2_motor)
title('Evaluaci�n del par motor en funci�n de \theta_2 [�]','fontweight','bold','fontsize',16)
xlabel('\theta_2 [�]','fontweight','bold','fontsize',16)
ylabel('-T_2 [Nm]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,-T2_tot)
title('Par motor para 8 cilindros en funci�n de \theta_2 [�]','fontweight','bold','fontsize',16)
xlabel('\theta_2 [�]','fontweight','bold','fontsize',16)
ylabel('-T_2 [Nm]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor