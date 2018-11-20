% data = [ -8     61.73   57.02;
%          -7     60.8    57.08;
%          -6     59.89   57.05;
%          -5     58.57   56.81;
%          -4.5   58.24   56.91;
%          -4     57.77   56.96;
%          -3     56.91   56.91;
%         ];
% 
% volt = data(:,1);
% hpos = data(:,2);
% vpos = data(:,3);
% 
% % subplot(2,1,1);
% plot(volt,hpos,'.',volt,vpos,'o','MarkerSize',6)
% xlim([-8.5 -2.5])
% xlabel('Voltage on #7pair of electrodes (Volts)','FontSize',12);
% ylabel('Fitted position of ion (pixels)','FontSize',12);
% legend('Horizontal','Vertical')
% title('26jul07 - Moving ions along the axis')
% 



%% 
% Ion #3,pics 15-25

% data = [ 8  69.94   57.08;
%          7  68.89   57.08;
%          6  67.84   57.04;
%          5  66.88   57.00;
%          4  65.84   56.96;
%          3  64.84   56.89;
%          2  63.74   56.88;
%          1  62.57   56.85;
%          0  61.33   56.88;
%          0  62.09   56.96;
%          -1 61.06   56.96;
%         ];

data = [ 8  69.94   57.08;
         7  68.89   57.08;
         6  67.84   57.04;
         5  66.88   57.00;
         4  65.84   56.96;
         3  64.84   56.89;
         2  63.74   56.88;
         1  62.57   56.85;
         0  61.33   56.88;
         0     61.73   57.02;
         -1     60.8    57.08;
         -2     59.89   57.05;
         -3     58.57   56.81;
         -3.5   58.24   56.91;
         -4     57.77   56.96;
         -5     56.91   56.91;
        ];
    
scale = 1.93;    
volt = data(:,1);
hpos = data(:,2)*scale;
vpos = data(:,3)*scale;

hpos = hpos - hpos(9);
vpos = vpos - vpos(9);

% subplot(2,1,1);
plot(volt,hpos,'.',volt,vpos,'o','MarkerSize',6)
xlim([-5.5 8.5])
xlabel('Voltage on difference of electrodes #1 and #7 (V1-V7) (Volts)','FontSize',14);
% ylabel('Fitted position of ion (pixels)','FontSize',12);
ylabel('Fitted position of ion (microns)','FontSize',14);
legend('Horizontal','Vertical','Location','NW')
title('26jul07 - Moving ions along the axis [V=(-5,0): ion#2; V=(0,8): ion#3]')

out = [volt(:) hpos(:) vpos(:)];
save 'ionmove.dat' 'out' '-ascii'
