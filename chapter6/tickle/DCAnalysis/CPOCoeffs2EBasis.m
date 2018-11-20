% Script to convert coeffs from CPO Basis to Electrode Basis

load coeffs.mat

%init
eCoeffs.quadX = zeros(2,7);
eCoeffs.quadY = zeros(2,7);
eCoeffs.quadZ = zeros(2,7);
eCoeffs.linX = zeros(2,7);
eCoeffs.linY = zeros(2,7);
eCoeffs.linZ = zeros(2,7);
eCoeffs.potential = zeros(2,7);

for n = 1:14
    
    z = zeros(2,7); %blank electrode basis
    z(n) = 1; % "turn on" one electrode
    
    zCPO = toCPOBasis(z);
    
    eCoeffs.quadX(n) = sum(zCPO .* results.quadX);
    eCoeffs.quadY(n) = sum(zCPO .* results.quadY);
    eCoeffs.quadZ(n) = sum(zCPO .* results.quadZ);
    eCoeffs.linX(n) = sum(zCPO .* results.linX);
    eCoeffs.linY(n) = sum(zCPO .* results.linY);
    eCoeffs.linZ(n) = sum(zCPO .* results.linZ);
    eCoeffs.potential(n) = sum(zCPO .* results.potential);
    
end