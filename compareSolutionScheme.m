function compareSolutionScheme(ctrl,modelsToCompare)
%
% 1. Vlassak
% 2. Jäger
% 3. Delafargue
%
% References:
%
% [1] Jäger, A., Bader, T., Hofstetter, K., & Eberhardsteiner, J. (2011). 
%     The relation between indentation modulus, microfibril angle, and elastic properties of wood cell walls. 
%     Composites Part A: Applied Science and Manufacturing, 42(6), 677–685. 
%     https://doi.org/10.1016/j.compositesa.2011.02.007
%
% [2] Delafargue, A., & Ulm, F. J. (2004). 
%     Explicit approximations of the indentation modulus of elastically orthotropic solids for conical indenters. 
%     International Journal of Solids and Structures, 41(26), 7351–7360. 
%     https://doi.org/10.1016/j.ijsolstr.2004.06.019


plotDims = [2 3];
plotDims = [3 2];
    
% Numerical results from Jägers first article.
% Numerical results extracted manually from Figure 4 in [1]
if modelsToCompare(2)
    [ELJager0, ELJager90, ETJager0,ETJager90,GLTJager0,GLTJager90,nuttJager0,nuttJager90,] = importJagerFigure4();
end

legendText = {};
if modelsToCompare(3)
    legendText{end+1} = 'D\&U, $M_L$';
    legendText{end+1} = 'D\&U, $M_T$';
end
if modelsToCompare(1)
    legendText{end+1} = 'V et al, 0$^\circ$';
    legendText{end+1} = 'V et al, 90$^\circ$';    
%     legendText{end+1} = 'Indentation along fiber axis';
%     legendText{end+1} = 'Indentation in transverse direction';    
%     legendText{end+1} = 'Equality';    
end
if modelsToCompare(2)
    legendText{end+1} = 'J et al, 0$^\circ$';
    legendText{end+1} = 'J et al, 90$^\circ$';    
end

fontSize = 10;

if strcmp(ctrl.interpreter,'tex')
    xAxisText = {'E_L [GPa]',    ...
                 'E_T [GPa]',    ...
                 'G_{LT} [GPa]', ...
                 '\nu_{TL} [-]', ...
                 '\nu_{TT} [-]', ...
                 'MFA [Deg]'};
    yAxisText = 'M [GPa]';
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
elseif strcmp(ctrl.interpreter,'latex')
    xAxisText = {'$E_L$ [GPa]',    ...
                 '$E_T$ [GPa]',    ...
                 '$G_{LT}$ [GPa]', ...
                 '$\nu_{TL}$ [-]', ...
                 '$\nu_{TT}$ [-]', ...
                 '$MFA$ [Deg]'};
    yAxisText = '$M$ [GPa]';
end

linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize,                     ...
                        'YMinorGrid',1,'XMinorTick',1};

yLimVals = [5 30];

% Baseline values used in Figure 4
El = 55*1e0;
Et = 10*1e0;
Glt = 3*1e0;
nutl = 0.25;
nutt = 0.25;


ELTry = 1e0*[30:4:80 55];
ETTry = 1e0*[5:15 10];
GLTTry = 1e0*[1:0.5:5 3 ];
nutlTry = [linspace(0,0.49,20) 0.25];
nuttTry = [linspace(0,0.49,20) 0.25];
MFAToTry = [0 90];

% Loop over the values used in [1] to generate comparison.  
figure('color','w','units','centimeters','OuterPosition',[10 10 24 24]);
subplot(plotDims(1),plotDims(2),2)
for aLoop = 1:length(ELTry)
    El = ELTry(aLoop);   

    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;
    
    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end

