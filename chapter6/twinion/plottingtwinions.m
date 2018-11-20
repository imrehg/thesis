load 230807_8_reduced.mat;

imagebw(frm18sum1-frm18bgsum);
axis equal;
% xlim([1 100])
% ylim([1 100])

a = 45;
x1 = 24;
y1 = 29;
xlim([x1 x1+a])
ylim([y1 y1+a])
set(gca,'FontSize',14)
xlabel('X (pixels)');
ylabel('Y (pixels)');


% twinion2dfit(frm18sum1, frm18bgsum,0,30,30,'eev');
