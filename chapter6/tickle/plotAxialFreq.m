
 exV147 = [ -10.2  -8 -8 -9 -7 -6 -5 -4  -8 ];
 exAxialFreq = 1e3 *[ 960.6 868.5 867.8 910.1 827.1 754.1 698.7 633.7 862.4];

% ------------------------------
% Calc Settings
% ------------------------------
rfGain = 22.3;
rfAmp = 5 * rfGain; % V

% dc potentials to use
dcPotStatic = [[0 0 7.28 0 7.28 0 0]; ...
               [0 0 7.28 0 7.28 0 0] ]; % V
dcPotVar = [ [1 0 0 1 0 0 1];
             [1 0 0 1 0 0 1] ];
V147 = linspace(-11, 0);

% -----------------------
% Physical Constants
% -----------------------
massCalcium = 6.65e-26; % kg
chargeCalcium = 1.602e-19; % C

% -----------------------
% Assumed RF Constants
% -----------------------
rfDriveFreq = 2 * pi * 27.25e6; % 1/s
acQuadZ = 5.101e3; % m^-2

for num = 1:length(V147)
    
    dcPot = dcPotStatic + V147(num)*dcPotVar;
    
    % first, convert to CPO basis
    cpo_basis = toCPOBasis(dcPot);
    
    % ----------------------
    % CPO Calculated Parameters
    % ----------------------
    load coeffsax.mat
    dcQuadZ = sum(cpo_basis .* results.quadZ) * 1e12; %convert to m^-2
    
    %pseudopotential
    ppQuadZ = chargeCalcium * rfAmp^2 * acQuadZ^2 / (rfDriveFreq^2 * massCalcium);
    
    totQuadZ = dcQuadZ + ppQuadZ;
    
    wz(num) = sqrt(2 * chargeCalcium * totQuadZ / massCalcium);
    
% % % %     load coeffs_10umGap.mat
% % % %     dcQuadZ = sum(cpo_basis .* results.quadZ) * 1e12; %convert to m^-2
% % % %     
% % % %     %pseudopotential
% % % %     ppQuadZ = chargeCalcium * rfAmp^2 * acQuadZ^2 / (rfDriveFreq^2 * massCalcium);
% % % %     
% % % %     totQuadZ = dcQuadZ + ppQuadZ;
% % % %     
% % % %     wz10(num) = sqrt(2 * chargeCalcium * totQuadZ / massCalcium);
% % % %     
% % % %     load coeffs_1yrf.mat
% % % %     dcQuadZ = sum(cpo_basis .* results.quadZ) * 1e12; %convert to m^-2
% % % %     
% % % %     %pseudopotential
% % % %     ppQuadZ = chargeCalcium * rfAmp^2 * acQuadZ^2 / (rfDriveFreq^2 * massCalcium);
% % % %     
% % % %     totQuadZ = dcQuadZ + ppQuadZ;
% % % %     
% % % %     wz1yrf(num) = sqrt(2 * chargeCalcium * totQuadZ / massCalcium);
% % % %     
% % % %     load coeffs_m1yrf.mat
% % % %     dcQuadZ = sum(cpo_basis .* results.quadZ) * 1e12; %convert to m^-2
% % % %     
% % % %     %pseudopotential
% % % %     ppQuadZ = chargeCalcium * rfAmp^2 * acQuadZ^2 / (rfDriveFreq^2 * massCalcium);
% % % %     
% % % %     totQuadZ = dcQuadZ + ppQuadZ;
% % % %     
% % % %     wzm1yrf(num) = sqrt(2 * chargeCalcium * totQuadZ / massCalcium);
    
end    

% plot(V147, wz10/(2*pi * 1e3), 'b-',...
%      V147, wz/(2*pi * 1e3), 'r--',...
%      V147, wz1yrf/(2*pi * 1e3), 'g:',...
%      V147, wz1yrf/(2*pi * 1e3), 'y-',...
%      exV147, exAxialFreq / 1e3, 'k+')
figure(2)
plot(V147, wz/(2*pi * 1e3), 'r--',...
     exV147, exAxialFreq / 1e3, 'k+',...
     'MarkerSize',8,'LineWidth',1.5)
set(gca,'FontSize',14)
xlabel('Electrode voltage V_{147} (V)')
ylabel('Axial Frequency (kHz)')
legend('Simulation','Tickle Experiment')
xlim([min(V147) max(exV147)*0.5])
% ylim([0 1000])