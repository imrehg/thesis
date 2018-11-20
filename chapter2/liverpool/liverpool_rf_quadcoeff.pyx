#set terminal X11_persist

set terminal eps
set output 'liverpool_rf_quadcoeff_v2.eps'

set linestyle 1 lines linetype 1 colour black linewidth 1.7


set nokey
set fontsize 0.9


set size ratio 1
set size 5.5

set xlabel 'Position, z (electrode separation)'
#set ylabel 'RF axial quadratic coeff. (V/m$^2$)'
set ylabel 'RF quadratic coefficient, b (V/m$^2$)'
set x1tics -2,1,2
set mx1tics -2,1,2
set y1tics 0,1,4


plot  [-2.1:2.1][0:4.5] 'liverpool_rf_quadcoeff.dat' using ($1/0.0007525):($2*1e-4) with linestyle 1
