data = load('TICKLE.003');

num = data(:,1);
siga =data(:,2);
sigb =data(:,3);
sig = siga+sigb;

ll = max(num);
bg = mean(sig(1:100));
onei = mean(sig(170:269))-bg;


% subplot(2,1,1)
% plot(num,(sig-bg)/onei,[0 ll],[1 1],[0 ll],[2 2],[0 ll],[3 3],[0 ll],[4 4])
% xlim([0 ll]);


% subplot(2,1,2);
plot(num,sig,[0 ll],[bg bg],'k-.',[0 ll],[bg bg]+onei,'k--',[0 ll],[bg bg]+2*onei,'k--',[0 ll],[bg bg]+3*onei,'k--',[0 ll],[bg bg]+4*onei,'k--')
set(gca,'FontSize',13)
ylabel('Counts / 100 ms','FontSize',14)
xlabel('Bin # (100 ms / bin)','FontSize',14)
xlim([0 ll]);

