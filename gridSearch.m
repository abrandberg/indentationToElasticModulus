function gridSearch(ctrl,optiFcn,Mexp,finalState)
%
% The articles cited are:
% 
% [1] Seidlhofer T, Czibula C, Teichert C, Payerl C, Hirn U, Ulz MH. 
%     A minimal continuum representation of a transverse isotropic viscoelastic pulp fibre based on micromechanical measurements.
%     Mech Mater 2019;135:149–61. https://doi.org/10.1016/j.mechmat.2019.04.012.
%
% [2] Lorbach C, Fischer WJ, Gregorova A, Hirn U, Bauer W.
%     Pulp Fiber Bending Stiffness in Wet and Dry State Measured from Moment of Inertia and Modulus of Elasticity.
%     BioResources 2014;9:5511–28. https://doi.org/10.15376/biores.9.3.5511-5528.
%
%
%
%

fontSize = 10;
legendText = {'Error (Hemi-sphere)','Final state (Hemi-sphere)','Final state (Pyramid)','Seidlhofer et al., 2019','Lorbach et al., 2014, a)','Lorbach et al., 2014, b)'};
xAxisText = '$E_L$ [GPa]';
yAxisText = '$E_T$ [GPa]';

if strcmp(ctrl.interpreter,'tex')
    xAxisText = strrep(xAxisText,'$','');
    yAxisText = strrep(yAxisText,'$','');
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
end

linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize};

                    
% Previous studies
seidlhoferEL = [4.20 3.14 22.94 10.03 21.42 14.94 3.29 9.01]';
lorbachEL_estimate1 = 20.0;          
lorbachEL_estimate2 = 17.0;
                    
% Parametric sweep to examine the state found

    ELTry = linspace(min(Mexp),max(Mexp)*3,1000);
    ETTry = linspace(0.25*min(Mexp),min(Mexp),1000);
    [X,Y] = meshgrid(ELTry,ETTry);

    for aLoop = 1:size(X,1)
        for bLoop = 1:size(Y,2)
            Z(aLoop,bLoop) = optiFcn([X(aLoop,bLoop) Y(aLoop,bLoop)]');
        end
    end

figure('color','w','units','centimeters','OuterPosition',[10 10 16 16]);

contour(X,Y,Z,round(linspace(0.2,max(max(Z)),10),2),'ShowText','off',linePlotInstructions{:}) 
    hold on
    
    plot(finalState.hemi(1),finalState.hemi(2),'ko','MarkerFaceColor','k','MarkerSize',8)
    plot(finalState.pyr(1),finalState.pyr(2),'ks','MarkerFaceColor','k','MarkerSize',8)
    
    
plot(mean(seidlhoferEL).*[1 1],min(Mexp).*[0.25 1],'k--','linewidth',2)
plot(lorbachEL_estimate1.*[1 1],min(Mexp).*[0.25 1],'k-.','linewidth',2)
plot(lorbachEL_estimate2.*[1 1],min(Mexp).*[0.25 1],'k:','linewidth',2)
grid on
legend(legendText,'interpreter',ctrl.interpreter)
xlabel(xAxisText,'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
    
    
% Image export
print([ctrl.workDir filesep 'plots' filesep 'contourOfErrors'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'contourOfErrors'],'-dpdf')
