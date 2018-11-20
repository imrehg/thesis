data = load('HOPING.010');

num = data(:,1);
sig = data(:,2)+data(:,3);

% detu = data(:,2)
% sig = data(:,3)+data(:,4);

mn = max(num);

figure(5);
plot(num,sig)
plot(num,sig/1000,[0 mn],[1 1]*35.8,'k--',[0 mn],[1 1]*38.5,'k-.')
set(gca,'FontSize',14)
legend(2,'Fluorescence signal','Background scatter level','Approximate single ion level')
xlabel('Bin # (100ms/bin)')
ylabel('397nm fluorescence (x1000 counts/100ms)')
xlim([0 mn])
% plot(detu,sig,'.')