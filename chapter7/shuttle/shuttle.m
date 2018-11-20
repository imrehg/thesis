data = load('shuttle.002');


num = data(:,1);
sig = data(:,2)+data(:,3);

tm = num*10/1000

figure(7);
plot(tm,sig)
set(gca,'FontSize',14);
xlabel('Time (s)');
ylabel('Fluorescence (counts / 10 ms)');
xlim([0 max(tm)]);