end
if modelsToCompare(3)
    plot(ELTry,MIndentDU(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
    hold on
    plot(ELTry,MIndentDU(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
end
plot(ELTry,MindentVlassak(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
hold on
plot(ELTry,MindentVlassak(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
xlabel(xAxisText{1},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
if modelsToCompare(2)
    plot(ELJager0(:,1),ELJager0(:,2),'Marker',ctrl.marker{5},linePlotInstructions{:});
    hold on
    plot(ELJager90(:,1),ELJager90(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
end

set(gca,axisPlotInstructions{:})
xlim([20 90])
ylim(yLimVals)
% axis equal
% plot([0 80],[0 80],'k-.')
% legend(legendText,'location','best','interpreter',ctrl.interpreter)
% xlim([0 80])
% ylim([0 80])
pause(0.5)

clear MIndentDU MindentVlassak
subplot(plotDims(1),plotDims(2),1)    
for aLoop = 1:length(ETTry)
    Et = ETTry(aLoop);   
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;

    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end

end
if modelsToCompare(3)
    plot(ETTry,MIndentDU(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
    hold on
    plot(ETTry,MIndentDU(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
end
plot(ETTry,MindentVlassak(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
hold on
plot(ETTry,MindentVlassak(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
xlabel(xAxisText{2},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
if modelsToCompare(2)
    plot(ETJager0(:,1),ETJager0(:,2),'Marker',ctrl.marker{5},linePlotInstructions{:});
    plot(ETJager90(:,1),ETJager90(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
end

set(gca,axisPlotInstructions{:})
xlim([3 18])
ylim(yLimVals)
pause(0.5)


clear MIndentDU MindentVlassak
subplot(plotDims(1),plotDims(2),3)  
for aLoop = 1:length(GLTTry)
    Glt = GLTTry(aLoop);  
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;

    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end
end
if modelsToCompare(3)
    plot(GLTTry,MIndentDU(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
    hold on
    plot(GLTTry,MIndentDU(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
end

plot(GLTTry,MindentVlassak(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
hold on
plot(GLTTry,MindentVlassak(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
if modelsToCompare(2)
    plot(GLTJager0(:,1),GLTJager0(:,2),'Marker',ctrl.marker{5},linePlotInstructions{:});
    hold on
    plot(GLTJager90(:,1),GLTJager90(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
end
xlabel(xAxisText{3},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)

set(gca,axisPlotInstructions{:})
xlim([0 6])
ylim(yLimVals)
pause(0.5)

clear MIndentDU MindentVlassak
subplot(plotDims(1),plotDims(2),4)
for aLoop = 1:length(nutlTry)
    nutl = nutlTry(aLoop);
    
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;

    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end
end
if modelsToCompare(3)
    plot(nutlTry,MIndentDU(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
    hold on
    plot(nutlTry,MIndentDU(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
end
plot(nutlTry,MindentVlassak(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
hold on
plot(nutlTry,MindentVlassak(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
xlabel(xAxisText{4},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)

set(gca,axisPlotInstructions{:})
xlim([0 0.6])
ylim(yLimVals)
pause(0.5)
 
clear MIndentDU MindentVlassak
subplot(plotDims(1),plotDims(2),5)
for aLoop = 1:length(nuttTry)
    nutt = nuttTry(aLoop); 
    Gtt = Et/(2*(1+nutt));
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;
    
    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end
end
if modelsToCompare(3)
    plot(nuttTry,MIndentDU(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
    hold on
    plot(nuttTry,MIndentDU(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
end
plot(nuttTry,MindentVlassak(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
hold on
plot(nuttTry,MindentVlassak(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
xlabel(xAxisText{5},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
if modelsToCompare(2)
    plot(nuttJager0(:,1),nuttJager0(:,2),'Marker',ctrl.marker{5},linePlotInstructions{:});
    hold on
    plot(nuttJager90(:,1),nuttJager90(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
end
legend(legendText,'location','best','interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
xlim([0 1.0])
ylim(yLimVals)
pause(0.5)

clear MindentVlassak
Et = 10;
El = 55;
Glt = 3;
nutt = 0.25;
nutl = 0.25;
Gtt = Et/(2*(1+nutt));
MFAToTry = [0:5:90];
for aLoop = 1:length(MFAToTry)
    MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(aLoop)],'Cone');
    MindentVlassak(aLoop) = MIndent(1);
end
subplot(plotDims(1),plotDims(2),6)
plot([MFAToTry],MindentVlassak,'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on

legend('V et al.','location','best','interpreter',ctrl.interpreter)
xlabel(xAxisText{6},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
xlim([-10 100])
ylim(yLimVals)   
pause(0.5)    
    
    


% Image export
print([ctrl.workDir filesep 'plots' filesep 'compareSolutionScheme'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'compareSolutionScheme'],'-dpdf')
% print([ctrl.workDir filesep 'plots' filesep 'compareSolutionSchemeBW'],'-dpng','-r0')
% export_fig compareSolutionScheme -r600 -png -jpg -tiff

