function x = obtainStiffnessComponentEstimate(ctrl,Mexp,optiFcn)


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

