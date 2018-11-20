set terminal eps
set output 'ca40ionlevels_pyx.eps'

set dpi 102
set nogrid
set nokey

set size 9
set size ratio 0.8

set fontsize 2

lw = 2;

# 4S1/2
set arrow 1 from -lw/2, 0 to lw/2, 0 with nohead linewidth 3
set label 1 '4S$_{\frac{1}{2}}$' -lw/2-2, -0.5

# 4P1/2
set arrow 2 from -lw/2, 4*lw to lw/2, 4*lw  with nohead linewidth 3
set label 2 '4P$_{\frac{1}{2}}$' lw/2, 4*lw-0.5

# 4P3/2
set arrow 3 from -lw/2, 5*lw to lw/2, 5*lw with nohead linewidth 3
set label 3 '4P$_{\frac{3}{2}}$' -lw/2-2, 5*lw+0.25

# 3D3/2
set arrow 4 from lw/2-lw*1.5, 2.5*lw to -lw/2-lw*1.5, 2.5*lw with nohead linewidth 3

# 3D5/2
set arrow 5 from -lw/2+lw*1.5, 3.25*lw to lw/2+lw*1.5, 3.25*lw with nohead linewidth 3

## Transitions

# S1/2-P1/2
set arrow 6 from -lw/4, 0 to -lw/4, 4*lw with twoway
# S1/2-P3/2
#set arrow 7 from 0, 0 to 0, 5*lw with twoway
set arrow 7 from lw/4, 0 to lw/4, 5*lw with twoway
# P1/2-D3/2
set arrow 8 from -lw*3/8, lw*4 to lw/4-lw*1.5, lw*2.5 with twoway
# P3/2-D3/2
set arrow 9 from -lw/4, lw*5 to -lw*1.5, 2.5*lw with twoway
# P3/2-D5/2
set arrow 10 from lw*3/8, lw*5 to lw*1.5, 3.25*lw with twoway




set x1label 'invisible:'
set y1label 'invisible:'
set x2label 'invisible:'
set y2label 'invisible:'

#plot [-8:8][-1:20] 2 u (1.0):(2.4) w p pt 1

plot [-10:10][-1:20] 
