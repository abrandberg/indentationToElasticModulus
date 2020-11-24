function evaluateElasticityAssumptionWithFEM(ctrl)
ctrlOld = ctrl;
load(['FEMresults' filesep 'ViscoCalib' '.mat'])

ctrl = ctrlOld; 

fontSize = 10;
linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize,                     ...
                        'YMinorGrid',1,'XMinorTick',1};
                    
                    
legendText = {};
    legendText{end+1} = 'FEM, elastic, $0^\circ$';
    legendText{end+1} = 'FEM, viscoelastic, $0^\circ$'; 
    legendText{end+1} = 'FEM, elastic, $90^\circ$';
    legendText{end+1} = 'FEM, viscoelastic, $90^\circ$'; 

if strcmp(ctrl.interpreter,'tex')
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
end
xAxisText = 'Indentation depth [nm]';
yAxisText = 'Force [nN]';


figure('color','w','units','centimeters','OuterPosition',[10 10 20 12]);
subplot(2,2,1)


    A1 = outputSave(1).fodiA;
    A8 = outputSave(8).fodiA;
    subplot(1,2,1)
    plot(A1(:,1),A1(:,2),'-','DisplayName',legendText{1},linePlotInstructions{:})
    hold on
    plot(A8(:,1),A8(:,2),'-.','DisplayName',legendText{2},linePlotInstructions{:})
    legend('location','northwest','interpreter',ctrl.interpreter)
    xlabel(xAxisText,'interpreter',ctrl.interpreter)
    ylabel(yAxisText,'interpreter',ctrl.interpreter)
    ylim([0 2.5e4])
    set(gca,axisPlotInstructions{:})
    pause(0.5)

    B1 = outputSave(1).fodiB;
    B8 = outputSave(8).fodiB;
    subplot(1,2,2)
    plot(B1(:,1),B1(:,2),'-','DisplayName',legendText{3},linePlotInstructions{:})
    hold on
    plot(B8(:,1),B8(:,2),'-.','DisplayName',legendText{4},linePlotInstructions{:})
    legend('location','northwest','interpreter',ctrl.interpreter)
    xlabel(xAxisText,'interpreter',ctrl.interpreter)
    ylabel(yAxisText,'interpreter',ctrl.interpreter)
    ylim([0 2.5e4])
    set(gca,axisPlotInstructions{:})
    pause(0.5)
    

print([ctrl.workDir filesep 'plots' filesep 'evaluateElasticityAssumptionWithFEM'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'evaluateElasticityAssumptionWithFEM'],'-dpdf')    
