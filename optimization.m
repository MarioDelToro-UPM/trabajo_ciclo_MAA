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
parameters.gamma1 = 1.3; % Gamma antes comb?
parameters.gamma2 = 1.3; % Gamma despues comb?
parameters.miter = 3; % Maximas iteraciones
parameters.ncil = 6; % Numero cilindros
parameters.pa1 = 2; % Presion admision? (bar) [Se asume turbo]
parameters.pe1 = 0.8*parameters.pa1; % Presion escape? (bar)

[Pow, pdet] = func_otto(62, 8, 35, -3, parameters)

