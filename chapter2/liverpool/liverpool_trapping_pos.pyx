#set terminal X11_persist

set terminal eps
set output 'liverpool_trapping_pos_v2.eps'


set linestyle 1 lines linetype 2 colour black linewidth 1.7
set linestyle 2 lines linetype 1 colour red linewidth 1.7


set fontsize 0.9
set key bottom right


set size ratio 1
set size 5.5

set xlabel 'Position, z (electrode separation)'
set ylabel 'Overall trapping position'
set x1tics -2,1,2
set mx1tics -2,0.5,2

set y1tics -2,1,2
set my1tics -2,0.5,2

eseparation = 0.0007525

plot  [-2.1:2.1][-2.1:2.1] 'rftrapdistort.dat' t 'DC only'  using ($1/eseparation):($1/eseparation) with linestyle 1,\
		 'rftrapdistort.dat' t 'DC + RF'  using ($1/eseparation):($2/eseparation) with linestyle 2
