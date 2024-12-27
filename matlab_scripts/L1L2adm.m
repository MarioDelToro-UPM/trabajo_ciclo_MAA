function [L1L2adm]=L1L2adm(alfa, AAA, RCA)

angini=-AAA;
angfin=180+RCA;
%alfaramp=(angfin-angini)/2;
%alfaramp=90;
L1L2adm=0.15*sin((alfa+AAA)*pi/(180+RCA+AAA));

% if (alfa<=(angini+alfaramp)) 
%     L1L2adm=0.25*(1-cos((alfa-angini)/alfaramp*pi))/2;
% elseif ((alfa>(angini+alfaramp))&&(alfa<(angfin-alfaramp)))
%     L1L2adm=0.25;
% elseif (alfa>=(angfin-alfaramp))
%     L1L2adm=0.25*(1-cos(((alfa-angfin+alfaramp)/alfaramp+1)*pi))/2;
% end
    
