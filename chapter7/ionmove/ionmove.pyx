set terminal eps
set output 'ionmove_v1.eps'

set linestyle 1 points pointtype 6 colour blue
set linestyle 2 points pointtype 8 colour red

set key top left
set width 11


set xlabel 'Voltage difference between electrodes \#1 and \#7 (V)'
set ylabel 'Measured ion position ($\mu$m)'

set font 1.7 

set xtics -4,2,8
set mxtics -5,2,8
set ytics -10,5,20

plot [-5.5:8.5][-10:20] 'ionmove.dat' t 'Horizontal' using 1:2 w ls 1,\
			'ionmove.dat' t 'Vertical' using 1:3 w ls 2
