#set terminal X11_persist

set terminal eps
set output '397sat_v3.eps'


set linestyle 1 points pointtype 10 colour black pointsize 1.2
set linestyle 2 lines linetype 1 colour grey linewidth 1.7


set fontsize 1
set key bottom right


#set size ratio 1
set size 12

set xlabel 'Power on photodiode ($\mu$W)'
set ylabel 'Peak fluorescence (counts/100ms)'
#set x1tics 0,10,45
#set mx1tics 0,5,45
#set y1tics 0,200,1400
#set my1tics 0,100,1400


plot [0:43][0:3200]  'satu_curve_data.dat' t 'Fitted' using 1:2 with linestyle 1,\
	'satu_curve_trend.dat' t 'Trend using average 866nm detuning' using 1:2 with linestyle 2


