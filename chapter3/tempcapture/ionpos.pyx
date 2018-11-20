set terminal eps
set output 'ionpos_v2.eps'

set nokey

set linestyle 1 points pointtype 10
set linestyle 2 lines linestyle 1 colour black

set size ratio 1
set size 7

set fontsize 1.7

set x1tics -20,10,20
set y1tics -20,10,20

#set title 'Ionization positions of successfully trapped ions'
set xlabel 'Ionization position, $x$ ($\mu m$)'
set ylabel 'Ionization position, $y$ ($\mu m$)'

set arrow 1 from -19,-19 to -14.5,-14.5
set label 1 "$v_{0}$" at -16.5,-18.5

plot [-21:21][-21:21] 'ionpos.dat' using ($1*1e6):($2*1e6) with linestyle 1,\
		      'ioncircle.dat' using ($1*20):($2*20) with linestyle 2
