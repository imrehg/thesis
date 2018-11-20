#set terminal X11_persist
set terminal eps
set output 'dcalib866_v1.eps'

f(x) = a*x+b
fit f() 'dcalib866.dat' using 1:2 via a,b

set width 5
set size ratio 0.8
set fontsize -2
set nokey
set xlabel 'DAC value (mV)'
set ylabel 'Laser frequency (MHz + 345.999THz)'
set xtics -400, 200, 400
set ytics 400, 200, 1800
set title '\bf 866nm calibration'
plot [-400:400][300:1800] 'dcalib866.dat' , f(x) with color grey
