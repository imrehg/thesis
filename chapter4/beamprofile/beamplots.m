function beamplots

b866_1 = load('866_laser_out.csv');
plotdat(b866_1,1)

b866_2 = load('866_after_prism_pair.csv');
plotdat(b866_2,2)

b866_3 = load('866_before_fibre_in.csv');
plotdat(b866_3,3)


b397_1 = load('397_laser_out.csv');
plotdat(b397_1,4)

b397_2 = load('397_after_prism_pair.csv');
plotdat(b397_2,5)

b397_3 = load('397_before_fibre_in.csv');
plotdat(b397_3,6)




function plotdat(data,fign)
    figure(fign);
    mh = max(max(data(:,2)),max(data(:,4)))
    subplot(1,2,1)
    plot(data(:,1)/1000,data(:,2),'LineWidth',2);
    ylim([0 mh]*1.05);
    xlim([min(data(:,1)) max(data(:,1))]/1000);
    xlabel('Horizontal position on detector (mm)','FontSize',13);
    ylabel('Beam power (a.u.)','FontSize',13);
    
    subplot(1,2,2)
    plot(data(:,3)/1000,data(:,4),'LineWidth',2);

    ylim([0 mh]*1.05);
    xlim([min(data(:,3)) max(data(:,3))]/1000)
    xlabel('Vertical position on detector (mm)','FontSize',13);
    ylabel('Beam power (a.u.)','FontSize',13);
    
    
    