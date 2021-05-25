% function ELEstimate(ctrl,optiFcn,Mexp,finalState)

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

seidlhoferEL = [4.20 3.14 22.94 10.03 21.42 14.94 3.29 9.01]';
lorbachEL_estimate1 = 20.0;          
lorbachEL_estimate2 = 17.0;

% micromechanicalTests = 11.1205;
coxInverted = 15.2;
% micromechanicalTesting = 1e-9.*[32781534517.0828;9699759355.01919;8485046890.73298;5941635104.79263;11368275421.7228;NaN;NaN;7122743616.13227;10087870981.1859;NaN;NaN;8666309740.51272;5339759797.68220;7006929764.79919;15825514720.9594];
micromechanicalTesting = 1e-9.*[11458162778.5396;13001266174.8315;6777745356.55497;14063373415.9568;9154271778.89636;21777370056.9383;8564966670.52301;12837889570.2371;15581733478.1002;9090677651.06356;9631538446.25217;6122014366.13415;7773201014.92600;20812443920.4185;6660104686.94239;8391100905.92074;3112818663.67063];
micromechanicalTesting = 1e-9.*[NaN;11458162778.5396;13001266174.8315;6777745356.55497;14063373415.9568;NaN;NaN;8564966670.52301;12837889570.2371;15581733478.1002;9090677651.06356;9631538446.25217;6122014366.13415;7773201014.92600;20812443920.4185;6660104686.94239;8391100905.92074;NaN;3756606959.24702;5785177922.49888;6264922016.10833;NaN;NaN;4567910998.06839;15657413424.3751;6399666450.21508;NaN;NaN]

figure('color','w','units','centimeters','OuterPosition',[10 10 16 8]);


% nexttile();
% boxchart([4.*ones(size(micromechanicalTesting)) ; 6.*ones(size(seidlhoferEL))],[micromechanicalTesting ; seidlhoferEL],'Orientation','horizontal','handlevisibility','off')
boxchart([4.*ones(size(micromechanicalTesting))],[micromechanicalTesting],'Orientation','horizontal','handlevisibility','off',...
         'BoxFaceColor',[0 0 0])

xlim([0 35])
set(gca,axisPlotInstructions{:})



hold on
plot([finalState.pyrMean(1) finalState.pyrMedian(1)]  ,1.*[1 1],'k-','MarkerFaceColor','k','MarkerSize',8,'handlevisibility','off')
plot([finalState.hemiMean(1) finalState.hemiMedian(1)],2.*[1 1],'k-','MarkerFaceColor','k','MarkerSize',8,'handlevisibility','off')
plot([finalState.nanoMean(1) finalState.nanoMedian(1)],3.*[1 1],'k-','MarkerFaceColor','k','MarkerSize',8,'handlevisibility','off')
    

plot(finalState.pyrMean(1),1,'wo','MarkerFaceColor','k','MarkerSize',8,'displayname','Mean M_L used in Eq. (16)')
plot(finalState.hemiMean(1),2,'wo','MarkerFaceColor','k','MarkerSize',8,'handlevisibility','off')
plot(finalState.nanoMean(1),3,'wo','MarkerFaceColor','k','MarkerSize',8,'handlevisibility','off')  


plot(finalState.pyrMedian(1),1,'ws','MarkerFaceColor',1.*[0.5 0.5 0.5],'MarkerSize',8,'displayname','Median M_L used in Eq. (16)')
plot(finalState.hemiMedian(1),2,'ws','MarkerFaceColor',1.*[0.5 0.5 0.5],'MarkerSize',8,'handlevisibility','off')
plot(finalState.nanoMedian(1),3,'ws','MarkerFaceColor',1.*[0.5 0.5 0.5],'MarkerSize',8,'handlevisibility','off')  
    



% plot(mean(micromechanicalTesting).*[1 1],min(Mexp).*[0.25 1],'k--<','linewidth',1,'markerfacecolor','k')
plot(coxInverted.*[1],5,'dk','linewidth',1,'markerfacecolor','k','handlevisibility','off')

% yticks([1:6])
% yticklabels({'AFM-NI, Pyr','AFM-NI, Sphere','NI','Single fiber','Cox theory','Seidlhofer et al.'})
% ylim([0 7])
yticks([1:5])
yticklabels({'AFM-NI, Pyramid','AFM-NI, Hemisphere','NI','Single fiber tensile test','Cox theory'})
ylim([0 6])


legend('location','southeast')

xlabel('E_L [GPa]')
xlim([0 35])


set(gcf,'PaperPositionMode','auto')
print(['test5'],'-dpng','-r0')

