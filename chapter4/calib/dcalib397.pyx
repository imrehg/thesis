#set terminal X11_persist
set terminal eps
set output 'dcalib397_v1.eps'

f(x) = a*x+b
fit f() 'dcalib397.dat' using 1:2 via a,b

set width 5
set size ratio 0.8
set fontsize -2
set nokey
set xlabel 'DAC value (mV)'
set ylabel 'Laser frequency (MHz + 755.222THz)'
set xtics -2000, 1000, 2000
set ytics 0, 200, 1200
set title '\bf 397nm calibration'
plot [-2700:2700][0:1300] 'dcalib397.dat' , f(x) with color grey
