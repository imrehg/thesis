#set terminal X11_persist

set terminal eps
set output 'sample_dopplerpop_v2.eps'


set linestyle 1 lines linetype 1 colour black linewidth 1.7
set linestyle 2 lines linetype 7 colour grey linewidth 1.7


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Doppler shift $\Delta_{\rm D}$ (MHz)'
set ylabel 'Population of P$_{1/2}$ state'
set x1tics -400,200,400
set mx1tics -400,50,400
set y1tics 0,0.02,0.15
set my1tics 0,0.01,0.15



plot [-400:400][0:0.14]    'heating_dopplershift.dat' using 1:2 with linestyle 1,\
	'heating_dopplershift.dat' using 1:3 with linestyle 2
