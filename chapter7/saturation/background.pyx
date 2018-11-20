#set terminal X11_persist

set terminal eps
set output 'background_v4.eps'


set linestyle 1 points pointtype 10 colour black pointsize 1.2
set linestyle 2 lines linetype 1 colour red linewidth 1.7


set fontsize 1
set nokey


#set size ratio 1
set size 12

set xlabel 'Power on photodiode ($\mu$W)'
set ylabel 'Background scatter (counts/100ms)'
#set x1tics 0,10,45
#set mx1tics 0,5,45
set y1tics 0,200,1400
set my1tics 0,100,1400



plot [0:41][0:1200] 'satu_bg_fit.dat' using 1:2 with linestyle 2,\
		 'satu_bg_data.dat'  using 1:2 with linestyle 1
