function MIndent = delafargueAndUlmMethod(matProps,indenterType)
%function Mindent = delafargueAndUlmMethod(matProps) calculates the expected indentation
%modulus in the direction parallel and orthogonal to the axis of symmetry of a transversely
%isotropic material.
%
% INPUTS:
% matProps
% matProps(1) - EL
%         (2) - ET 
%         (3) - GLT
%         (4) - nuTT
%         (5) - nuTL
% 
% indenterType - Cone or parabola
%
% OUTPUTS:
% MIndent(1)  - ER for indentation in the axis of symmetry
%        (2)  - ER for indentation normal to the axis of symmetry
%
% created by: August Brandberg augustbr at kth . se
% date: 2020-07-19
%
% References:
% [1] Delafargue, A., & Ulm, F. J. (2004). 
%     Explicit approximations of the indentation modulus of elastically orthotropic solids for conical indenters. 
%     International Journal of Solids and Structures, 41(26), 7351–7360. 
%     https://doi.org/10.1016/j.ijsolstr.2004.06.019
%
% [2] Lai, W. M., Rubin, D., & Krempl, E. (2010). 
%     The Elastic Solid. In Introduction to Continuum Mechanics (pp. 201–352). Elsevier. 
%     https://doi.org/10.1016/B978-0-7506-8560-3.00005-0

% Hard-link to the properties
EL = matProps(1);
ET = matProps(2);
GLT = matProps(3);
nuTT = matProps(4);
nuTL = matProps(5);

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

% Check that the matrix is positive definite and follows the other rules of a stiffness/compliance tensor
% The conditions are taken from Ref. [2], p. 327, Equation 5.50.17
assert(C11 > 0)                 % Diagonal transverse term must be positive
assert(C33 > 0)                 % Diagonal longitudinal term must be positive
assert(C44 > 0)                 % GTT modulus must be positive
assert((C11 - C12) > 0)         % GTL modulus must be positive
assert((C11^2 - C12^2) > 0)     % Determinant of transverse sub-matrix must be positive
assert((C11*C33 - C13^2) > 0)   % Determinant of transverse-longitudinal sub-matrix must be positive
assert((C11^2*C33 + 2*C12*C13^2 - 2*C11*C13^2 - C33*C12^2) > 0) % Determinant of stiffness matrix must be positive definite


% Delafargue & Ulm section

M3 = 2 * sqrt( (C31^2 - C13^2)/(C11) * ( 1/C44 + 2/(C31 + C13) )^-1 );
% Indentation modulus expected when indenting in the axis of symmetry
% EQ-9 in [1]

H2 = 1/(2*pi) * sqrt( C33/(C31^2 - C13^2) * (1/C44 + 2/(C31 + C13)) );
% Solution to Green's function in the direction of X2 (theta = 0)
% EQ-12 in [1]

H3 = 1/pi * C11/(C11^2 - C12^2);
% Solution to Green's function in the direction of X3 (theta = 90)
% EQ-13 in [1]

H0 = 0.5*(H2 + H3);
% Steady state term of the first order approximation to Green's function
% EQ-15a in [1]

HC1 = 0.5*(H2 - H3);
% Oscillating term of the first order approximation to Green's function
% EQ-15b in [1]

eccentricity = sqrt( 2*abs(HC1) / (H0 + abs(HC1)) );
% Contact area ellipse eccentricity
% EQ-20 in [1]

[~,E] = ellipke(eccentricity);
% Evaluation of the complete elliptic integral of the second kind
% Text between EQ-22 and EQ-23 in [1]





if strcmp(indenterType,'Cone')
    M1 = 1/(2*E * H2^(0.75) * H3^(0.25));   % Real form
    M1 = 1/(pi * H2^(0.5) * H3^(0.5));      % Simplified form
elseif strcmp(indenterType,'Sphere')
    M1 = 1/(2*sqrt(2-eccentricity^2) * H2^(0.75) * H3^(0.25));
end


% Indentation modulus expected when indenting normal to the axis of symmetry
% EQ-22 in [1]

% Return
MIndent = [M3 M1]; 

end
