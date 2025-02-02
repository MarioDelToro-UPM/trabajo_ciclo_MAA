clear
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
plot (theta2,F1)
%Cinemática
wrpm=rpm*pi/30;
rb=0.25*r3;
theta2=(0:720)';
theta2rad=theta2*pi/180;

theta3=asin(e-lambda*sin(theta2rad));
r1=r3*(lambda*cos(theta2rad)+cos(theta3));

w3=-wrpm*lambda*cos(theta2rad)./cos(theta3);
v1=-r3*(lambda*wrpm*sin(theta2rad)+w3.*sin(theta3));

a3=lambda*wrpm^2*sin(theta2rad)./cos(theta3)-w3.^2.*sin(theta3)./cos(theta3);
a1=-r2*wrpm^2*cos(theta2rad)-r3*(a3.*sin(theta3)+w3.^2.*cos(theta3));


%Cálculo de par instantáneo
v3gx=-r2*wrpm*sin(theta2rad)-rb*w3.*sin(theta3);
v3gy=r2*wrpm*cos(theta2rad)+rb*w3.*cos(theta3);
a3gx=-r2*wrpm^2*cos(theta2rad)-rb*(a3.*sin(theta3)+w3.^2.*cos(theta3));
a3gy=-r2*wrpm^2*sin(theta2rad)+rb*(a3.*cos(theta3)-w3.^2.*sin(theta3));

T2=(-F1.*v1+I3*a3.*w3+m3*a3gx.*v3gx+m3*a3gy.*v3gy+m1*a1.*v1)/wrpm;
Tm=-T2;

%Cálculo de fuerzas
Rax=m1*a1-F1;
Rbx=-Rax-m3*a3gx;
Rby=(-T2+r2*Rbx.*sin(theta2rad))./cos(theta2rad)/r2;
Ray=-Rby-m3*a3gy;
Fr=-Ray;

%Par total
Ttot(1:120)=Tm(1:120)+Tm(121:240)+Tm(241:360)+Tm(361:480)+Tm(481:600)+Tm(601:720);

figure
plot(Ttot);

