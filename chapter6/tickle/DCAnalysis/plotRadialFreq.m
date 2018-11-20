
% Experiment
load expRadialDataXY.mat
rfGain = 21;
exRFAmp = exRFDrive / 2 * rfGain;

% ------------------------------
% Calc Settings
% ------------------------------


rfAmp = linspace(min(exRFAmp), max(exRFAmp)); % V

% dc potentials to use
dcPot = [[-8 0 7.78 -8 7.78 0 -8]; ...
         [-8 0 7.78 -8 7.78 0 -8] ]; % V
dcPot = dcPot + .55 * [[-1 -1 -1 -1 -1 -1 -1]; [1 1 1 1 1 1 1]];


% first, convert to CPO basis
cpo_basis = toCPOBasis(dcPot);

% -----------------------
% Physical Constants
% -----------------------
massCalcium = 6.65e-26; % kg
chargeCalcium = 1.602e-19; % C

% -----------------------
% Assumed RF Constants
% -----------------------
rfDriveFreq = 2 * pi * 27.25e6; % 1/s
acQuadX = 1.4051e7; % m^-2
acQuadY = 1.3913e7; % m^-2

% ----------------------
% CPO Calculated Parameters
% ----------------------
load coeffs.mat
dcQuadX = sum(cpo_basis .* results.quadX) * 1e12; %convert to m^-2
dcQuadY = sum(cpo_basis .* results.quadY) * 1e12;

% Now the calculations
qx = 4 * rfAmp * acQuadX * chargeCalcium / (rfDriveFreq^2 * massCalcium);
qy = 4 * rfAmp * acQuadY * chargeCalcium / (rfDriveFreq^2 * massCalcium);

ax = 8 * dcQuadX * chargeCalcium / (rfDriveFreq^2 * massCalcium);
ay = 8 * dcQuadY * chargeCalcium / (rfDriveFreq^2 * massCalcium);

wx = rfDriveFreq/2 * sqrt(qx.^2 / 2 + ax);
wy = rfDriveFreq/2 * sqrt(qy.^2 / 2 + ay);

plot(rfAmp, wx/(2*pi * 1e6), 'b-',...
     rfAmp, wy/(2*pi * 1e6), 'r--',...
     exRFAmp, exRadialFreq(1,:) / 1e6, 'k+',...
     exRFAmp, exRadialFreq(2,:) / 1e6, 'ko')
xlabel('RF Amplitude (V)')
ylabel('Trap Frequency (MHz)')
legend('x', 'y', 'experiment1', 'experiment2')