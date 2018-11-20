#set terminal X11_persist

set terminal eps
set output 'firstlight_v2.eps'


set linestyle 1 lines linetype 1 colour black linewidth 1


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Time (s)'
set ylabel 'PMT count rate ($10^4$ counts/s)'
#set x1tics 0,10,45
#set mx1tics 0,5,45
#set y1tics 0,200,1400
#set my1tics 0,100,1400


plot [0:195] 'HOPE.000' using ($1*0.1):($2*1e-3) with linestyle 1

