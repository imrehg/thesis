% Experimental Spike Compensation Analysis

load ExpSpikeCompensationData.mat

for n = 1:length(Vspike)
    
    eVolts = [Vdc(n,:); Vdc(n,:)] + [Vx(n)/2 * ones(1,7); -Vx(n)/2 * ones(1,7)];
    uMotionResults = printUMotion(eVolts);
    Ey(n) = uMotionResults.linY;
    Ex(n) = uMotionResults.linX;
    
end

% do some linear regression
py = polyfit(Vspike, Ey, 1);
px = polyfit(Vspike, Ex, 1);

Vfit = linspace(min(Vspike), max(Vspike));
EyFit = polyval(py, Vfit);
ExFit = polyval(px, Vfit);

plot(Vspike, Ey, 'b+',...
    Vspike, Ex, 'r.',...
    Vfit, EyFit, 'b--',...
    Vfit, ExFit, 'r:')
legend('y-Field', 'x-Field',...
       sprintf('y Fit: %.2g \\mum^{-1}', py(1)),...
       sprintf('x Fit: %.2g \\mum^{-1}', px(1)))
xlabel('V_{spike}')
ylabel('Electric Field (V/\mum)')
    
