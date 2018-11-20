% 10th Feb 2006 Data - Comparison with pyrometer.
I1 = [1.09;2.4;4.02;5;5.52;6.03;5.99;NaN;7.14;7.68;8.53;8.545]; % Current in Amps
V1 = [0.053;0.125;0.223;0.290;0.327;0.364;0.360;NaN;0.444;0.480;0.5295;0.5265]; % Voltage in Volts
Htc1 = [026;059;121;164;187;206;212;236;260;282;311;310]; % Temp in Celcius
Hpb1 = [NaN;NaN;NaN;NaN;NaN;NaN;331;361;402;432;NaN;(456+484)/2]; % Pyrometer Temp: best
Hpl1 = [NaN;NaN;NaN;NaN;NaN;NaN;322;352;382;417;NaN;456]; % Pyrometer Temp: low bound
Hph1 = [NaN;NaN;NaN;NaN;NaN;NaN;349;388;422;452;NaN;484]; % Pyrometer Temp: high bound

% 22nd Feb 2006 Data
I2 = [4.02;4.98;5.99;5.44;4.50;4.01;3.51;5.96;6.00;8.03;7.48;5.30;6.00];
V2 = [0.215;0.280;0.350;0.313;0.249;0.217;0.186;0.350;0.353;0.502;0.461;0.304;0.353];
Htc2 = [125;170;212;191;152;130;109;212;212;294;278;186;215];
Hpb2 = [NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;468;429;NaN;NaN];
Hpl2 = [NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;459;422;NaN;NaN];
Hph2 = [NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;NaN;476;438;NaN;NaN];



figure1 = figure('Color',[1 1 1], 'Visible','on');
figure(figure1);
axes1 = axes('Parent',figure1);
title(axes1, 'Figure 1: Converting between Pyrometer and Thermocouple Temperatures');
hold on
h1 = plot(axes1, Htc1, Hpb1, 'rx', 'MarkerSize',8);
plot(axes1, [Htc1 Htc1; ]', [Hpl1 Hph1]', 'r-');
h2 = plot(axes1, Htc2, Hpb2, 'ro');
plot(axes1, [Htc2 Htc2; ]', [Hpl2 Hph2]', 'r-');
% Add in a point at room temperature (19 Celcius) where the thermocouple
% can be assumed to be accurate (because it is all at the same
% temperature.)
h19 = plot(axes1, 19, 19, 'r.', 'MarkerSize',6);
[p1,S1] = polyfit([212 236 260 282 310 294 278 20], [331 361 402 432 0.5*(456+484) 468 429 20], 1);
[newy1,delta1] = polyval(p1,[0:10:350],S1);
plot(axes1, [0:10:350], newy1, 'r')
plot(axes1, [0:10:350], newy1+delta1, 'r:')
plot(axes1, [0:10:350], newy1-delta1, 'r:')
legend([h1;h2;h19], 'Pyrometer Temperature/Celcius (10th Feb)', ...
  'Pyrometer Temperature/Celcius (22nd Feb)', 'Room Temperature', 'Location','NW')
xlabel(axes1, 'Thermocouple-Measured Temperature / Celsius');
grid on
hold off

% Convert thermocouple temperatures to pyrometer temperatures.
[Hcon1,deltacon1] = polyval(p1,[Htc1],S1);
[Hcon2,deltacon2] = polyval(p1,[Htc2],S1);


figure2 = figure('Color',[1 1 1], 'Visible','on');
figure(figure2);
set(figure2,'DefaultAxesColorOrder',[1 0 0; 0 1 0; 0 0 1]);
axes2 = axes('Parent',figure2);
%title(axes2, 'Figure 2: Properties of Oven as Functions of Current');
hold on
plot(axes2, I1, [10000*V1./I1], 'bx', 'MarkerSize',8)
plot(axes2, I1, [V1*1000], 'go')
plot(axes2, I1, [Hcon1 ], 'rs')

plot(axes2, I2, [10000*V2./I2], 'bx', 'MarkerSize',8)
plot(axes2, I2, [V2*1000], 'go')
plot(axes2, I2, [Hcon2 ], 'rs')
% % % plot(axes2, [I1 I1]', [Hcon1+deltacon1 Hcon1-deltacon1]', 'r-')
% % % plot(axes2, [I2 I2]', [Hcon2+deltacon2 Hcon2-deltacon2]', 'r-')
% Fit a line to the temperature.
% Weed out any NaNs that are in the data, corresponding to missed readings.
% Also remove data for I < 2A, because we only want to work in the linear
% regime.
forFit2 = [[Hcon1;Hcon2;Hcon1+deltacon1;Hcon2+deltacon2;Hcon1-deltacon1;Hcon2-deltacon2] [I1;I2;I1;I2;I1;I2]];
forFit2 = forFit2(isfinite(forFit2(:,2)) & (forFit2(:,2)>2),:);
[p2,S2] = polyfit(forFit2(:,2), forFit2(:,1), 1);
[newy2,delta2] = polyval(p2,[2:0.001:9],S2);
plot(axes2, [2:0.001:9], newy2, 'r')
% Fit a curve to the voltage.
% Weed out any NaNs that are in the data, corresponding to missed readings.
forFit3 = [[1000*V1;1000*V2] [I1;I2]];
forFit3 = forFit3(isfinite(forFit3(:,2)),:);
[p3,S3] = polyfit(forFit3(:,2), forFit3(:,1), 2);
[newy3,delta3] = polyval(p3,[0:0.05:9],S3);
plot(axes2, [0:0.05:9], newy3, 'g')
% Fit a curve to the resistance.
% Weed out any NaNs that are in the data, corresponding to missed readings.
forFit4 = [[10000*V1./I1;10000*V2./I2] [I1;I2]];
forFit4 = forFit4(isfinite(forFit4(:,2)),:);
[p4,S4] = polyfit(forFit4(:,2), forFit4(:,1), 2);
[newy4,delta4] = polyval(p4,[0:0.05:9],S4);
% Plot voltage fit / current rather than an independent voltage fit.  Start
% at 1A to avoid divide by zero.
[newy5,delta5] = polyval(p3,[1:0.05:9],S3);
plot(axes2, [0:0.05:9], newy4, 'b')
legend('Resistance / (10^{-4} Ohms) ', 'Applied Voltage / mV', 'Temperature / Celcius', ...
        'Location','SE')
% Note that the temperature uncertainty comes from the scatter only, in the
% pyrometer/thermocouple temperature conversion.
xlabel(axes2, 'Current / A');
grid on
hold off



figure(5)
ia = 5;
ib = 7.25;
I = [2:0.001:9];
T = newy2;
% I = [I1(:)'];
% T = [Htc1(:)'];

disp('Newrun');
T = T(~isnan(I))
I = I(~isnan(I))
p = polyfit(I,T,2)
ii = linspace(ia,ib);
tt = polyval(p,ii);
T0 = 0;
plot(I,T+T0,'.',ii,tt+T0)





