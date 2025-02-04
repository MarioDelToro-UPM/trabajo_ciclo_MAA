%clear
caso_1 = 'a'; % a - Biela original // b - Biela 10% mas larga
caso_2 = 'a'; % a - adm 0.3 bar y 1200 rpm // b - adm 1 bar y 3000 rpm // c adm 1 bar y  9000 rpm(max)

% Variables para cinemática
s1=62;
b1=101;
vd=pi*b1^2/4*s1/1000;
if 'a' == caso_1
    lambda=0.3;
elseif 'b' == caso_1
    lambda = 0.27;
end
s=s1/1000;
b=b1/1000;
r2=s/2;
r3=r2/lambda;
e=0.0;

%Variables para princotto
QANG=0;
ORIG=0;
rg=9.5;
dcb=40;
Ta=300;
fequ=1.2;
Tw=500;
a=5.4;
n=3;
NO=100;
gamma1=1.3;
gamma2=1.3;
miter=3;
if 'a' == caso_2
    pa1 = 0.3;
    rpm = 1200;
elseif 'b' == caso_2
    pa1 = 1;
    rpm = 3000;
elseif 'c' == caso_2
    pa1 = 1;
    rpm = 9000;
end
pe1 = pa1;
rca=Ret_adm(rpm);
aae=Avn_esc(rpm); 
aicb=Initcomb(rpm);

pa=pa1*100000;
pe=pe1*100000;
qr=vd/1000000;

Avalv_a=0.4*pi*b^2/4;
Avalv_e=0.3*pi*b^2/4;

%Masas y biela
m1=0.6;
m3=0.45;
I3=0.0012;
delta=0.25;

%Cálculo de fuerza de gases. Ojo, princotto cambia theta2!!!
princotto
theta2=APTV(:,1);
pres=APTV(:,2);
F1=-pi*b^2/4*(pres-1)*100000;

%Cinemática
wrpm=rpm*pi/30;
rb=0.25*r3;
theta2=(0:720)';
theta2rad=theta2*pi/180;

theta3rad=asin(e-lambda*sin(theta2rad));
r1=r3*(lambda*cos(theta2rad)+cos(theta3rad));

w3=-wrpm*lambda*cos(theta2rad)./cos(theta3rad);
v1=-r3*(lambda*wrpm*sin(theta2rad)+w3.*sin(theta3rad));

a3=lambda*wrpm^2*sin(theta2rad)./cos(theta3rad)-w3.^2.*sin(theta3rad)./cos(theta3rad);
a1=-r2*wrpm^2*cos(theta2rad)-r3*(a3.*sin(theta3rad)+w3.^2.*cos(theta3rad));

%Cálculo de par instantáneo
v3gx=-r2*wrpm*sin(theta2rad)-rb*w3.*sin(theta3rad);
v3gy=r2*wrpm*cos(theta2rad)+rb*w3.*cos(theta3rad);
v3g=sqrt(v3gx.^2+v3gy.^2);
a3gx=-r2*wrpm^2*cos(theta2rad)-rb*(a3.*sin(theta3rad)+w3.^2.*cos(theta3rad));
a3gy=-r2*wrpm^2*sin(theta2rad)+rb*(a3.*cos(theta3rad)-w3.^2.*sin(theta3rad));
a3g=sqrt(a3gx.^2+a3gy.^2);

T2=(-F1.*v1+I3*a3.*w3+m3*a3gx.*v3gx+m3*a3gy.*v3gy+m1*a1.*v1)/wrpm;

T2_tot(1:120)=T2(1:120)+T2(121:240)+T2(241:360)+T2(361:480)+T2(481:600)+T2(601:720); % 6 cilindros
T2_tot(121:720)= [T2_tot(1:120) T2_tot(1:120) T2_tot(1:120) T2_tot(1:120) T2_tot(1:120)];
T2_tot(721)=T2_tot(1);

%Cálculo de fuerzas
% Metodo directo
Rax_1=m1*a1-F1;
Rbx_1=-Rax_1-m3*a3gx;
Rby_1=(-T2+r2*Rbx_1.*sin(theta2rad))./cos(theta2rad)/r2;
Ray_1=-Rby_1-m3*a3gy;
Fr_1=-Ray_1;

% Sistema de ecuaciones
one=-r3.*(1-delta)*(-sin(theta3rad));
two=-r3.*(1-delta)*cos(theta3rad);
three=r3*delta*(-sin(theta3rad));
four=r3*delta*cos(theta3rad);
 
Rax_2=zeros(721,1);
Ray_2=zeros(721,1);
Rbx_2=zeros(721,1);
Rby_2=zeros(721,1);
Fr_2=zeros(721,1);

for i=1:721
    Carga=[1 0 0 0 0;0 1 0 0 1; -1 0 -1 0 0;0 -1 0 -1 0; one(i,1) two(i,1) three(i,1) four(i,1) 0];

    p1=(m1*a1(i,1)-F1(i,1));
    p3=m3*a3gx(i,1);
    p4=m3*a3gy(i,1);
    p5=I3*a3(i,1);
    
    Indep=[p1; 0 ; p3; p4; p5];
    
    x=Carga\Indep;
    
    Rax_2(i,1)=x(1,1);
    Ray_2(i,1)=x(2,1);
    Rbx_2(i,1)=x(3,1);
    Rby_2(i,1)=x(4,1);
    Fr_2(i,1)=x(5,1);
end
% Reacciones en el apoyo del cigueñal
Rcx=Rax_1+m3*a3gx;
Rcy=Ray_1+m3*a3gy;

% Coeficiente de regularidad
I_tot0 = 0.5;
CR_obj = 2;
I_tot = fminsearch(@(I_tot) abs(coef_reg(wrpm, T2_tot, I_tot)-CR_obj), I_tot0);
disp(['Inercia del conjunto: ', num2str(I_tot), ' kg m^2']);
w2_real = din_cig(wrpm, T2_tot, I_tot);

function CR = coef_reg(wrpm, T2_tot, I_tot)
    w2 = din_cig(wrpm, T2_tot, I_tot);
    CR = (max(w2)-min(w2))/wrpm*100;
end

function w2 = din_cig(w2_avg, T2_tot, I_tot)
    % Integracion temporal con un Euler explicito
    TR = trapz(0:720, T2_tot)/720;
    w2 = zeros(721,1);
    w2(1) = w2_avg;
    for i=1:720
        w2(i+1) = w2(i) + (pi/180)*(1/w2_avg)*(-T2_tot(i) + TR)/I_tot;
    end
end
