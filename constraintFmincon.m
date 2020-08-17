function [c,ceq] = constraintFmincon(matProps)

% Hard-link to the properties
EL = matProps(1);
ET = matProps(2);
GLT = matProps(3);
nuTT = matProps(4);
nuTL = matProps(5);

% Derive the missing shear modulus
GTT = ET/(2*(1+nuTT));

% Construct fourth order tensor via MMTensor package
C = makeTransversallyIsotropicStiffnessTensor(EL, ET, GLT, GTT, nuTL);
C11 = getS4Element(C,1,1,1,1);
C12 = getS4Element(C,1,1,2,2);
C13 = getS4Element(C,1,1,3,3);
C33 = getS4Element(C,3,3,3,3);
C44 = getS4Element(C,2,3,2,3);
C31 = sqrt(C11*C33);

% Check that the matrix is positive definite and follows the other rules of a stiffness/compliance tensor
% The conditions are taken from Ref. [2], p. 327, Equation 5.50.17
c(1) = -C11;
c(2) = -C33;
c(3) = -C44;
c(4) = - (C11 - C12);
c(5) = - (C11^2 - C12^2);
c(6) = - (C11*C33 - C13^2);
c(7) = - (C11^2*C33 + 2*C12*C13^2 - 2*C11*C13^2 - C33*C12^2);

ceq = 0;
