function a = Initcomb(rpm)

    a = 1.33883728930169e-10*rpm^3 - 2.58080495356038e-06*rpm^2 + 0.0178275197798418*rpm -27.1058823529413;
    a = round(a, 0);
end