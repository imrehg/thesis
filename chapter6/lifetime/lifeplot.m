function lifeplot;


data1 = load('0518_life_1.txt');
data2 = load('0518_life_2.txt');
data3 = load('0518_life_3.txt');
data4 = load('0518_life_4.txt');


[tp1 sp1] = splotdata(data1);
[tp2 sp2] = splotdata(data2);
[tp3 sp3] = splotdata(data3);
[tp4 sp4] = splotdata(data4);

% plot(tp1,sp1,tp2,sp2,'--',tp3,sp3,tp4,sp4,'--')

figure(1)
% subplot(2,1,1)
plot(tp1,sp1,tp3,sp3,'--','LineWidth',1.4)
xlim([0 max(tp3)])
ylim([0 1.04])
set(gca,'FontSize',14)
xlabel('Time since ion capture (s)','FontSize',14)
ylabel('Survival function','FontSize',14)
legend('Ca oven always on','Ca oven turned off after ion capture')

% subplot(2,1,2)
% plot(tp2,sp2,tp4,sp4,'--')
% xlim([0 max(tp4)])



data1 = load('0521_life_1.txt');
data2 = load('0521_life_2.txt');
data3 = load('0521_life_3.txt');


[tp1 sp1] = splotdata(data1);
[tp2 sp2] = splotdata(data2);
[tp3 sp3] = splotdata(data3);

% plot(tp1,sp1,tp2,sp2,'--',tp3,sp3,tp4,sp4,'--')

figure(2)
plot(tp1,sp1,tp2,sp2,'-.',tp3,sp3,'--','LineWidth',1.4)
xlim([0 max(tp1)])
ylim([0 1.04])
set(gca,'FontSize',14)
xlabel('Time since ion capture (s)','FontSize',14)
ylabel('Survival function','FontSize',14)
legend('I_{oven} = 5.25A','I_{oven} = 5.5A','I_{oven} = 5.75A')




function [tp survp] = splotdata(data);

tt = data(:,1);
surv = data(:,2);

for k = 1:(length(tt)-1)
       n = (k-1)*2+1;
       tp(n) = tt(k);
       tp(n+1) = tt(k+1);
       survp(n) = surv(k);
       survp(n+1) = surv(k);
     
end

tp = tp(:);
survp = survp(:);
