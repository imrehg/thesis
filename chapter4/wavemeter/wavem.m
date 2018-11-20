% %data = load('070716_overnight.dat');
% t1 = data(:,4);
% t = 1:length(t1);
% tsec = t*5;
% tmin = tsec/60;
% thour = tmin/60;
% tday = thour/24;
% 
% % plot(x,t1)
% % n = 300
% % 
% subplot(1,2,1)
% plot(tday,t1)
% % xlim([n n+72]);
% % 
% 
% subplot(1,2,2)
% plot(tmin,t1)
% % xlim([n n+3]/60);
% n = 100;
% xlim([n n+90])
% 

c =  299792458;
data = load('0418_HeNe.lta');
tsec = data(:,1)/1000;
tmin = tsec/60;
thour = tmin/60;
wl = data(:,2);

fr = c./(wl*1e-9);
con = 4.73612e14;
lims = [250 320];
plot(tmin-lims(1),(fr-con)/1e6)
xlim(lims-lims(1));
xlabel('Time (min)','FontSize',13)
ylabel('Laser frequency (MHz + 473.612THz)','FontSize',13)
%title('Frequency stabilised HeNe frequency reading');


% plot(thour,wl);
