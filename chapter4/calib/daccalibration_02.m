function daccalibration

dacscan = [-2000    210;
            2000    1050;
            -2500   110;
            -900    470;
            2500    1160;
            0       660;
            1000    870;
            -1500   320;
            -2000   200;
            2000    1060;
            500     730;];

dac = dacscan(:,1);
freq  = dacscan(:,2);

p = polyfit(dac,freq,1);
y = polyval(p,sort(dac));


ffunc = @(p,dacv)(p(1)*dacv+p(2));
[pout,r,J,COVB,mse] = nlinfit(dac,freq,ffunc,[1 1])
ci = nlparci(pout,r,J)
pout(1)-ci(1,1)
pout(1)-ci(1,2)


figure(1)
disp(['Calibration : ' num2str(p(1)) ' MHz/mV ']);
plot(dac,freq,'+',sort(dac),y,'MarkerSize',8,'LineWidth',1.2)
xlabel('DAC value (mV)','FontSize',14)
ylabel('Laser freqency (MHz + 755.222THz)','FontSize',14)
title(['16jul07 - 397nm Calibration : ' num2str(p(1)) ' MHz/mV  (with voltage divider)'])
xlim([min(dac)-100 max(dac)+100])
set(gca,'FontSize',14)


function out = fffunc(p)
    out = p(1)*dac+p(2);


end

end