function evaluateAssumptionsWithFEM(ctrl)
ctrlOld = ctrl;
load(['FEMresults' filesep 'fricNLGeomCheck' '.mat'])
ctrl = ctrlOld;

legendText = {['Non-lin.=1, $\mu=0$, $M = ' num2str(round(ErSaveA(1),2)) '$ GPa'];
              ['Non-lin.=0, $\mu=0$, $M = ' num2str(round(ErSaveA(2),2)) '$ GPa'];
              ['Non-lin.=1, $\mu=0.5$, $M = ' num2str(round(ErSaveA(3),2)) '$ GPa']};

fontSize = 10;
linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize,                     ...
                        'YMinorGrid',1,'XMinorTick',1};        
          
if strcmp(ctrl.interpreter,'tex')
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
end

xAxisText = 'Indentation depth [nm]';
yAxisText = 'Force [nN]';

figure('color','w','units','centimeters','OuterPosition',[10 10 20 12]);
subplot(1,2,1)
plot([outputSave(1).fodiA(1:end-3,1)],[outputSave(1).fodiA(1:end-3,2)],'-.',linePlotInstructions{:});%)
hold on
plot([outputSave(2).fodiA(1:end-3,1)],[outputSave(2).fodiA(1:end-3,2)],':',linePlotInstructions{:});%)
plot([outputSave(3).fodiA(1:end-3,1)],[outputSave(3).fodiA(1:end-3,2)],'--',linePlotInstructions{:});%)
xlabel(xAxisText,'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
legend(legendText,'location','northwest','interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
 ylim([0 3e4])

legendText = {['Non-lin.=1, $\mu=0$, M = ' num2str(round(ErSaveB(1),2)) ' GPa'];
              ['Non-lin.=0, $\mu=0$, M = ' num2str(round(ErSaveB(2),2)) ' GPa'];
              ['Non-lin.=1, $\mu=0.5$, M = ' num2str(round(ErSaveB(3),2)) ' GPa']};
if strcmp(ctrl.interpreter,'tex')
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
end



subplot(1,2,2)
plot([outputSave(1).fodiB(1:end-2,1)],[outputSave(1).fodiB(1:end-2,2)],'-.',linePlotInstructions{:})
hold on
plot([outputSave(2).fodiB(1:end-2,1)],[outputSave(2).fodiB(1:end-2,2)],':',linePlotInstructions{:})
plot([outputSave(3).fodiB(1:end-2,1)],[outputSave(3).fodiB(1:end-2,2)],'--',linePlotInstructions{:})
xlabel(xAxisText,'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
 ylim([0 3e4])
legend(legendText,'location','northwest','interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})


% Image export
print([ctrl.workDir filesep 'plots' filesep 'evaluateAssumptionsWithFEM'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'evaluateAssumptionsWithFEM'],'-dpdf')




