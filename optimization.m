%% Optimization loop using fmincon
% Structure with all parameters
parameters.rpm = 2000; % Revoluciones por minuto
parameters.b1 = 101; % Diametro cilindro (mm)
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

% Optimization with genetic algorithm
%var0 = [62, 8, 35, -3]; % [s1(mm), rca(º), aae(º), aicb(º)]
intCon = [2, 3, 4];
lower_bounds = [60, 0, 0, -20];
upper_bounds = [70, 60, 70, 50];
options_ga = optimoptions('ga', 'Display', 'iter', 'PlotFcn',@gaplotbestf,'MaxGenerations',1e5,'FunctionTolerance', 1e-8);;
[var_opt, fval] = ga(@(var) objective(var, parameters), 4, [], [], ...
    [], [], lower_bounds, upper_bounds, @(var) constraints(var, parameters), intCon, options_ga);

function f = objective(var, parameters)
    [f, ~] = func_otto(var(1), var(2), var(3), var(4), parameters);
end

function [c, ceq] = constraints(var, parameters)
    [~, Pdet] = func_otto(var(1), var(2), var(3), var(4), parameters);
    c = Pdet - 1.05;
    ceq = [];
end