function fluopots

% dir = 'temp/';
dir = '';
file = [dir 'HOPE.000'];
data = load(file)

n = 1952;
num = data(1:n,1);
fluo = data(1:n,2);

% % % Averaging
% windowSize = 10;
% floa = filter(ones(1,windowSize)/windowSize,1,fluo)
% tn = 1:(length(floa)-windowSize+1)
% plot(tn/10,floa(windowSize:end)*10,'LineWidth',2)


figure(1)           %first light
plot(num,fluo,'LineWidth',1)
xlabel('time (100ms per bin)','FontSize',13)
ylabel('PMT counts (counts/ 100ms)','FontSize',13)
set(gca,'FontSize',12)
ylim([1150 1800])
xlim([0 max(num)])


figure(2)           % single scan
file = [dir 'HOPE.005'] ;
data = load(file)
lims = [41 199];    %based on power measurement in column 5
num = data(lims(1):lims(2),1);
fluo = data(lims(1):lims(2),2);

m = 311;  %peak in other lab
det = ((linspace(303,335,length(num)) - m)/1000 * 100 ) * 299792458 /1e6;   %detuning from bin number

plot(det,fluo,[0 0],[min(fluo)*0.9 max(fluo)*1.1],'--','LineWidth',2)
xlim([min(det) max(det)])
ylim([min(fluo)*0.9 max(fluo)*1.1])
xlabel('Approximate 423nm frequency (MHz)','FontSize',13)
ylabel('PMT counts in 100ms','FontSize',13)
legend('Fluorescence in Sandia Trap','Peak fluorescence in other trap')
set(gca,'FontSize',12)
