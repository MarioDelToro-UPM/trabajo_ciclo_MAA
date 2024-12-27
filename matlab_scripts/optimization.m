% ------------------------------------------- %
% Optimization loop using genetic algorithims %
% ------------------------------------------- %
%% Structure with all parameters
parameters.rpm = 2000; % Revoluciones por minuto
parameters.vd = 496.7345; % Volumen cilindro (cm3)
parameters.lambda=0.3;
parameters.rg = 9.5; % Relacion de compresion
parameters.dcb = 40; % Duracion de la combustion (º)
parameters.Ta = 300; % Temperatura ambiente (K) 
parameters.Tw = 500; % Temperatura bloque (K) 
parameters.a = 5.4; % Parámetro combustión real
parameters.n = 3; 
parameters.NO = 100; % Octanage
parameters.gamma1 = 1.3; % Gamma antes comb
parameters.gamma2 = 1.3; % Gamma despues comb
parameters.miter = 3; % Minimas iteraciones
parameters.ncil = 6; % Numero cilindros
parameters.pa1 = 2; % Presion admision? (bar) [Se asume turbo]
parameters.pe1 = 0.8*parameters.pa1; % Presion escape? (bar)

%% Optimization with genetic algorithm
%var0 = [62, 8, 35, -3]; % [s1(mm), rca(º), aae(º), aicb(º)]
intCon = [2, 3, 4];
lower_bounds = [60, 0, 0, -20];
upper_bounds = [80, 60, 70, 50];
rpm = 1000:100:9000;
n = length(rpm);
var_opt = zeros(4, n);
pot = zeros(1, n);
options_ga = optimoptions('ga', 'Display', 'iter', 'PlotFcn', @gaplotbestf, ...
    'MaxGenerations', 1e5, 'FunctionTolerance', 1e-12);
for i = 1:n
    parameters.rpm = rpm(i);
    [var_opt(:,i), pot(i)] = ga(@(var) objective(var, parameters), 4, [], ...
        [], [], [], lower_bounds, upper_bounds, @(var) ...
        constraints(var, parameters), intCon, options_ga);
    disp('')
end

%[var_opt, fval] = ga(@(var) objective(var, parameters), 4, [], [], [], [], ...
%    lower_bounds, upper_bounds, @(var) constraints(var, parameters), ...
%    intCon, options_ga);

%% Plots
load("opti_1.mat");
figure(1)
subplot(2, 2, 1);
plot(rpm, var_opt(1,:))
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('$s_1 (mm)$', Rotation=0)
title('Carrera óptima a cada régimen')

subplot(2, 2, 2);
plot(rpm, var_opt(2,:))
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('RCA (º)', Rotation=0)
title('Retardo en el cierre de la admisión óptimo a cada régimen')

subplot(2, 2, 3);
plot(rpm, var_opt(3,:))
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('AAE (º)', Rotation=0)
title('Adelanto apertura escape óptimo a cada régimen')

subplot(2, 2, 4);
plot(rpm, var_opt(4,:))
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('AICB (º)', Rotation=0)
title('Ángulo de inicio de combustión óptimo a cada régimen')

figure(2)
plot(rpm, -pot)
set(gca,'defaultTextInterpreter','latex','FontSize',11);
xlabel('rpm')
ylabel('Potencia (kW)', Rotation=0)
title('Potencia optimizada a cada régimen')


%% Functions
function f = objective(var, parameters)
    [Pow, ~] = func_otto(var(1), var(2), var(3), var(4), parameters);
    f = -Pow;
end

function [c, ceq] = constraints(var, parameters)
    [~, Pdet] = func_otto(var(1), var(2), var(3), var(4), parameters);
    c = Pdet - 1.05;
    ceq = [];
end