function compareIndenters(ctrl)


legendText = {};
legendText{end+1} = 'D\&U, $M_L$, cone';
legendText{end+1} = 'D\&U, $M_T$, cone';

legendText{end+1} = 'V et al. $M_L$, cone';
legendText{end+1} = 'V et al. $M_T$, cone';

legendText{end+1} = 'V et al. $M_L$, sphere';
legendText{end+1} = 'V et al. $M_T$, sphere';    

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


linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize,                     ...
                        'YMinorGrid',1,'XMinorTick',1};
                    


% Loop over the values used in [1] to generate comparison.
figure('color','w','units','centimeters','OuterPosition',[10 10 24 24]);
subplot(3,2,2)
for aLoop = 1:length(ELTry)
    El = ELTry(aLoop);   

    MIndentDUCone(aLoop,:) = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
   
    for bLoop = 1:length(MFAToTry)
        MindentVlassakCone(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassakSphere(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Sphere');
    end

end

plot(ELTry,MIndentDUCone(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on
plot(ELTry,MIndentDUCone(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
plot(ELTry,MindentVlassakCone(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
plot(ELTry,MindentVlassakCone(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
plot(ELTry,MindentVlassakSphere(:,1),'Marker',ctrl.marker{5},linePlotInstructions{:});
plot(ELTry,MindentVlassakSphere(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
xlabel(xAxisText{1},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
% legend(legendText,'location','best','interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
xlim([20 90])
ylim(yLimVals)
pause(0.5)




clear MIndentDUCone  MIndentDUSphere MindentVlassakCone MindentVlassakSphere
subplot(3,2,1)    
for aLoop = 1:length(ETTry)
    Et = ETTry(aLoop);   
    MIndentDUCone(aLoop,:) = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
   
    for bLoop = 1:length(MFAToTry)
        MindentVlassakCone(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassakSphere(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Sphere');
    end
end
plot(ETTry,MIndentDUCone(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on
plot(ETTry,MIndentDUCone(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
plot(ETTry,MindentVlassakCone(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
plot(ETTry,MindentVlassakCone(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
plot(ETTry,MindentVlassakSphere(:,1),'Marker',ctrl.marker{5},linePlotInstructions{:});
plot(ETTry,MindentVlassakSphere(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});

set(gca,axisPlotInstructions{:})
xlabel(xAxisText{2},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
xlim([3 18])
ylim(yLimVals)
pause(0.5)



clear MIndentDUCone  MIndentDUSphere MindentVlassakCone MindentVlassakSphere
subplot(3,2,3)  
for aLoop = 1:length(GLTTry)
    Glt = GLTTry(aLoop);  
    MIndentDUCone(aLoop,:) = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
   
    for bLoop = 1:length(MFAToTry)
        MindentVlassakCone(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassakSphere(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Sphere');
    end
end
plot(GLTTry,MIndentDUCone(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on
plot(GLTTry,MIndentDUCone(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
plot(GLTTry,MindentVlassakCone(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
plot(GLTTry,MindentVlassakCone(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
plot(GLTTry,MindentVlassakSphere(:,1),'Marker',ctrl.marker{5},linePlotInstructions{:});
plot(GLTTry,MindentVlassakSphere(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});

set(gca,axisPlotInstructions{:})
xlabel(xAxisText{3},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
xlim([0 6])
ylim(yLimVals)
pause(0.5)


clear MIndentDUCone  MIndentDUSphere MindentVlassakCone MindentVlassakSphere
subplot(3,2,4)
for aLoop = 1:length(nutlTry)
    nutl = nutlTry(aLoop);
    MIndentDUCone(aLoop,:) = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
   
    for bLoop = 1:length(MFAToTry)
        MindentVlassakCone(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassakSphere(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Sphere');
    end
end
plot(nutlTry,MIndentDUCone(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on
plot(nutlTry,MIndentDUCone(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
plot(nutlTry,MindentVlassakCone(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
plot(nutlTry,MindentVlassakCone(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
plot(nutlTry,MindentVlassakSphere(:,1),'Marker',ctrl.marker{5},linePlotInstructions{:});
plot(nutlTry,MindentVlassakSphere(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
set(gca,axisPlotInstructions{:})
xlabel(xAxisText{4},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
xlim([0 0.6])
ylim(yLimVals)
pause(0.5)



clear MIndentDUCone  MIndentDUSphere MindentVlassakCone MindentVlassakSphere
subplot(3,2,5)
for aLoop = 1:length(nuttTry)
    nutt = nuttTry(aLoop); 
    MIndentDUCone(aLoop,:) = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    
    for bLoop = 1:length(MFAToTry)
        MindentVlassakCone(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassakSphere(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Sphere');
    end
end
plot(nuttTry,MIndentDUCone(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on
plot(nuttTry,MIndentDUCone(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});
plot(nuttTry,MindentVlassakCone(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:});
plot(nuttTry,MindentVlassakCone(:,2),'Marker',ctrl.marker{4},linePlotInstructions{:});
plot(nuttTry,MindentVlassakSphere(:,1),'Marker',ctrl.marker{5},linePlotInstructions{:});
plot(nuttTry,MindentVlassakSphere(:,2),'Marker',ctrl.marker{6},linePlotInstructions{:});
set(gca,axisPlotInstructions{:})
xlabel(xAxisText{5},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
legend(legendText,'location','best','interpreter',ctrl.interpreter)
xlim([0 1.0])
ylim(yLimVals)
pause(0.5)


clear MIndentDUCone  MIndentDUSphere MindentVlassakCone MindentVlassakSphere
Et = 10;
El = 55;
Glt = 3;
nutt = 0.25;
nutl = 0.25;
Gtt = Et/(2*(1+nutt));
MFAToTry = [0:5:90];
for aLoop = 1:length(MFAToTry)
    MindentVlassakCone(aLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(aLoop)],'Cone');
    MindentVlassakSphere(aLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(aLoop)],'Sphere');
end
subplot(3,2,6)
plot(MFAToTry,MindentVlassakCone,'Marker',ctrl.marker{1},linePlotInstructions{:});
hold on
plot(MFAToTry,MindentVlassakSphere,'Marker',ctrl.marker{2},linePlotInstructions{:});
xlabel(xAxisText{6},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
legend('V et al., cone','V et al., sphere','location','best','interpreter',ctrl.interpreter)
xlim([-10 100])
ylim(yLimVals)   
pause(0.5)    



% Image export
% Image export
print([ctrl.workDir filesep 'plots' filesep 'compareIndenters'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'compareIndenters'],'-dpdf')
% export_fig compareIndenters -r600 -png -jpg -tiff
