#set terminal X11_persist

set terminal eps
set output 'dacnoise_v2.eps'


set linestyle 1 lines linetype 1 colour black linewidth 1.7


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Frequency component (kHz)'
set ylabel 'Amplitude (dBm)'
set x1tics 0,100,1000
set mx1tics 0,50,1000

#set title 'RF noise profile - DAC6703 Ch0'

plot [0:1000][-100:-60] 'TRACE456_2.CSV'  using ($1/1e3):2 with linestyle 1
