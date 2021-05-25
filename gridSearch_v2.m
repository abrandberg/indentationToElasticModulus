function gridSearch_v2(ctrl,optiFcn,Mexp,finalState)

fontSize = 10;
% legendText = {'Error (Hemi-sphere)','Final state (Hemi-sphere)','Final state (Pyramid)','Seidlhofer et al., 2019','Lorbach et al., 2014, a)','Lorbach et al., 2014, b)'};
legendText = {'Error (Hemisphere)','Optimum (Hemisphere)','Optimum (Pyramid)','Micromechanical tests','Cox Equation'};
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
                        'fontsize',fontSize,'fontname','Arial','XGrid','off','YGrid','off'};

                    
% Previous studies
seidlhoferEL = [4.20 3.14 22.94 10.03 21.42 14.94 3.29 9.01]';
lorbachEL_estimate1 = 20.0;          
lorbachEL_estimate2 = 17.0;

% micromechanicalTests = 11.1205;
coxInverted = 15.2;
% micromechanicalTesting = 1e-9.*[32781534517.0828;9699759355.01919;8485046890.73298;5941635104.79263;11368275421.7228;NaN;NaN;7122743616.13227;10087870981.1859;NaN;NaN;8666309740.51272;5339759797.68220;7006929764.79919;15825514720.9594];
micromechanicalTesting = 1e-9.*[11458162778.5396;13001266174.8315;6777745356.55497;14063373415.9568;9154271778.89636;21777370056.9383;8564966670.52301;12837889570.2371;15581733478.1002;9090677651.06356;9631538446.25217;6122014366.13415;7773201014.92600;20812443920.4185;6660104686.94239;8391100905.92074;3112818663.67063];

    ELTry = linspace(1,35,1000);
%     ETTry = linspace(0.25*min(Mexp),min(Mexp),1000);
    ETTry = linspace(0.2,4,1000);
    [X,Y] = meshgrid(ELTry,ETTry);

    for aLoop = 1:size(X,1)
        for bLoop = 1:size(Y,2)
            Z(aLoop,bLoop) = optiFcn([X(aLoop,bLoop) Y(aLoop,bLoop)]');
        end
    end

% figure('color','w','units','centimeters','OuterPosition',[10 10 16 16]);
% figure('color','w','units','centimeters','OuterPosition',[10 10 15 12]);

% contour(X,Y,Z,round(linspace(0.2,max(max(Z)),10),2),'ShowText','on',linePlotInstructions{:}) 



% Figure construction
figure('color','w','units','centimeters','OuterPosition',[10 10 8 8]);
% tiledlayout(5,1)


% nexttile();
% boxchart([ones(size(micromechanicalTesting)) ; 2.*ones(size(seidlhoferEL))],[micromechanicalTesting ; seidlhoferEL],'Orientation','horizontal')
% yticks([1 2])
% yticklabels({'This work','Seidlhofer et al.'})
% xlim([0 35])
% set(gca,axisPlotInstructions{:})


% nexttile([4 1]);
contour(X,Y,Z,round(linspace(0.0,2,11),2),'ShowText','on',linePlotInstructions{:},'color','k','LabelSpacing',288,'displayname','Error (Sphere, mean)') 
hold on
plot(finalState.hemiMean(1),finalState.hemiMean(2),'wo','MarkerFaceColor','k','MarkerSize',8,'displayname','Sphere, mean')
% % hold on
% plot(finalState.pyrMean(1),finalState.pyrMean(2),'ws','MarkerFaceColor','k','MarkerSize',8,'displayname','Pyr, mean')
% plot(finalState.nanoMean(1),finalState.nanoMean(2),'wd','MarkerFaceColor','k','MarkerSize',8,'displayname','NI, mean')
    
% plot(finalState.hemiMedian(1),finalState.hemiMedian(2),'wo','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',8,'displayname','Sphere, median')
% % hold on
% plot(finalState.pyrMedian(1),finalState.pyrMedian(2),'ws','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',8,'displayname','Pyr, median')
% plot(finalState.nanoMedian(1),finalState.nanoMedian(2),'wd','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',8,'displayname','NI, median')  
    



% plot(mean(micromechanicalTesting).*[1 1],min(Mexp).*[0.25 1],'k--<','linewidth',1,'markerfacecolor','k')
% plot(coxInverted.*[1 1],min(Mexp).*[0.25 1],'k-.','linewidth',1,'markerfacecolor','k','displayname','Cox theory')















xlim([0 35])

% legend('interpreter',ctrl.interpreter,'location','southeast')
xlabel(xAxisText,'interpreter',ctrl.interpreter)
ylabel(yAxisText,'interpreter',ctrl.interpreter)
set(gca,axisPlotInstructions{:})



% Image export
set(gcf,'PaperPositionMode','auto')
print([ctrl.workDir filesep 'plots' filesep 'contourOfErrors_v2'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'contourOfErrors_v2'],'-dpdf')


















