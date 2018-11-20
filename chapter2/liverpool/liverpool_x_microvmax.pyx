#set terminal X11_persist

set terminal eps
set output 'liverpool_x_microvmax_v2.eps'


set linestyle 1 lines linetype 1 colour black linewidth 1.7


set nokey
set fontsize 0.9


set size ratio 1
set size 5.5

set xlabel 'Position, z (electrode separation)'
set ylabel 'Micromotion max velocity (m/s)'
set x1tics -2,1,2
set mx1tics -2,0.5,2

set y1tics 0,100,450
set my1tics 0,50,450


plot  [-2.1:2.1][0:500]'liverpool_x_microvmax.dat' using ($1/0.0007525):2 with linestyle 1
