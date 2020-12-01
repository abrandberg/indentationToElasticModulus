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
clear; close all; clc
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



% Sample error minimization routine
GTL  = 2.51;
nuTT = 0.25;
nuTL = 0.25;

Mexp(1) = 5.85;%4.37; % Pyramidal indenter
Mexp(2) = 2.92;

costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) sqrt(1/2 * sum( (costFcn(x) - Mexp).^2./Mexp));                              
                                
ctrl.optiSolver = 'fmincon';                  
 % Set optimization options
if strcmp(ctrl.optiSolver,'fminunc')
    options = optimoptions(@fminunc,'Display','iter');
    [x,fval,exitflag,output] = fminunc(optiFcn,Mexp',options);

elseif strcmp(ctrl.optiSolver,'fmincon')
	conFcn =  @(x) constraintFmincon([x ; GTL ; nuTT ; nuTL]);
    opts = optimoptions(@fmincon,'Display','iter');       
    [x,fval,exitflag,output] =  fmincon(optiFcn,                ... % Minimization function
                                        Mexp(1:2)',             ... % Starting guess
                                        [],[],[],[],[],[],      ... % Linear equality and inequality constraints
                                        conFcn,                 ... % Non-linear inequality an equality constraints
                                        opts);                      % Solver options
end    
finalState.pyr = x;   


Mexp(1) = 7.70;  % Hemispherical indenter
Mexp(2) = 2.92;

costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
optiFcn = @(x) sqrt(1/2 * sum( (costFcn(x) - Mexp).^2./Mexp));                              
                                
ctrl.optiSolver = 'fminunc';                       
 % Set optimization options
if strcmp(ctrl.optiSolver,'fminunc')
    options = optimoptions(@fminunc,'Display','iter');
    [x,fval,exitflag,output] = fminunc(optiFcn,Mexp',options);

elseif strcmp(ctrl.optiSolver,'fmincon')
	conFcn =  @(x) constraintFmincon([x ; GTL ; nuTT ; nuTL]);
    opts = optimoptions(@fmincon,'Display','iter');       
    [x,fval,exitflag,output] =  fmincon(optiFcn,                ... % Minimization function
                                        Mexp(1:2)',             ... % Starting guess
                                        [],[],[],[],[],[],      ... % Linear equality and inequality constraints
                                        conFcn,                 ... % Non-linear inequality an equality constraints
                                        opts);                      % Solver options
end
finalState.hemi = x;                      
                                

gridSearch(ctrl,optiFcn,Mexp,finalState)



sensitivityToMFA(ctrl)
% This final function probes the sensitivity to MFA/offset. Very slow.