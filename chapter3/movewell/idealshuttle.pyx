set terminal eps
set output 'idealshuttle_t3.eps'
#set terminal png
#set output 'idealshuttle_t3.png'

set linestyle 1 lines linetype 2 colour blue linewidth 2
set linestyle 2 lines linetype 1 colour red linewidth 2
set linestyle 3 lines linetype 3 colour black

set nokey

set size 5.5
set size ratio 0.9

set x1tics 0,2,12
set y1tics 0,1,5

set x1label 'Dimensionless time'
set y1label 'Dimensionless distance ($\times 10^4$)'

set font 1.7

plot [0:11.3] 'idealshuttle_t3.dat' using 1:($2/1e4) with linestyle 1,\
     'idealshuttle_t3.dat' using 1:($3/1e4) with linestyle 2,\
     'idealshuttle_t3_end.dat' using 1:($2/1e4) with linestyle 3
	
