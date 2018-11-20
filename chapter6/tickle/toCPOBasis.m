function cpoVect = toCPOBasis(electBasis)
% Transforms a 2x7 matrix of potentials in the 'electrode' basis
% for the Sandia trap to the basis that we do CPO calculations in
% and returns a 1x14 vector in this basis.

load cpo_basis.mat

for i = 1:14
    cpoVect(i) = trace(electBasis' * cpoBasis(:,:,i));
end