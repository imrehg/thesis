#set terminal X11_persist

set terminal eps
set output 'vcalc_allelectrodes.eps'


set linestyle 1 lines linetype 1 colour blue  linewidth 1.5
set linestyle 2 lines linetype 2 colour red   linewidth 1.5
set linestyle 3 lines linetype 4 colour green linewidth 1.5
set linestyle 4  colour black points pointtype 1
set linestyle 5 lines linetype 2 colour blue  linewidth 1.5
set linestyle 6 lines linetype 7 colour red   linewidth 1.5
set linestyle 7  colour green points pointtype 2

set nokey

set fontsize 1

set size 12

set key outside

set x1label 'Potential well position (electrode separation units)'
set y1label 'Voltage on electrode (V)'


set label 1 'V1' at -2.3, -5
set label 2 'V2' at -2.3, -12
set label 3 'V3' at -2.3, 14
set label 4 'V4' at -2.3, 4
set label 5 'V5' at 2.05, 14
set label 6 'V6' at 2.05, -12
set label 7 'V7' at 2.05, -5


plot [-2.5:2.5] 'vcalc_allelectrodes.dat' t 'V1' using ($1/0.0007525):2 with linestyle 1,\
                'vcalc_allelectrodes.dat' t 'V2' using ($1/0.0007525):3 with linestyle 2,\
                'vcalc_allelectrodes.dat' t 'V3' using ($1/0.0007525):4 with linestyle 3,\
                'vcalc_allelectrodes.dat' t 'V4' using ($1/0.0007525):5 with linestyle 4,\
                'vcalc_allelectrodes.dat' t 'V5' using ($1/0.0007525):6 with linestyle 5,\
                'vcalc_allelectrodes.dat' t 'V6' using ($1/0.0007525):7 with linestyle 6,\
                'vcalc_allelectrodes.dat' t 'V7' using ($1/0.0007525):8 with linestyle 7
