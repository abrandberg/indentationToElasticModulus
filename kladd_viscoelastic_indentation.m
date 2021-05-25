clear; close all; clc


addpath(genpath('MM_Tensor'))
format compact



EL = 55;
ET = 10;
GLT = 4;
nuTT = 0;
nuTL = 0;

% Derive the missing shear modulus
GTT = ET/(2*(1+nuTT));
nuTL = nuTL/EL*ET;


% Construct fourth order tensor via MMTensor package
C = makeTransversallyIsotropicStiffnessTensor(EL, ET, GLT, GTT, nuTL);
C11 = getS4Element(C,1,1,1,1);
C12 = getS4Element(C,1,1,2,2);
C13 = getS4Element(C,1,1,3,3);
C33 = getS4Element(C,3,3,3,3);
C44 = getS4Element(C,2,3,2,3);
C31 = sqrt(C11*C33);


CVisc = C;
CVisc = @(t) C + CVisc.*exp(-t/10);

for t = 1:10
    C11 = getS4Element(CVisc(t),1,1,1,1);
    C12 = getS4Element(CVisc(t),1,1,2,2);
    C13 = getS4Element(CVisc(t),1,1,3,3);
    C33 = getS4Element(CVisc(t),3,3,3,3);
    C44 = getS4Element(CVisc(t),2,3,2,3);
    M3 = 2 * sqrt( (C31^2 - C13^2)/(C11) * ( 1/C44 + 2/(C31 + C13) )^-1 )
%     CVisc(t)
end










