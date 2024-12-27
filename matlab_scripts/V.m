function VOL=V(r2,b,lambda,vpms,alfa)

    y=r2*(1+1/lambda-cos(alfa*pi/180)-sqrt(1/lambda^2-(sin(alfa*pi/180))^2));
    VOL=vpms+(y*pi*b^2)/4;
    
end
