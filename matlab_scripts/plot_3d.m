load("ignitionmap.mat")
Y = zeros(33,18); Z = zeros(33,18); 
for i = 1:33
Y(i,:)=y;
end 
for i = 1:18
Z(:,i)=z;
end 
figure
surf(Y,Z,x)
axis([0.4 2.1 1000 9000 -20 50])
xlabel('Presión de admisión [bar]')
ylabel('[rpm]')
zlabel('AICB [º]')
filename='ignitionmap.jpg';
print(gcf, filename, '-djpeg', '-r300');