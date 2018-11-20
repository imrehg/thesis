
clear gexp;
pars = [0 10 -10 20 0 20 10 10 20 0 20];

n = 100
x = linspace(-50,50,n);
y = linspace(-50,50,n);
for j = 1:n
    for k = 1:n
        gexp(j,k) = pars(1) + pars(2) * ( (exp( -(x(j) - pars(3)).^2/pars(4) )')*exp( -(y(k) - pars(5)).^2/pars(6) ) ) + pars(7) * ( (exp( -(x(j) - pars(8)).^2/pars(9) )')*exp( -(y(k) - pars(10)).^2/pars(11) ) );
    end
end


figure(4)
plot(x,gexp(:,floor(n/2)))

imageblu(gexp);
axis square;