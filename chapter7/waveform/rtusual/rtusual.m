
close all;

x = 3;
sc = 10.0179

out = [];
for num = 0:19
    fbase = 'tek';
    filename = [fbase sprintf('%.4d',num) '.csv'];
    data = load(filename);
    hold on;
    plot(data(:,1)/0.001,data(:,2)/max(abs(data(:,2)))*sc,'g')
    
    out = [out data(:,2)/max(abs(data(:,2)))*sc];
end

n = 2;
tt = ((0:1:29)*2-1);
dd = load('fullscan.txt');
% plot(tt,dd(:,n)/max(abs(dd(:,n))),'k','LineWidth',2)
plot(tt,dd(:,n),'k','LineWidth',2)
xlim([min(data(:,1)) 0.065]/0.001)
ylim([-10.5 0.5])
xlabel('Time (ms)','FontSize',14)
ylabel('Voltage change (V)','FontSize',14)
set(gca,'FontSize',14)

set(gca,'YTick',[-10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0],'YTickLabel',{'-10';'';'-8';'';'-6';'';'-4';'';'-2';'';'0' });


out = [data(:,1)/0.001 out];
save 'measuredwaveforms.dat' 'out' '-ascii';

out2 = [tt(:) dd(:,n)];
save 'measuredwaveforms_compare.dat' 'out2' '-ascii';
