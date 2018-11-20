#set terminal X11_persist

set terminal eps
set output '397detuning_v3.eps'


set linestyle 1 points pointtype 10 colour black pointsize 1.2


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Time of scan (mins)'
set ylabel '397nm laser detuning from mean (MHz)'
#set x1tics 0,10,45
#set mx1tics 0,5,45
#set y1tics 0,200,1400
#set my1tics 0,100,1400


plot  'satu_397drift.dat' using 1:2 with linestyle 1


