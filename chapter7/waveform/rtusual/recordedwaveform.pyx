set terminal eps
set output 'recordedwaveform_v1.eps'


set linestyle 1 lines linetype 1 linewidth 3 colour black
set linestyle 2 lines linetype 1 linewidth 0.75 colour olivegreen


set size 12
set nokey

set xtics 0,10,60
set ytics -10,2,0
set mytics -9,2,0

set xlabel 'Time (ms)'
set ylabel 'Voltage change on electrode \#3 (V)'

set font 1.7


plot [-10:65][-11:1] 'measuredwaveforms.dat' using 1:2 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:3 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:4 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:5 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:6 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:7 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:8 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:9 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:10 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:11 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:12 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:13 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:14 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:15 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:16 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:17 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:18 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:19 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:20 w ls 2 ,\
		   'measuredwaveforms.dat' using 1:21 w ls 2 ,\
		   'measuredwaveforms_compare.dat' using 1:2 w ls 1 


