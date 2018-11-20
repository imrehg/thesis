#set terminal X11_persist

set terminal eps
set output 'sample_dedt_v2.eps'


set linestyle 1 lines linetype 1 colour black linewidth 1.7


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Maximum Doppler shift during motional cycle (MHz)'
set ylabel 'd$\epsilon$/d$t$'
set x1tics 0,100,400
set mx1tics 0,50,400
#set y1tics 0,0.02,0.15
#set my1tics 0,0.01,0.15



plot [0:400]    'heating_energychange.dat' using 1:2 with linestyle 1
