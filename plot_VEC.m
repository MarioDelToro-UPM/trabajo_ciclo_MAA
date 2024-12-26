
NumData=size(VEC);
NumRpm=NumData(3);
NumAux=NumData(2);

VRpm=zeros(NumRpm,1);
P1=zeros(NumRpm,1);
pBMEP=zeros(NumAux);
pBPow=zeros(NumAux);
pBTrq=zeros(NumAux);
pBBSFC=zeros(NumAux);

for pvi=1:NumRpm
    VRpm(pvi)=VEC(1,1,pvi);
end

for pvj=1:NumAux
 for pvi=1:NumRpm
    VecBMEP(pvj,pvi)=VEC(2,pvj,pvi); %El 2 indica que es la BMEP
    VecBPow(pvj,pvi)=VEC(3,pvj,pvi); %El 3 indica que es la Potencia
    VecBTrq(pvj,pvi)=VEC(4,pvj,pvi);
    VecBBSFC(pvj,pvi)=VEC(6,pvj,pvi);
 end
end


figure()

hold on

for pvj=1:NumAux
 pBMEP(pvj)=plot(VRpm,VecBMEP(pvj,:));%, DisplayName=num2str(EXTRADATA(pvj)));
end

grid on
box on

title('BMEP vs. rpm','fontsize',14)

xlabel('rpm','fontsize',14)
ylabel('BMEP(bar)','fontsize',14)
legend('show')


figure()

hold on

for pvj=1:NumAux
 pBPow(pvj)=plot(VRpm,VecBPow(pvj,:));%, DisplayName=num2str(EXTRADATA(pvj)));
 pBTrq(pvj)=plot(VRpm,VecBTrq(pvj,:));
end


%axis([0 720 0 90])
grid on
box on

title('Potencia vs. rpm','fontsize',14)

xlabel('rpm','fontsize',14)
ylabel('Potencia al freno (kW)','fontsize',14)
legend('show')

%set(gca,'fontsize',14)
%set(gca,'xtick',[0 90 180 270 360 450 540 630 720])
%set(gca,'ytick',[10 30 50 70 90])
%set(gca,'DataAspectRatio',[1 320 1])
