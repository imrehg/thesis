set terminal eps
set output 'shuttlewaveform_v1.eps'
#set output 'shuttlewaveform_v2.eps'


set linestyle 1 lines linetype 1 linewidth 2 colour blue
set linestyle 2 lines linetype 2 linewidth 2 colour black
set linestyle 3 lines linetype 7 linewidth 2 colour olivegreen
set linestyle 4 lines linetype 4 linewidth 2 colour red


set size 11
set key outside
#set key top right
#set size 14

set xtics 0,50,350
set ytics -8,2,8
set mytics -7,2,7

set xlabel 'Shuttle distance from trap centre ($\mu$m)'
set ylabel 'Voltage on DC electrode'

set font 1.7


plot [0:360][-9:9] 'rtusual.dat' t '\#1' using 1:2 w ls 1,\
                   'rtusual.dat' t '\#2' using 1:3 w ls 2,\
                   'rtusual.dat' t '\#3' using 1:4 w ls 3,\
                   'rtusual.dat' t '\#4 (centre)' using 1:5 w ls 4
