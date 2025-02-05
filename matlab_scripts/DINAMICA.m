%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%     DINÁTICA DEL MOTOR      %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% DATOS DE OTTO
F1=zeros(721,1);
 
 for v=1:721
    
    F1(v,1)=-(APTV(v,2)-0)*100000*pi*b^2/4; %[N]
 
 end
 %% SISTEMA DEL PÉNDULO PARA HALLAR LA INERCIA DE LA BIELA
% m1=229/1000; % Masa del émbolo [kg]
% m3=294/1000; % Masa del émbolo [kg]
%I_pe=m3*(0.85*r3*(1-delta)*r3-(1-delta)^2*r3^2); % Sistema del péndulo
I_pe=I3;
%%  OBTENCIÓN DEL PAR MOTOR Y PAR MOTOR TOTAL
w2 = wrpm;
r1_punto = v1;
r1_punto_punto = a1;
alpha3 = a3;
r3x_cdg_punto = v3gx;
r3y_cdg_punto = v3gy;
r3x_cdg_punto_punto = a3gx;
r3y_cdg_punto_punto = a3gy;
T2_motor=(1/w2)*((-F1).*r1_punto+I_pe.*alpha3.*w3+m3*r3x_cdg_punto_punto.*r3x_cdg_punto+m3*r3y_cdg_punto_punto.*r3y_cdg_punto+m1*r1_punto.*r1_punto_punto); 

T2_tot(1:120)=T2_motor(1:120)+T2_motor(121:240)+T2_motor(241:360)+T2_motor(361:480)+T2_motor(481:600)+T2_motor(601:720); % 6 cilindros
T2_tot(121:720)= [T2_tot(1:120) T2_tot(1:120) T2_tot(1:120) T2_tot(1:120) T2_tot(1:120)];
T2_tot(721)=T2_tot(1);

%% REPRESENTACIÓN GRÁFICA

figure
plot(theta2,F1)
title('Fuerza de los gases [N] en función de \theta_2 [°]','fontweight','bold','fontsize',16)
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_1 [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,-T2_motor)
title('Evaluación del par motor en función de \theta_2 [°]','fontweight','bold','fontsize',16)
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('-T_2 [Nm]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,-T2_tot)
title('Par motor para 6 cilindros en función de \theta_2 [°]','fontweight','bold','fontsize',16)
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('-T_2 [Nm]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor