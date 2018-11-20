#set terminal X11_persist

set terminal eps
set output 'cooling_fit_v3.eps'


set linestyle 1 points pointtype 10 colour black pointsize 0.5
set linestyle 2 lines linetype 1 colour blue linewidth 3


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Cooling time (ms)'
set ylabel 'Fluorescence counts / 50$\mu$s'
set x1tics 0,10,45
set mx1tics 0,5,45
#set y1tics 0,0.02,0.15
#set my1tics 0,0.01,0.15



plot [-5:45] 'coolingfit_data.dat' using 1:2 with linestyle 1,\
     'coolingfit_fit.dat' using 1:2 with linestyle 2
