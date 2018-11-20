function fibrepolarization

%   Columns:
%   1 - ordering
%   2 - time (s)
%   3,4 - the two channel values

d1 = load('10_09_2007 09_39_18.408.txt');
%d1 = load('no2_2.txt');
d2 = load('10_09_2007 13_25_11.018_866polarization3tweaked.txt');
%d2 = load('10_09_2007 12_11_46.575.txt');

plotpol(d1,1,[5 45],'397nm beam fibre output')
plotpol(d2,2,[0 40],'866nm beam fibre output')


function plotpol(data,fig,lims,tit);
    t = data(:,2);
    tmin = t/60;
    c1 = data(:,3);
    c2 = data(:,4);
    inte = c1+c2;
    ang = acos(sqrt(c1./inte))/pi*180;
    
    h1 = figure(fig);
    x1 = subplot(1,2,1)
    h2 = get(h1,'CurrentAxes');
    h3 = axes('position',[.5 .2 .35 .35]);
    
    plot(tmin-lims(1),inte/max(inte));
    xlim(lims-lims(1))
    
%     set(h1,'CurrentAxes',h2)
%     hold on; plot(tmin-lims(1),inte/max(inte),'g');

    set(h1,'CurrentAxes',h3)
    hold on; plot(tmin-lims(1),linspace(0,1,length(tmin)),'r');
    
    xlabel('Time (min)','FontSize',13)
    ylabel('Total intensity (a.u.)','FontSize',13);
    title(tit,'FontSize',15)
    
    subplot(1,2,2)
    plot(tmin-lims(1),ang-median(ang));
    xlim(lims-lims(1))
    
    xlabel('Time (min)','FontSize',13)
    ylabel('Relative polarization (degree)','FontSize',13)

