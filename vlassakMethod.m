function MIndent = vlassakMethod(matProps,indenterType)
% Hard-link to the properties
El = matProps(1);
Et = matProps(2);
Glt = matProps(3);
nutt = matProps(4);
nutl = matProps(5);
MFA = matProps(6);

% Derive the missing shear modulus
Gtt = Et/(2*(1+nutt));
nutl = nutl/El*Et;

C = makeTransversallyIsotropicStiffnessTensor(El, Et, Glt, Gtt, nutl);
R_AA = makeAngleAxisRotation(MFA, [1 0 0]);
C = rotateS4(C, R_AA);

% Indentation in the longitudinal direction
normalVector = [0 0 1];
[alpha,ecc] = alphaFcn(C,normalVector,indenterType);
Meqv = 1 ./ (alpha * (1 - ecc^2)^0.25);
MIndent(1) = Meqv;

% Next, the transverse one
% normalVector = [1 0 0];  
% [alpha,ecc] = alphaFcn_v3(C,normalVector);
% Meqv = 1 ./ (alpha * (1 - ecc^2)^0.25);
% MIndent(2) = Meqv;


end