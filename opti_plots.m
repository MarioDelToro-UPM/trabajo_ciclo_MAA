clear
load("opti_2.mat")
load("opti_mot.mat")
RCA = zeros(1, length(rpm));
AAE = RCA;
AICB = RCA;
for i=1:length(rpm)
    RCA(i) = Ret_adm(rpm(i));
    AAE(i) = Avn_esc(rpm(i));
    AICB(i) = Initcomb(rpm(i));
end

figure(1) % RCA
plot(rpm, var_opt(1,:))
hold on
plot(rpm, RCA)
hold off
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('RCA (º)', Rotation=0)
title('Retardo en el cierre de la admisi$\acute{o}$n')
set(legend, 'Interpreter', 'latex');
legend('Gen$\acute{e}$tico', 'Motor', 'Location', 'best')

figure(2) % AAE
plot(rpm, var_opt(2,:))
hold on
plot(rpm, AAE)
hold off
set(gca,'defaultTextInterpreter','latex','FontSize',11);
set(legend, 'Interpreter', 'latex');
xlabel('rpm')
ylabel('AAE (º)', Rotation=0)
title('Adelanto apertura del escape')
set(legend, 'Interpreter', 'latex');
legend('Gen$\acute{e}$tico', 'Motor', 'Location', 'best')

figure(3) % AICB
plot(rpm, var_opt(3,:))
hold on
plot(rpm, AICB)
hold off
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('AICB (º)', Rotation=0)
title('$\acute{A}$ngulo de inicio de la combusti$\acute{o}$n')
set(legend, 'Interpreter', 'latex');
legend('Gen$\acute{e}$tico', 'Motor', 'Location', 'best')

figure(4) % Potencia
plot(rpm, -pot)
hold on
plot(rpm_mot, pot_mot)
hold off
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('Potencia (kW)', Rotation=0)
title('Potencia al freno')
set(legend, 'Interpreter', 'latex');
legend('Gen$\acute{e}$tico', 'Motor', 'Location', 'best')

figure(5) % Peligro de detonación
plot(rpm, pdet)
hold on
plot(rpm_mot, pdet_mot)
hold off
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('p_{det}', Rotation=0)
title('Peligro de detonaci$\acute{o}$n')
set(legend, 'Interpreter', 'latex');
legend('Gen$\acute{e}$tico', 'Motor', 'Location', 'best')
