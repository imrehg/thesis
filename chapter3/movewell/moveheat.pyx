
set terminal eps
set output 'moveheat.eps'
#set terminal png
#set output 'moveheat.png'


set logscale y1
set key

set size 12
set grid x1y1

set linestyle 1 lines linetype 1 linewidth 2
set linestyle 2 lines linetype 2 linewidth 2
set linestyle 3 lines linetype 7 linewidth 2

set fontsize 1.7

set xlabel 'Dimensionless shuttle time / $2\pi$  ($t \omega / 2 \pi$)'
set ylabel 'Residual motional energy ($E/\hbar\omega$)'

#plot [12.6:120][1e-5:1e6] 'heatingcalc.dat' t '0.9' using ($1*6.28):2 with linestyle 1,\
#     'heatingcalc.dat' t '0.95' using ($1*6.28):7 with linestyle 2,\
#     'heatingcalc.dat' t '0.99' using ($1*6.28):11 with linestyle 3

plot [2:20][1e-5:1e6] 'heatingcalc.dat' t '0.9' using 1:2 with linestyle 1,\
     'heatingcalc.dat' t '0.95' using 1:7 with linestyle 2,\
     'heatingcalc.dat' t '0.99' using 1:11 with linestyle 3

