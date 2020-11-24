function compareWithFEM(ctrl)

[ELJager0, ELJager90, ETJager0,ETJager90,GLTJager0,GLTJager90,~,~] = importJagerFigure4();
% For simplicity, we merely import Jägers results which we know to be equal to our
% implementation.
legendText = {};

    legendText{end+1} = 'J et al, 90$^\circ$';
    legendText{end+1} = 'J et al, 0$^\circ$';    

    legendText{end+1} = 'FEM, 90$^\circ$';
    legendText{end+1} = 'FEM, 0$^\circ$';    


fontSize = 10;

if strcmp(ctrl.interpreter,'tex')
    xAxisText = {'E_L [GPa]',    ...
                 'E_T [GPa]',    ...
                 'G_{LT} [GPa]'};
    yAxisText = 'M [GPa]';
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
elseif strcmp(ctrl.interpreter,'latex')
    xAxisText = {'$E_L$ [GPa]',    ...
                 '$E_T$ [GPa]',    ...
                 '$G_{LT}$ [GPa]'};
    yAxisText = '$M$ [GPa]';
end
yLimVals = [5 30];

linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize,                     ...
                        'YMinorGrid',1,'XMinorTick',1};

yLimVals = [5 30];
load(['FEMresults' filesep 'ELParaResume' '.mat'],'ELTry')
load(['FEMresults' filesep 'ELParaResume' '.mat'],'ErSave')
load(['FEMresults' filesep 'ELParaResume' '.mat'],'ErSave2')


figure('color','w','units','centimeters','OuterPosition',[10 10 24 24]);
subplot(2,2,1)

    plot(ELJager90(:,1),ELJager90(:,2),'Marker',ctrl.marker{1},linePlotInstructions{:});%,'ko-','MarkerFaceColor','k')
    hold on
    plot(ELJager0(:,1),ELJager0(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});%,'ko-.','MarkerFaceColor','k')
    
    
    plot(ELTry/1000,ErSave2,'Marker',ctrl.marker{3},linePlotInstructions{:});%,'rs-','MarkerFaceColor','r')
    hold on
    plot(ELTry/1000,ErSave,'Marker',ctrl.marker{4},linePlotInstructions{:});%,'rs-.','MarkerFaceColor','r')
    
    
xlabel(xAxisText{1},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
xlim([20 90])
ylim(yLimVals)
% legend(legendText,'location','best','interpreter','latex')
% print('ELVsFEM','-dpng')



load(['FEMresults' filesep 'ETParaResume' '.mat'],'ETTry')
load(['FEMresults' filesep 'ETParaResume' '.mat'],'ErSave')
load(['FEMresults' filesep 'ETParaResume' '.mat'],'ErSave2')

% figure;
subplot(2,2,2)
    plot(ETJager90(:,1),ETJager90(:,2),'Marker',ctrl.marker{1},linePlotInstructions{:});%,'ko-','MarkerFaceColor','k')
    hold on
    plot(ETJager0(:,1),ETJager0(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:});%,'ko-.','MarkerFaceColor','k')
    
    
    plot(ETTry/1000,ErSave2(1:12),'Marker',ctrl.marker{3},linePlotInstructions{:});%,'rs-','MarkerFaceColor','r')
    hold on
    plot(ETTry/1000,ErSave(1:12),'Marker',ctrl.marker{4},linePlotInstructions{:});%,'rs-.','MarkerFaceColor','r')
    
    
xlabel(xAxisText{2},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
xlim([3 18])
ylim(yLimVals)
% legend(legendText,'location','best','interpreter',ctrl.interpreter)
% print('ETVsFEM','-dpng')



load(['FEMresults' filesep 'GLTParaResume' '.mat'],'GLTTry')
load(['FEMresults' filesep 'GLTParaResume' '.mat'],'ErSave')
load(['FEMresults' filesep 'GLTParaResume' '.mat'],'ErSave2')

% figure;
subplot(2,1,2)
    plot(GLTJager90(:,1),GLTJager90(:,2),'Marker',ctrl.marker{1},linePlotInstructions{:})
    hold on
    plot(GLTJager0(:,1),GLTJager0(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:})
    
    
    plot(GLTTry/1000,ErSave2(1:length(GLTTry)),'Marker',ctrl.marker{3},linePlotInstructions{:});
    hold on
    plot(GLTTry/1000,ErSave(1:length(GLTTry)),'Marker',ctrl.marker{4},linePlotInstructions{:});
    
    
xlabel(xAxisText{3},'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
legend(legendText,'location','best','interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})
xlim([0 6])
ylim(yLimVals)
% print('GLTVsFEM','-dpng')

% Image export
print([ctrl.workDir filesep 'plots' filesep 'compareWithFEM'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'compareWithFEM'],'-dpdf')
% export_fig compareWithFEM -r600 -png -jpg -tiff
