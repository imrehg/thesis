function daccalibration866

dacscan = [150  1360;
           0    1110;
           -150 864;
           -250 650;
           -350 440;
           -50  1000;
           250  1520;
           350  1710;
           0    1100;
           -150 820;
           150  1340;];

dac = dacscan(:,1);
freq  = dacscan(:,2);

p = polyfit(dac,freq,1);
y = polyval(p,sort(dac));

figure(2)
disp(['Calibration : ' num2str(p(1)) ' MHz/mV ']);
plot(dac,freq,'+',sort(dac),y,'MarkerSize',8,'LineWidth',1.2)
xlabel('DAC value (mV)','FontSize',14)
ylabel('Laser freqency (MHz + 345.9990THz)','FontSize',14)
title(['16jul07 - 866nm Calibration : ' num2str(p(1)) ' MHz/mV '])
xlim([min(dac)-30 max(dac)+30])
ylim([min(freq)-30 max(freq)+30])
set(gca,'FontSize',14)
