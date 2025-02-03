% En este scrip se calcula lo que se pide en cada apartado del trabajo de
% cinemática y dinámica usando scripts anteriores
OTTO_c
princotto
cindin
close all
%% Apartado 1
% Pide representar las variables cinamtica(r1, v1, a1, a3g)
% para la biela original y una un 10 mayor.

%Ejecutando el codigo OTTO y luego CINDIN se sacan todo lo que te piden
%pero la acelracion del cg te lo da desglosado en a3gx y a3gy

% He usado 2000 rpm y el turbo puesto pa1 = 2; pe1 = 0.8*pea1

%Primero cargamos los datos
files = {'r1_ampliada.mat', 'v1_ampliada.mat', 'a1_ampliada.mat', ...
         'a3gy_ampliada.mat', 'a3gx_ampliada.mat', ...
         'r1_original.mat', 'v1_original.mat', 'a1_original.mat', ...
         'a3gy_original.mat', 'a3gx_original.mat'};

new_names = {'r1_ampliada', 'v1_ampliada', 'a1_ampliada', ...
             'a3gy_ampliada', 'a3gx_ampliada', ...
             'r1_original', 'v1_original', 'a1_original', ...
             'a3gy_original', 'a3gx_original'};

for i = 1:length(files)
    temp = load(files{i});  % Cargar el archivo como estructura
    vars = fieldnames(temp);  % Obtener los nombres de las variables dentro del .mat
    assignin('base', new_names{i}, temp.(vars{1}));  % Asignar la variable con el nuevo nombre
end
% Luego ploteamos individualmente cada varibale que se nos pide
figure()

hold on

for pvj=1:length(v1_original)
 pBMEP(pvj)=plot(a3gy_original);%, DisplayName=num2str(EXTRADATA(pvj)));
 pBMEP2(pvj)=plot(a3gy_ampliada);
end

grid on
box on

% title('BMEP vs. rpm','fontsize',14)

xlabel('$\theta_2$','Interpreter','latex','FontSize',14);
ylabel('Acelaración en y del centro de masas de la biela','fontsize',14)
legend('Pistón original','Pistón con biela aumentada','Location','Southeast')
filename = '1_a3gy.jpg';
print(gcf, filename, '-djpeg', '-r300'); 

hold off
%% Apartado 2