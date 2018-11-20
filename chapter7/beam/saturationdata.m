function saturationdata
fbase = 'satur';
din = [
       3   6.95;
       4   9.40;
       5   4.00;
       6  20.20;
       7  12.30;
       9   5.80;
       10  2.80;
       11  1.00;
       12  3.13;
       13  0.60;   %%% WHAT HAPPENED HERE???
       14  4.00;
       15  5.00;
       16  2.00;
       ];
    


flist = din(:,1);

for k = 1:length(flist)
    fnum = flist(k);
    scan = load([fbase '.' sprintf('%.3d',fnum)]);
    backdata = scan(101:200,3)+scan(101:200,4)
    backg(k) = mean(backdata)
    sigdata = scan(1:100,4)+scan(1:100,4)-backg(k);
    sig(k) = max(sigdata);
end



data = [din(:,2) sig(:) backg(:) ]



P397 = data(:,1);
signal = data(:,2);
bg = data(:,3);
%
% hwhm = data(:,4);



Starting=[1 2000];
% options=optimset('Display','iter');
options = [];
Estimates=fminsearch(@myfit,Starting,options,P397,signal)

scaleest = Estimates(2);
isatest = Estimates(1);
x = linspace(0,40);
y = 4*scaleest*(x/isatest)./(1+4*x/isatest);

p = polyfit(P397,bg,1);
bgfit = polyval(p,sort(P397));

g = 22;
% % hwhmfit = g/2*sqrt(1+2*x/isatest);

Starting=[1 20];
% options=optimset('Display','iter');
options = [];
lm = 50;
% % 
% Estimateshw=fminsearch(@myfit2,Starting,options,P397(P397<lm),hwhm(P397<lm))
% isatesthw = Estimateshw(1);
% ghw = Estimateshw(2);
% hwhmfit = ghw/2*sqrt(1+4*x/isatest);

figure(2);
subplot(2,2,1);
plot(P397,signal,'.',x,y,[0 41],[scaleest scaleest],'--','MarkerSize',15);
xlim([0 41]);
ylim([0 scaleest+200])
xlabel('397 power measured after trap (\muW)')
ylabel('Fluorescence signal (cts/100ms)')
legend('Measured','Fit','Fitted saturation level','Location','SouthEast')
title(['Fluorescence signal; I_{sat} = ' num2str(round(isatest*100)/100) '\muW ; Saturation level = ' num2str(round(scaleest))])


subplot(2,2,2)
plot(P397,bg,'+',sort(P397),bgfit);
xlim([0 41]);
xlabel('397 power measured after trap (\muW)')
ylabel('Background scatter (cts/100ms)')
title(['Background scatter fit: BG = ' num2str(round(p(1)*100)/100) 'xP397 + ' num2str(p(2)) ])

subplot(2,2,3);
plot(P397,signal./bg,'s');
xlim([0 41]);
xlabel('397 power measured after trap (\muW)')
ylabel('Signal/Background ratio')


% subplot(2,2,4);
% plot(P397,hwhm,'.',x,hwhmfit);
% % plot(P397,hwhm,'.');
% xlim([0 41]);
% xlabel('397 power measured after trap (\muW)')
% ylabel('HWHM (MHz)')
% title(['Fit: I_{sat} = ' num2str(round(isatest*100)/100) '\muW ; \Gamma = ' num2str(ghw) ' MHz']);



figure(3)
plot(P397,signal,'.',x,y,[0 41],[scaleest scaleest],'--','MarkerSize',15,'LineWidth',1.5);
set(gca,'FontSize',14)
xlim([0 31]);
ylim([0 scaleest+200])
xlabel('397 power measured after trap, P397 (\muW)')
ylabel('Fluorescence (counts/100ms)')
% legend(4,'Measured','Fit','Fitted saturation level')
legend('Measured','Fit','Fitted saturation level','Location','SouthEast')
title(['Fluorescence signal; P_{sat} = ' num2str(round(isatest*100)/100) '\muW ; Saturation level = ' num2str(round(scaleest)) ' counts/100ms'])

figure(4)
plot(P397,bg,'+',sort(P397),bgfit,'MarkerSize',9,'LineWidth',1.2);
set(gca,'FontSize',14)
xlim([0 21]);
xlabel('397 power measured after trap, P397 (\muW)')
ylabel('Fitted background, BG (counts/100ms)')
title(['Background vs. laser power: BG = ' num2str(round(p(1)*100)/100) 'xP397 + ' num2str(p(2)) ])

% figure(5)
% plot(P397,hwhm,'.',x,hwhmfit);
% % plot(P397,hwhm,'.');
% xlim([0 41]);
% xlabel('397 power measured after trap (\muW)')
% ylabel('HWHM (MHz)')
% title(['Fit: I_{sat} = ' num2str(round(isatest*100)/100) '\muW ; \Gamma = ' num2str(ghw) ' MHz']);
% 



function sse=myfit(params,Input,Actual_Output)
isat=params(1);
maxc=params(2);
Fitted_Curve=4*maxc.*(Input./isat)./(1+4*Input./isat);
Error_Vector=Fitted_Curve - Actual_Output;
% When curvefitting, a typical quantity to
% minimize is the sum of squares error
sse=sum(Error_Vector.^2);
% You could also write sse as
% sse=Error_Vector(:)'*Error_Vector(:);


function sse=myfit2(params,Input,Actual_Output)
% isat=params(1);
% g = 22;
isat=params(1);
g =params(2);
Fitted_Curve = g/2*sqrt(1+4*Input/isat);
Error_Vector=Fitted_Curve - Actual_Output;
% When curvefitting, a typical quantity to
% minimize is the sum of squares error
sse=sum(Error_Vector.^2);
% You could also write sse as
% sse=Error_Vector(:)'*Error_Vector(:);



