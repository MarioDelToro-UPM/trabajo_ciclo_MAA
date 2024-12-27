function [machg,gasto]=gasto(P1,rho1,area,P2,rho2,GAMMA)

gasto=0;
rpcrit=((GAMMA+1)/2)^(GAMMA/(GAMMA-1));
machg=0;

if (P1~=P2)
    if(P1>P2)
        if(P1/P2<rpcrit)
            %Flujo subsónico
            a1=sqrt(GAMMA*P1/rho1);
            gasto=area*rho1*a1*sqrt(2/(GAMMA-1)*((P2/P1)^(2/GAMMA)-(P2/P1)^((GAMMA+1)/GAMMA)));
            machg=sqrt(2/(GAMMA-1)*((P1/P2)^((GAMMA-1)/GAMMA)-1));
        else
            %Flujo bloqueado
            gasto=(area*sqrt(P1*rho1))*sqrt(GAMMA)*(2/(GAMMA+1))^((GAMMA+1)/(2*(GAMMA-1)));
            machg=1;
        end
    else
        if(P2/P1<rpcrit)
            %Flujo subsónico
            a2=sqrt(GAMMA*P2/rho2);
            gasto=-area*rho2*a2*sqrt(2/(GAMMA-1)*((P1/P2)^(2/GAMMA)-(P1/P2)^((GAMMA+1)/GAMMA)));
            machg=sqrt(2/(GAMMA-1)*((P2/P1)^((GAMMA-1)/GAMMA)-1));
        else
            %Flujo bloqueado
            gasto=-(area*sqrt(P2*rho2))*sqrt(GAMMA)*(2/(GAMMA+1))^((GAMMA+1)/(2*(GAMMA-1)));
            machg=1;
        end
    end
end
end
