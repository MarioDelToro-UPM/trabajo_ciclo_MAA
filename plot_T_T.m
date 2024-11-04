figure()

hold on
pl(1)=plot(APTV(:,1),APTV(:,3),'b');
%axis([0 720 0 90])
grid on
box on
hold off

title('T (K) vs. \theta','fontsize',14)

xlabel('\theta (º)','fontsize',14)
ylabel('T (K)','fontsize',14)

%set(gca,'fontsize',14)
%set(gca,'xtick',[0 90 180 270 360 450 540 630 720])
%set(gca,'ytick',[10 30 50 70 90])
%set(gca,'DataAspectRatio',[1 320 1])
