data = load('TRACE456_2.CSV');
freq = data(:,1);
fcomp = data(:,2);
plot(freq/1e3,fcomp,'LineWidth',1)
xlim([min(freq) max(freq)]/1e3)
ylim([min(fcomp) -60])
xlabel('Frequency component (kHz)','FontSize',14);
ylabel('Amplitude (dBm)','FontSize',14);
title('RF Noise Profile - DAC6703 Ch0','FontSize',14)