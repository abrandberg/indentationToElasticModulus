function evaluateInfluenceOfS1(ctrl)




xAxisText = 'Indentation depth [nm]';
yAxisText = 'Force [nN]';


ctrlOld = ctrl;
load(['FEMresults' filesep 'S1Check' '.mat'])


plotValsS1 = [[outputSave(1).fodiB(1:end,1)],[outputSave(1).fodiB(1:end,2)] ];
ErS1 = ErSaveB;

load(['FEMresults' filesep 'fricNLGeomCheck' '.mat'])
ctrl = ctrlOld;
ErRef = ErSaveB(1);

legendText = {['No S1, M = ' num2str(ErRef)],['100 \mu m S1, M = ' num2str(ErS1)]};
if strcmp(ctrl.interpreter,'tex')
    legendText = strrep(legendText,'$','');
    legendText = strrep(legendText,'\&','&');
end


figure('color','w', ...
       'Units','centimeters',...
       'InnerPosition',[0 0 14 10]);
plot([outputSave(1).fodiB(1:end,1)],[outputSave(1).fodiB(1:end,2)],'-.');
hold on
plot(plotValsS1(:,1),plotValsS1(:,2),'--');
xlabel(xAxisText,'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
legend(legendText,'location','best','interpreter',ctrl.interpreter)





