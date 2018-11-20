function datafit
    
%%
% Data: P397, Signal, BG, HWHM
data = [23.2  2881  664  58.59;
        14.5  2876  423  52.92;
        9.5   2592  281  38.85;
        4.5   2274  127  30.24;
        18    2954  537  52.92;
        8     2539  237  35.7;
        2     1577  54  26.46;
        3     1916  90  26.46;
        40    2886  1137  78.54;
        13    2735  394  42.42;
        7.1   2494  213  35.91;
        16.5  2793  478  48.09;
        11.5  2650  336  44.31;
        30    2902  852  69.09;
        16.5  2688  475  50.82;
        1     1164  32  18.9;];
    
    
P397 = data(:,1);
signal = data(:,2);
bg = data(:,3);
hwhm = data(:,4)



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
hwhmfit = g/2*sqrt(1+2*x/isatest);

Starting=[1 20];
% options=optimset('Display','iter');
options = [];
lm = 50;
Estimateshw=fminsearch(@myfit2,Starting,options,P397(P397<lm),hwhm(P397<lm))
isatesthw = Estimateshw(1);
ghw = Estimateshw(2);
hwhmfit = ghw/2*sqrt(1+4*x/isatest);

figure(2);
subplot(2,2,1);
plot(P397,signal,'.',x,y,[0 41],[scaleest scaleest],'--','MarkerSize',15);
xlim([0 41]);
ylim([0 scaleest+200])
xlabel('397 power measured after trap (\muW)')
ylabel('Fluorescence signal (cts/100ms)')
legend('Measured','Fit','Fitted saturation level','Location','SE')
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


subplot(2,2,4);
plot(P397,hwhm,'.',x,hwhmfit);
% plot(P397,hwhm,'.');
xlim([0 41]);
xlabel('397 power measured after trap (\muW)')
ylabel('HWHM (MHz)')
title(['Fit: I_{sat} = ' num2str(round(isatest*100)/100) '\muW ; \Gamma = ' num2str(ghw) ' MHz']);

%%

figure(3)
plot(P397,signal,'.',x,y,[0 41],[scaleest scaleest],'--','MarkerSize',15);
xlim([0 41]);
ylim([0 scaleest+200])
xlabel('397nm beam power measured after trap (\muW)','FontSize',14)
ylabel('Fluorescence signal (cts/100ms)','FontSize',14)
legend('Measured','Fit','Fitted saturation level','Location','SE')
set(gca,'FontSize',14)
title(['Fluorescence signal; I_{sat} = ' num2str(round(isatest*100)/100) '\muW ; Saturation level = ' num2str(round(scaleest))],'FontSize',14)
set(gca,'YTickLabel',{'0','','1000','','2000','','3000'})
set(gca,'XTick',0:5:40,'XTickLabel',{'0','','10','','20','','30','','40'})

figure(4)
plot(P397,bg,'+',sort(P397),bgfit,'MarkerSize',8);
xlim([0 41]);
xlabel('397nm beam power measured after trap (\muW)','FontSize',14)
ylabel('Background scatter (cts/100ms)','FontSize',14)
title(['Background scatter: BG = ' num2str(round(p(1)*100)/100) 'xP397 + ' num2str(p(2)) ],'FontSize',14)
set(gca,'FontSize',14)
set(gca,'XTick',0:5:40,'XTickLabel',{'0','','10','','20','','30','','40'})


figure(5)
plot(P397,hwhm,'.',x,hwhmfit,'MarkerSize',15);
% plot(P397,hwhm,'.');
xlim([0 41]);
xlabel('397nm beam power measured after trap (\muW)','FontSize',14)
ylabel('HWHM (MHz)','FontSize',14)
title(['Fit: P_{sat} = ' num2str(round(isatest*100)/100) '\muW ; \Gamma = ' num2str(ghw) ' MHz'],'FontSize',14);
set(gca,'FontSize',14)
set(gca,'XTick',0:5:40,'XTickLabel',{'0','','10','','20','','30','','40'})


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

