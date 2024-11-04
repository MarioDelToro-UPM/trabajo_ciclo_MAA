%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  CARGAS EN LOS COMPONENTES DEL MOTOR      %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RESOLUCIÓN DEL SISTEMA DE ECUACIONES

one=-r3.*(1-delta)*(-sin(theta3_rad));
two=-r3.*(1-delta)*cos(theta3_rad);
three=r3*delta*(-sin(theta3_rad));
four=r3*delta*cos(theta3_rad);
 
Rax=zeros(1,721);
Ray=zeros(1,721);
Rbx=zeros(1,721);
Rby=zeros(1,721);
Fr=zeros(1,721);
 
for i=1:721
    
Carga=[1 0 0 0 0;0 1 0 0 1; -1 0 -1 0 0;0 -1 0 -1 0; one(1,i) two(1,i) three(1,i) four(1,i) 0];

p1=(m1*r1_punto_punto(1,i)-transpose(F1(i,1)));
p3=m3*r3x_cdg_punto_punto(1,i);
p4=m3*r3y_cdg_punto_punto(1,i);
p5=I_pe(1,1)*alpha3(1,i);

Indep=[p1; 0 ; p3; p4; p5];

x=Carga\Indep;
 
 Rax(1,i)=x(1,1);
 Ray(1,i)=x(2,1);
 Rbx(1,i)=x(3,1);
 Rby(1,i)=x(4,1);
 Fr(1,i)=x(5,1);

end

%% REACCIONES EN EL APOYO DEL CIGÜEÑAL

Rcx=Rax+m3*r3x_cdg_punto_punto;
Rcy=Ray+m3*r3y_cdg_punto_punto;

%% REPRESENTACIÓN GRÁFICA
figure
plot(theta2,Fr)
title('Fuerza lateral del émbolo','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northeast')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('Fr [N]','fontweight','bold','fontsize',16)
xlim([0 720])
ylim([-2000 8000])
grid minor

figure
plot(theta2,Rcx)
title('Fuerza sobre el cigüeñal según x','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northwest')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_c_i_g_x [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor


figure
plot(theta2,Rcy)
title('Fuerza sobre el cigüeñal según y','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northwest')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_c_i_g_y [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,Rax)
title('Fuerza de la biela sobre el émbolo según x','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northwest')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_c_i_g_y [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,Ray)
title('Fuerza de la biela sobre el émbolo según y','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northwest')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_c_i_g_y [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,Rbx)
title('Fuerza del cigüeñal sobre la biela según x','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northwest')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_c_i_g_y [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor

figure
plot(theta2,Rby)
title('Fuerza del cigüeñal sobre la biela según y','fontweight','bold','fontsize',16)
legend({['r_3=' num2str(r3),'  e=' num2str(e),' n=' num2str(rpm)]},'Fontsize',12,'Location','northwest')
xlabel('\theta_2 [°]','fontweight','bold','fontsize',16)
ylabel('F_c_i_g_y [N]','fontweight','bold','fontsize',16)
xlim([0 720])
grid minor