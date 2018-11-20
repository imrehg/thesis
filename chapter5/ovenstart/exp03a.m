% close all;

data = load('070326.txt');

%
% Pressure
%
figure(1)
pressure = data(:,2).*10.^data(:,3);

% [AX,H1,H2] = plotyy(data(:,1),pressure,data(:,1),exp(data(:,5)),'semilogy');
[AX,H1,H2] = plotyy(data(:,1),pressure,data(:,1),data(:,5),'semilogy','plot');


set(get(AX(1),'Ylabel'),'String','Chamber Pressure (Torr)','FontSize',14) 
set(get(AX(2),'Ylabel'),'String','Ca oven current (A)','FontSize',14) 
grid on
xlabel('time since start (min)','FontSize',14)
set(H1,'LineStyle','-','LineWidth',2)
set(H2,'LineStyle','-','LineWidth',2)


xlimits = get(AX(1),'XLim');
ylimits = get(AX(1),'YLim');
xin = (xlimits(2)-xlimits(1))/5;
yin = (ylimits(2)-ylimits(1))/5;
% set(AX(1),'XTick',[xlimits(1):xin:xlimits(2)],...
%         'YTick',[1e-11 1e-10 1e-9 1e-8 1e-7 1e-6 2e-6])
xlimits = get(AX(2),'XLim');
ylimits = get(AX(2),'YLim');
xin = (xlimits(2)-xlimits(1))/5;
yin = (ylimits(2)-ylimits(1))/5;
% set(AX(2),'XTick',[xlimits(1):xin:xlimits(2)],...
%         'YTick',[1:0.5:6])
set(AX(1),'YLim',[1e-10 1e-6],'FontSize',12)
set(AX(2),'YLim',[0 8],'FontSize',12)
    

% % 
% % %
% % % Resistance
% % %    
% % figure(2)
% % subplot(2,1,1)
% % 
% % for i = 1:length(data(:,1))
% %     if (data(i,5) > 0)
% %     resist1(i) = (data(i,4)-5e-3)./data(i,5);
% %     resist2(i) = (data(i,4)+5e-3)./data(i,5);
% %     resistX(i) = (data(i,4))./data(i,5);
% %     else
% %     resist1(i) = NaN;
% %     resist2(i) = NaN;
% %     resistX(i) = NaN;
% %     end
% % end
% % 
% % plot(data(:,1),[resist1(:) resist2(:) resistX(:)])
% % 
% % for i = 1:length(data(:,1))
% %     if (data(i,4) > 0)
% %     resist(i) = data(i,3)./data(i,4)
% %     else
% %     resist(i) = NaN
% %     end
% % end
% % 
% % 
% % % [AX,H1,H2] = plotyy(data(:,1),[resist1(:) resist2(:) resistX(:)],data(:,1),data(:,4));
% % [AX,H1,H2] = plotyy(data(:,1),resistX(:),data(:,1),data(:,5));
% % 
% % 
% % set(get(AX(1),'Ylabel'),'String','Oven resistance (\Omega) (measured at feedthrough)','FontSize',12) 
% % set(get(AX(2),'Ylabel'),'String','Oven current (A)','FontSize',12) 
% % grid on
% % xlabel('time since start (min)','FontSize',12)
% % set(H1,'LineStyle','-','LineWidth',2)
% % set(H2,'LineStyle','-','LineWidth',2,'Color','k')
% % 
% % 
% % xlimits = get(AX(1),'XLim');
% % ylimits = get(AX(1),'YLim');
% % xin = (xlimits(2)-xlimits(1))/5;
% % yin = (ylimits(2)-ylimits(1))/4;
% % set(AX(1),'XTick',[xlimits(1):xin:xlimits(2)],...
% %         'YTick',[ylimits(1):yin:ylimits(2)])
% % xlimits = get(AX(2),'XLim');
% % ylimits = get(AX(2),'YLim');
% % xin = (xlimits(2)-xlimits(1))/5;
% % yin = (ylimits(2)-ylimits(1))/5;
% % set(AX(2),'XTick',[xlimits(1):xin:xlimits(2)],...
% %         'YTick',[0:1:6])
% % 
% %     
% % 
% % %
% % % Power
% % %    
% % 
% % figure(2)
% % 
% % subplot(2,1,2)
% % % [AX,H1,H2] = plotyy(data(:,1),[resist1(:) resist2(:) resistX(:)],data(:,1),data(:,4));
% % [AX,H1,H2] = plotyy(data(:,1),data(:,4).*data(5),data(:,1),data(:,5));
% % 
% % 
% % set(get(AX(1),'Ylabel'),'String','Dissipated power (W)','FontSize',12) 
% % set(get(AX(2),'Ylabel'),'String','Oven current (A)','FontSize',12) 
% % grid on
% % xlabel('time since start (min)','FontSize',12)
% % set(H1,'LineStyle','-','LineWidth',2)
% % set(H2,'LineStyle','-','LineWidth',2,'Color','k')
% % 
% % 
% % xlimits = get(AX(1),'XLim');
% % ylimits = get(AX(1),'YLim');
% % ylimits = ylimits*1.5;
% % set(AX(1),'YLim',ylimits);
% % 
% % xin = (xlimits(2)-xlimits(1))/5;
% % yin = (ylimits(2)-ylimits(1))/4;
% % set(AX(1),'XTick',[xlimits(1):xin:xlimits(2)],...
% %         'YTick',[ylimits(1):0.25:ylimits(2)])
% % xlimits = get(AX(2),'XLim');
% % ylimits = get(AX(2),'YLim');
% % xin = (xlimits(2)-xlimits(1))/5;
% % yin = (ylimits(2)-ylimits(1))/5;
% % set(AX(2),'XTick',[xlimits(1):xin:xlimits(2)],...
% %         'YTick',[0:1:6])
% % 
% % %
% % % Temperature
% % %
% % figure(3)
% % 
% % [AX,H1,H2] = plotyy(data(:,1),data(:,6),data(:,1),data(:,5));
% % 
% % 
% % set(get(AX(1),'Ylabel'),'String','Feedthrough temperature (C)','FontSize',12) 
% % set(get(AX(2),'Ylabel'),'String','Oven current (A)','FontSize',12) 
% % grid on
% % xlabel('time since start (min)','FontSize',12)
% % set(H1,'LineStyle','-','LineWidth',2)
% % set(H2,'LineStyle','-','LineWidth',2,'Color','k')
% % 
% % 
% % xlimits = get(AX(1),'XLim');
% % ylimits = get(AX(1),'YLim');
% % xin = (xlimits(2)-xlimits(1))/5;
% % yin = (ylimits(2)-ylimits(1))/4;
% % set(AX(1),'XTick',[xlimits(1):xin:xlimits(2)],...
% %         'YTick',[ylimits(1):yin:ylimits(2)])
% % xlimits = get(AX(2),'XLim');
% % ylimits = get(AX(2),'YLim');
% % xin = (xlimits(2)-xlimits(1))/5;
% % yin = (ylimits(2)-ylimits(1))/5;
% % set(AX(2),'XTick',[xlimits(1):xin:xlimits(2)],...
% %         'YTick',[0:1:6])