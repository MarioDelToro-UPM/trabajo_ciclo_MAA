function frac=X(a,n,thetaS,thetaD,theta)

    frac=1-exp(-a*((theta-thetaS)/thetaD)^n);
    
end