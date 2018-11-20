function distcalc(w)

w = 317;  % kHz, trap frequency
w = 2*pi*w*1e3;


kc = 8.988e9;
m = 40*1.66053886e-27;
e = 1.6e-19;

x = (kc*e^2/(m*w^2))^(1/3)*1e6

x/1.88