set terminal eps
set output 'splitvolts_2_v2.eps'

set linestyle 1 lines linetype 1 colour blue
set linestyle 2 lines linetype 2 colour red
set linestyle 3 lines linetype 3 colour black

set nokey

set size 5
set size ratio 0.9

set x1tics 0,50,250
#set y1tics ("-0.5" -0.5, "0" 0)
set y1tics -0.5,0.25,0.5

set x1label 'Time ($\mu s$)'
set y1label 'Ion position (mm)'

set font 1.7

plot [0:250][-0.6:0.6] 'splitvolts.dat' using ($1*1e6):($2*1e3) with linestyle 1,\
     'splitvolts.dat' using ($1*1e6):(-$2*1e3) with linestyle 2,\
     'splitvolts_end.dat' using ($1*1e6):3 with linestyle 3
	
