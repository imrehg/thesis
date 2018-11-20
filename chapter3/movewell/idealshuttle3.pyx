set terminal eps
set output 'idealshuttle_t3_volts.eps'

set linestyle 1 lines linetype 2 colour black
set linestyle 2 lines linetype 1 colour blue
set linestyle 3 lines linetype 3 colour black

set key bottom right

set size 11
#set size ratio 0.9

set x1tics 0,2,12
set y1tics -15,5,15

set x1label 'Dimensionless time'
set y1label 'Voltage on electrode (V)'

set font 1.7

#set grid x1y1

plot [0:11.3][-15:15]  'idealshuttle_t3_volts.dat' t 'v4'  using 1:2 with linestyle 1,\
     'idealshuttle_t3_volts.dat' t 'v5' using 1:3 with linestyle 2,\
     'idealshuttle_t3_end.dat' t ''  using 1:($2/1e4*6-15) with linestyle 3
	
