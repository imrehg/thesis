#set terminal X11_persist

set terminal eps
set output 'long_heating_rate_v3.eps'


set linestyle 1 points pointtype 10 colour black
set linestyle 2 lines linetype 1 colour grey linewidth 1.7


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Heating delay (ms)'
set ylabel 'Fitted temperature after delay (K)'
set x1tics 0,100,800
set mx1tics 0,50,800



plot [0:800] 'longheatdelay_fit.txt' using 1:2 with linestyle 2,\
	'longheatdelay.txt' using 1:2:3 with yerrorbar linewidth 2,\
	'longheatdelay.txt' using 1:2 with linestyle 1
