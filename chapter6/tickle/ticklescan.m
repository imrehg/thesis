% 25-07-07 data, labbook p41

data = load('COMPEN.026');
num = data(:,1);
sig = data(:,2)+data(:,3);

figure(3)
plot(num,sig);
xlim([0 max(num)])
ylim([min(sig) max(sig)+300])
set(gca,'FontSize',14)
xlabel('Bin # (Scan: -1 kHz / bin, Start: 4000kHz)');
ylabel('Fluorescence (counts/100ms)');
