function [L1L2esc]=L1L2esc(alfa, aae, rce)

angini=540-aae;
angfin=720+rce;
%alfaramp=(angfin-angini)/2;
alfaramp=90;
L1L2esc=0.15*sin((alfa-angini)*pi/(angfin-angini));

% if (alfa<=(angini+alfaramp)) 
%     L1L2esc=0.25*(1-cos((alfa-angini)/alfaramp*pi))/2;    
% elseif ((alfa>(angini+alfaramp))&&(alfa<(angfin-alfaramp)))
%     L1L2esc=0.25;
% elseif (alfa>=(angfin-alfaramp))
%     L1L2esc=0.25*(1-cos(((alfa-angfin+alfaramp)/alfaramp+1)*pi))/2;
% end
%     
