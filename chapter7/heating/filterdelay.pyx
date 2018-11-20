#set terminal X11_persist

set terminal eps
set output 'filterheating_v4.eps'


set linestyle 1 points pointtype 10 colour red
set linestyle 2 lines linetype 1 colour grey linewidth 1.7
set linestyle 3 points pointtype 8 pointsize 1.5 colour blue
set linestyle 4 lines linetype 1 colour grey linewidth 1.7


set fontsize 1
set key bottom right


#set size ratio 1
set size 12

set xlabel 'Heating delay (ms)'
set ylabel 'Fitted temperature after delay (K)'
set x1tics 0,50,250
set mx1tics 0,25,250



plot [0:270][0:25] 'filterdelay1_fit.dat' t '' using 1:2 with linestyle 2,\
	'filterdelay1.dat' t '' using 1:2:3 with yerrorbar colour red linewidth 2,\
	'filterdelay1.dat' t 'No filter' using 1:2 with linestyle 1,\
 'filterdelay2_fit.dat' t '' using 1:2 with linestyle 4,\
	'filterdelay2.dat' t '' using 1:2:3 with yerrorbar color blue linewidth 2,\
	'filterdelay2.dat' t 'Low-pass filter' using 1:2 with linestyle 3
