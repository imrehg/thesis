#set terminal X11_persist

set terminal eps
set output 'rfminpos_x_v2.eps'


set linestyle 1 lines linetype 1 colour black linewidth 1.7
set linestyle 2 lines linetype 2 colour black linewidth 1.7


set nokey
set fontsize 0.9


set size ratio 1
set size 5.5

set xlabel 'Position, z (electrode separation)'
set ylabel 'RF minimum position, x ($\mu$m)'
set x1tics -2,1,2
set mx1tics -2,1,2

set y1tics -1,0.5,1.5

#set key top left

plot  [-2.1:2.1] 'rfminpos_x.dat' t 'Original trap design' using ($1/0.0007525):($2*1e6) with linestyle 1,\
		 'rfminpos_x.dat' t 'Twisted RF electrode' using ($1/0.0007525):($3*1e6) with linestyle 2
