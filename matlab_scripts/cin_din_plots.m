%% Apartado 1
clear
load("cin_din1.mat")
% Posicion del embolo en funcion de theta 2
figure()
plot(0:720,r1_a, 0:720, r1_b)
xlabel('\theta_2 (°)')
ylabel('r_1 (m)')
xlim([0 720])
legend('Biela original','Biela 10% más larga','Location','best')
grid on
print(gcf, 'cin_din_plots/Pos_embolo.jpg', '-djpeg', '-r300');

% Velocidad del embolo en funcion de theta 2
figure()
plot(0:720,v1_a, 0:720, v1_b)
xlabel('\theta_2 (°)')
ylabel('v_1 (m/s)')
xlim([0 720])
legend('Biela original','Biela 10% más larga','Location','southeast')
grid on
print(gcf, 'cin_din_plots/Vel_embolo.jpg', '-djpeg', '-r300');

% Aceleracion del embolo en funcion de theta 2
figure()
plot(0:720,a1_a, 0:720, a1_b)
xlabel('\theta_2 (°)')
ylabel('v_1 (m/s)')
xlim([0 720])
legend('Biela original','Biela 10% más larga','Location','southeast')
grid on
print(gcf, 'cin_din_plots/Acel_embolo.jpg', '-djpeg', '-r300');

%% Apartados 2, 3 y 4
clear
load("cin_din2.mat")
% Velocidad del embolo en funcion de theta 2
figure()
plot(0:720,F1_a, 0:720, F1_b, 0:720, F1_c)
xlabel('\theta_2 (°)')
ylabel('F_1 (N)')
xlim([0 720])
legend('Caso a', 'Caso b', 'Caso c', 'Location','best')
grid on
print(gcf, 'cin_din_plots/Fuerza_embolo.jpg', '-djpeg', '-r300');

% Par motor instantaneo monocilindrico en funcion de theta 2
figure()
plot(0:720,-T2_a, 0:720, -T2_b, 0:720, -T2_c)
xlabel('\theta_2 (°)')
ylabel('-T_2 (N)')
xlim([0 720])
legend('Caso a', 'Caso b', 'Caso c', 'Location','best')
grid on
print(gcf, 'cin_din_plots/Par_motor.jpg', '-djpeg', '-r300');

% Par motor total en funcion de theta 2
figure()
plot(0:720,-T2_tot_a, 0:720, -T2_tot_b, 0:720, -T2_tot_c)
xlabel('\theta_2 (°)')
ylabel('-T_2 (N)')
xlim([0 720])
legend('Caso a', 'Caso b', 'Caso c', 'Location','best')
grid on
print(gcf, 'cin_din_plots/Par_motor_tot.jpg', '-djpeg', '-r300');

%% Apartado 5
clear
load("cin_din3.mat")
figure()
plot(0:720,w2_real*30/pi)
xlabel('\theta_2 (°)')
ylabel('\omega_2 (rpm)')
xlim([0 720])
ylim([0.985*rpm 1.015*rpm])
leg_strg = ['I_{tot}=', num2str(I_tot), ' kg m^2'];
legend(leg_strg,'Location','best')
grid on
print(gcf, 'cin_din_plots/dw2dt.jpg', '-djpeg', '-r300');

%% Apartado 6
clear
load("cin_din4.mat")
figure()
plot(0:720, Fr_a, 0:720, Fr_b)
xlabel('\theta_2 (°)')
ylabel('F_R (N)')
xlim([0 720])
legend('Biela original','Biela 10% más larga','Location','best')
grid on
print(gcf, 'cin_din_plots/Fuerza_lat.jpg', '-djpeg', '-r300');
