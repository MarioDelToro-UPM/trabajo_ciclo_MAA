rpm_adm=[1000, 2750, 4150, 5400, 6450, 7325, 8125, 8750];
ang_ret=[5, 10, 15, 20, 25, 30, 35, 40];

coeff_adm = polyfit(rpm_adm, ang_ret, 3);


rpm_esc=[875, 2125, 2875, 3625, 4500, 5500, 7250, 8750];
ang_adl=[30, 35, 40, 45, 50, 55, 60, 65];

coeff_esc = polyfit(rpm_esc, ang_adl, 3);


rpm_aicb = [1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500,...
    6000, 6500, 7000, 7500, 8000, 8500, 9000];
ang_aicb = [-14, -4, 0.8, 4, 7, 9, 11, 12, 13.2, 15, 15.8, 17, 17.8,...
    18.6, 19.2, 20.4, 21];

coeff_aicb = polyfit(rpm_aicb, ang_aicb, 3);

count=0;
for j=0:250:9000
    count=count+1;
    rpm2(count)=j;
    RCA_a(count) = RCA(j, coeff_adm);
    AAE_a(count) = AAE(j, coeff_esc);
    AICB_a(count) = AICB(j, coeff_aicb);

end

figure
title('RCA')
hold on
plot(rpm_adm,ang_ret)
plot(rpm2,RCA_a)

figure
title('AAE')
hold on
plot(rpm_esc,ang_adl)
plot(rpm2,AAE_a)

figure
title('AICB')
hold on
plot(rpm_aicb,ang_aicb)
plot(rpm2,AICB_a)



function RCA = RCA(rpm, coeff_adm)
    RCA=0;
    for stp=1:4
        RCA = RCA+coeff_adm(stp)*rpm^(4-stp);
    end
end

function AAE = AAE(rpm, coeff_esc)
    AAE=0;
    for stp = 1:4
        AAE = AAE+coeff_esc(stp)*rpm^(4-stp);
    end
end

function AICB = AICB(rpm, coeff_aicb)
    AICB=0;
    for stp=1:4
        AICB = AICB+coeff_aicb(stp)*rpm^(4-stp);
    end
end
