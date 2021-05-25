%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AFM-NI: Script for relating the indentation modulus to the elastic constants. 
%
% This code generate the figures of the manuscript
% Estimation of the in-situ elastic constants of wood pulp fibers in freely
% dried paper via AFM experiments
%
% C. Czibula, A. Brandberg, M. J. Cordill, A. Matković, O. Glushko, 
% Ch. Czibula, A. Kulachenko, C. Teichert, U. Hirn
%
% In prep. 2020.
%
% ABOUT:
%  - Throughout this repository, 
%     > D & U refers to the paper by Delafargue & Ulm
%     > V et al. refers to the paper by Vlassak and co-authors
%     > J et al. refers to the paper by Jäger and co-authors
%     > FEM refers to pre-computed finite element solutions. The FEM programs
%       necessary to generate these results can be found in the repository
%
%       https://github.com/abrandberg/femIndentationModel.git
%
%  - The inputs necessary to generate the estimates of indentation modulus
%       in the longitudinal and transverse direction of the fiber, respectively,
%       are calculated using the repository
%
%       https://github.com/abrandberg/nanoindentation.git
%
%  - The raw files necessary as input for the repository above are currently
%       embargoed, pending acceptance of this work. Upon publication, the raw
%       data will be released and a link to the data will be added here.
%
% References:
%[1] Delafargue A, Ulm FJ. 
%    Explicit approximations of the indentation modulus of elastically orthotropic solids for conical indenters.
%    Int J Solids Struct 2004;41:7351–60. https://doi.org/10.1016/j.ijsolstr.2004.06.019.
%[2] Jäger A, Bader T, Hofstetter K, Eberhardsteiner J. 
%    The relation between indentation modulus, microfibril angle, and elastic properties of wood cell walls.
%    Compos Part A Appl Sci Manuf 2011;42:677–85. https://doi.org/10.1016/j.compositesa.2011.02.007.
%[3] Vlassak JJ, Ciavarella M, Barber JR, Wang X.
%    The indentation modulus of elastically anisotropic materials for indenters of arbitrary shape. 
%    J Mech Phys Solids 2003;51:1701–21. https://doi.org/10.1016/S0022-5096(03)00066-8.
%
%
% created by: August Brandberg augustbr at kth dot se
% date: 2020-12-01
%

% Meta instructions
clear;  clc ; %close all;
format compact

ctrl.workDir = cd;
ctrl.interpreter = 'tex';   % tex or latex
ctrl.marker = {'^','o','>','s','<','x'};
ctrl.linewidth = 1.25;

addpath(genpath('MM_Tensor'))

ctrl.optiSolver = 'fminunc'; % fminunc or fmincon. 
% Neither method will generate results that violate the conditions of positive definiteness on the stiffness matrix.
% However, with the "fminunc" method, the condition is checked without using the
% it in the solution process. In the fmincon, the condition is implemented as a
% non-linear constraint.
%
% The methods yield marginally different results. The "fminunc" method is used in the
% manuscript.

colorYes = 1;
if colorYes
    Color = lines(20);
    set(groot,'defaultAxesColorOrder',Color);
else
    Color = [0 0 0];
end
set(groot,'defaultAxesColorOrder',Color);

mkdir('plots')

if 0
compareSolutionScheme(ctrl,[1 1 1]);
% Compare Delafargue & Ulm, Vlassak et al. with the curves from Jäger et al. 


compareIndenters(ctrl);
% Compare spherical and cone indenters

compareWithFEM(ctrl);
% Compare with FEM


evaluateElasticityAssumptionWithFEM(ctrl);
% Evaluate assumption of elasticity with FEM

evaluateAssumptionsWithFEM(ctrl);
% Evaluate assumptions with FEM
end


% Sample error minimization routine
GTL  = 2.51;
nuTT = 0.25;
nuTL = 0.25;




% Pyramidal Indenter, mean
Mexp(1) = 6.9931;%8.9113;
Mexp(2) = 1.5661;
costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));                              
finalState.pyrMean = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn);  

% Pyramidal Indenter, median
Mexp(1) = 4.1755;%6.4216;
Mexp(2) = 1.5751;
costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));                              
finalState.pyrMedian = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn);  



% Nano Indenter, mean
Mexp(1) = 5.7524;
Mexp(2) = 1.5661;
costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));                              
finalState.nanoMean = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn);  

% Nano Indenter, median
Mexp(1) = 6.1501;
Mexp(2) = 1.5661;
costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));                              
finalState.nanoMedian = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn); 



% Hemisphere Indenter, median
Mexp(1) = 3.6693;
Mexp(2) = 1.5661;
costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));                              
finalState.hemiMedian = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn);  

% Hemisphere Indenter, mean
Mexp(1) = 8.5663;
Mexp(2) = 1.5661;
costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));                              
finalState.hemiMean = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn);  

gridSearch_v2(ctrl,optiFcn,Mexp,finalState)



sensitivityToMFA(ctrl)
% This final function probes the sensitivity to MFA/offset. Very slow.