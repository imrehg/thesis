set terminal eps
set output 'splitvolts_1.eps'

set linestyle 1 lines linetype 2 colour blue
set linestyle 2 lines linetype 1 colour red
set linestyle 3 lines linetype 3 colour black

#set key bottom left
set key top right

set size 5
set size ratio 0.9

set x1tics 0,50,250
set y1tics -10,5,25

set x1label 'Time ($\mu s$)'
set y1label 'Voltage on electrode (V)'

set font 1.7

plot [0:250][-11:26] 'splitvolts.dat' t 'v4' using ($1*1e6):3 with linestyle 1,\
     'splitvolts.dat' t 'v3,v5' using ($1*1e6):4 with linestyle 2,\
     'splitvolts_end.dat' t ''  using ($1*1e6):2 with linestyle 3
	
