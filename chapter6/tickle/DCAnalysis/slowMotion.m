% Script to generate a "Dumb" set of potentials to move ions in the Sandia
% Trap.  Includes a minimization of the norm routine.

clear all

%% Setup Parameters
positionSteps = linspace(0, 364, 15);
electrodesToMove = [4 5 6 7]; % which electrode voltages should we try to adjust
electrodeBounds = [-10 10]; % min & max voltages that can be supplied (V)
desiredTrapFreq = 8e5; % desired confining frequency in z, if possible given other constraints
%minTrapFreq = 4e5; % minimum confining frequency in z (Hz)
xzRatio = -0.5; % ratio of trap strength in x to z directions
numElectrodes = 7;

%% Physical Constants
massCalcium = 6.65e-26; % kg
chargeCalcium = 1.602e-19; % C

%% Get initial trapping potential
load coeffsAllZ.mat
quadX = results.quadX;
quadZ = results.quadZ;
linY = results.linY;
linZ = results.linZ;
coeffZPts = results.z;


center = positionSteps(1);
Qz = 1e-12 * massCalcium * 2 * pi^2 * desiredTrapFreq^2 / chargeCalcium;

if center == 0

    resultant = [1; xzRatio; 0] .* Qz;

    % build coeff matrix
    for gNum = 1:4
        mask = zeros(1,numElectrodes);
        mask(gNum) = 1; %electrodes in group
        mask(numElectrodes - gNum + 1) = 1;
        %convert to CPO Basis
        maskCPO = toCPOBasis([mask; mask]);


        % assume electrode symetry about z=0
        coeffsByElectrodeZ = quadZ(1,:);
        coeffsByElectrodeX = quadX(1,:);
        coeffsByElectrodeY = linY(1,:);

        coeffMatrix(1,gNum) = sum(maskCPO .* coeffsByElectrodeZ);
        coeffMatrix(2,gNum) = sum(maskCPO .* coeffsByElectrodeX);
        coeffMatrix(3,gNum) = sum(maskCPO .* coeffsByElectrodeY);
        
    end
    
    voltsByGroup = coeffMatrix\resultant;
    initVolts = zeros(1,numElectrodes);
    for gNum = 1:4
        mask = zeros(1,numElectrodes);
        mask(gNum) = 1; %electrodes in group
        mask(numElectrodes - gNum + 1) = 1;
        initVolts = initVolts + voltsByGroup(gNum) * mask;
    end
        

else
    resultant = [1; xzRatio; 0; 0] .* Qz;

    % interpolate coefficients in z
    coeffsByElectrodeqZ = interp1(coeffZPts, quadZ, center);
    coeffsByElectrodeqX = interp1(coeffZPts, quadX, center);
    coeffsByElectrodelY = interp1(coeffZPts, linY, center);
    coeffsByElectrodelZ = interp1(coeffZPts, linZ, center);

    % build coeff matrix
    for gNum = 1:numElectrodes
        mask = zeros(1,numElectrodes);
        mask(gNum) = 1; %electrodes in group
        %convert to CPO Basis
        maskCPO = toCPOBasis([mask; mask]);

        coeffMatrix(1,gNum) = sum(maskCPO .* coeffsByElectrodeqZ);
        coeffMatrix(2,gNum) = sum(maskCPO .* coeffsByElectrodeqX);
        coeffMatrix(3,gNum) = sum(maskCPO .* coeffsByElectrodelY);
        coeffMatrix(4,gNum) = sum(maskCPO .* coeffsByElectrodelZ);
    end
    
    initVolts = coeffMatrix\resultant;
end

% check max and min
maxOver = max(initVolts) / max(electrodeBounds);
if maxOver > 1
    initVolts = initVolts ./ maxOver;
end
minOver = min(initVolts) / min(electrodeBounds);
if minOver > 1
    initVolts = initVolts./ minOver;
end

volts(1,:) = initVolts;

%% Now, solve for the rest
numGroups = length(electrodesToMove);

moveMask = zeros(1,numElectrodes);
for eNum = 1:numGroups
    moveMask(electrodesToMove(eNum)) = 1;
end
staticMask = ~moveMask;
staticVolts = staticMask .* initVolts;
staticCPO = toCPOBasis([staticVolts; staticVolts]);
    
%resultant = [1; xzRatio; 0; 0] .* Qz;
resultant = [1; xzRatio; 0] .* Qz;
resultant = [resultant; 1];

for center = positionSteps(2:end)
    
    % interpolate coefficients in z
    coeffsByElectrodeqZ = interp1(coeffZPts, quadZ, center);
    coeffsByElectrodeqX = interp1(coeffZPts, quadX, center);
    %coeffsByElectrodelY = interp1(coeffZPts, linY, center);
    coeffsByElectrodelZ = interp1(coeffZPts, linZ, center);

    % build coeff matrix
    for gNum = 1:numGroups
        mask = zeros(1,7);
        mask(electrodesToMove(gNum)) = 1; %electrodes in group
        %convert to CPO Basis
        maskCPO = toCPOBasis([mask; mask]);

        coeffMatrix(1,gNum) = sum(maskCPO .* coeffsByElectrodeqZ);
        coeffMatrix(2,gNum) = sum(maskCPO .* coeffsByElectrodeqX);
        %coeffMatrix(3,gNum) = sum(maskCPO .* coeffsByElectrodelY);
        coeffMatrix(3,gNum) = sum(maskCPO .* coeffsByElectrodelZ);
    end
    
    % get static volt contribution
    coeffMatrix(1,numGroups+1) = sum(staticCPO .* coeffsByElectrodeqZ);
    coeffMatrix(2,numGroups+1) = sum(staticCPO .* coeffsByElectrodeqX);
    %coeffMatrix(3,numGroups+1) = sum(staticCPO .* coeffsByElectrodelY);
    coeffMatrix(3,numGroups+1) = sum(staticCPO .* coeffsByElectrodelZ);
    coeffMatrix(4,:) = [zeros(1,numGroups) 1];

    solution = coeffMatrix\resultant;
    
    %minimize the norm
    freeVectors = null(coeffMatrix);
            
    %get coefficient for free param that minimizes norm
    fVCoeff = -(solution' * freeVectors) ./ sum(freeVectors.^2);
            
    solution = solution + freeVectors * fVCoeff';
    
    newVolts = staticVolts;
    for gNum = 1:numGroups
        newVolts(electrodesToMove(gNum)) = solution(gNum);
    end
    volts = [volts; newVolts];

end

