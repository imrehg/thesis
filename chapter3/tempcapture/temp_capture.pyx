#set terminal X11_persist

set terminal eps
set output 'temp_capture_v4.eps'


#set linestyle 1 lines linetype 1 colour blue  linewidth 1.5 
#set linestyle 2 lines linetype 2 colour red   linewidth 1.5
#set linestyle 3 lines linetype 4 colour green linewidth 1.5
#set linestyle 4  colour black points pointtype 1
#set linestyle 5 lines linetype 2 colour blue  linewidth 1.5
#set linestyle 6 lines linetype 7 colour red   linewidth 1.5
set linestyle 1 points pointtype 4  pointsize 1.5 colour red
set linestyle 2 points pointtype 11 pointsize 1.5 colour green
set linestyle 3 points pointtype 6  pointsize 1.5 colour black
set linestyle 4 points pointtype 9  pointsize 1.5 colour blue
set linestyle 5 points pointtype 5  pointsize 1.5 colour green
set linestyle 6 points pointtype 8  pointsize 1.5 colour red
set linestyle 11 lines linewidth 1.5 colour red
set linestyle 12 lines linewidth 1.5 colour green
set linestyle 13 lines linewidth 1.5 colour black
set linestyle 14 lines linewidth 1.5 colour blue
set linestyle 15 lines linewidth 1.5 colour green
set linestyle 16 lines linewidth 1.5 colour red
set linestyle 20 lines linetype 2 linewidth 1.5 colour gray




set fontsize 1

set size 12

set key outside

set x1label 'Ion temperature (K)'
set y1label 'Capture probability ($\%$)'
set xtics 0,100,700

plot [0:700]    'capture_prob_2.txt' t '' using 1:7 with linestyle 11,\
		'capture_prob_2.txt' t '100V' using 1:7 with linestyle 1,\
                'capture_prob_2.txt' t '' using 1:6 with linestyle 12,\
                'capture_prob_2.txt' t '75V' using 1:6 with linestyle 2,\
                'capture_prob_2.txt' t '' using 1:5 with linestyle 13,\
                'capture_prob_2.txt' t '60V' using 1:5 with linestyle 3,\
                'capture_prob_2.txt' t '' using 1:4 with linestyle 14,\
                'capture_prob_2.txt' t '50V' using 1:4 with linestyle 4,\
                'capture_prob_2.txt' t '' using 1:3 with linestyle 15,\
                'capture_prob_2.txt' t '40V' using 1:3 with linestyle 5,\
                'capture_prob_2.txt' t '' using 1:2 with linestyle 16,\
                'capture_prob_2.txt' t '25V' using 1:2 with linestyle 6,\
		'nominal_oven_temp.txt' t '' using 1:2 with linestyle 20

