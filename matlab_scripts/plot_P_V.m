figure()
pp=plot(APTV(:,4),APTV(:,2));

%axis([0 720 0 90])
grid on
box on

title('Presión vs. Volumen','fontsize',14)

xlabel('Volumen (l)','fontsize',14)
ylabel('P (bar)','fontsize',14)

%set(gca,'fontsize',14)
%set(gca,'xtick',[0 90 180 270 360 450 540 630 720])
%set(gca,'ytick',[10 30 50 70 90])
%set(gca,'DataAspectRatio',[1 320 1])
