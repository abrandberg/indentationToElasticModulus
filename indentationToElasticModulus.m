%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AFM-NI: Script for relating the indentation modulus to the elastic constants. 
%
%
%

% Meta instructions
clear; close all; clc
format compact



compareSolutionScheme();
% Compare Delafargue & Ulm, Vlassak et al. with the curves from Jäger et al. 


compareIndenters();
% Compare spherical and cone indenters



% Sample error minimization routine
GTL  = 2.51;
nuTT = 0.25;
nuTL = 0.25;

Mexp(1) = 10;
Mexp(2) = 2.5;

costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL]);
optiFcn = @(x) sqrt(1/2 * sum( (costFcn(x) - Mexp).^2));


conFcn =  @(x) constraintFmincon([x ; GTL ; nuTT ; nuTL]);
opts = optimoptions(@fmincon,'Display','iter');       
[x,fval,exitflag,output] =  fmincon(optiFcn,                ... % Minimization function
                                    Mexp(1:2)',             ... % Starting guess
                                    [],[],[],[],[],[],      ... % Linear equality and inequality constraints
                                    conFcn,                 ... % Non-linear inequality an equality constraints % OBS OBS OBS OBS OBS OBS 
                                    opts);                      % Solver options


                                
                                
                                
                                
                                
                                
                                