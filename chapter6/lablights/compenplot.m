data = load('compen.000');

fluo = data(:,3)+data(:,4);
binn = data(:,1);


plot(binn,fluo')
hold on
for i = 1:10;
    plot([1 1]*i*102,[0 max(fluo)],'--r')
end
hold off
xlabel('Bin # (100ms / bin)','FontSize',14);
ylabel('Fluorescence (counts/100ms)','FontSize',14)
title('Effect of ambient light on compensation','FontSize',14)
xlim([0 max(binn)])

% arrows put on the plot manually
% bin:
% 130 -  lights on
% 315 -  lights off
% 515 -  lights on
% 782 -  lights off