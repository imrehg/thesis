function chisq = gaussfun2d2(pars)
% generate 2D Gaussian surface for fitting


global FitData 
dataSize=size(FitData);
gexp = pars(1) + pars(2) * ( (exp( -([1:dataSize(1)] - pars(3)).^2/pars(4) )')*exp( -([1:dataSize(2)] - pars(5)).^2/pars(6) ) ) + pars(7) * ( (exp( -([1:dataSize(1)] - pars(8)).^2/pars(9) )')*exp( -([1:dataSize(2)] - pars(10)).^2/pars(11) ) );
chisq = sqrt(sum(sum((gexp - FitData).^2)));
%chisq = norm(gexp-FitData);
