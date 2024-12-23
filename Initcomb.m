function a = Initcomb(rpm)

    a = 1.31406948744411e-10*rpm^3 - 2.49948400412798e-06*rpm^2 + 0.0173149294805642*rpm -28.7549019607844;
    a = round(a, 0);
end