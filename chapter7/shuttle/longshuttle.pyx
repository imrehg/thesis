set terminal eps
set output 'longshuttle_v1.eps'

set nokey

set linestyle 1 lines linewidth 1 colour blue
set size 12

set fontsize 1.7

set xlabel 'Time (s)'
set ylabel 'Fluorescence rate (counts/10ms)'

set xtics 0,1,10
set mxtics 0.5,1,10
set ytics 0,50,300

plot 'SHUTTLE.002' using ($1/100):($2+$3) w ls 1
