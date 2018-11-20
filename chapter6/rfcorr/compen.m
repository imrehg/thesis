% data = load ('MORECORR.000');
% 
% 
% num = data(:,1);
% detu = data(:,2);
% c7 = data(:,7);
% c8 = data(:,8);
% c9 = data(:,9);
% 
% figure(6);
% plot(detu, c7,'.')


%DATA : 25-May-2007

figure(6);
data = load ('TEST.006');

num = data(:,1);
detu = data(:,2);
c7 = data(:,7);
c8 = data(:,8);
c9 = data(:,9);

% subplot(2,1,1)
% plot(detu, c7,'.')

data = load ('TEST.007');

numb = data(:,1);
detub = data(:,2);
c7b = data(:,7);


n1 = 1:200;
n2 = 1:200;
detu = detu*0.211;
detub = detub*0.211

%%%
%%% finding the Half Maximum
% detu = detu - max(detu)
% detub = detub - max(detub)
% bg = mean(c7(1:30))
% bgb = mean(c7b(1:30))
% c7 = c7-bg;
% c7b = c7b-bg;
% 
% c7 = c7/max(c7);
% c7b = c7b/max(c7b);
% 
% 
% subplot(2,1,2)
% plot(detu(n1), c7(n1),'-',...
%      detub(n2), c7b(n2),'-',...
%      [min(detu) 0],[0.5 0.5],...
%      'LineWidth',1.5);
 

detu = detu - max(detu);
detub = detub - max(detub);


% subplot(2,1,2)
plot(detu(n1), c7(n1),'-',...
     detub(n2), c7b(n2),'+-',...
     'LineWidth',1,...
     'MarkerSize',5);
set(gca,'FontSize',14);
xlabel('Detuning from resonance (MHz)')
ylabel('Fluorescence (counts / 100ms)');
legend('Compensated ion','Not compensated ion','Location','NorthWest')
 