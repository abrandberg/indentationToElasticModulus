function compareSolutionScheme()
%
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

    
% Numerical results from Jägers first article.
% Numerical results extracted manually from Figure 4 in [1]
[ELJager0, ELJager90, ETJager0,ETJager90,GLTJager0,GLTJager90,nuttJager0,nuttJager90,] = importJagerFigure4();




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
figure;
subplot(3,2,2)
for aLoop = 1:length(ELTry)
    El = ELTry(aLoop);   

    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;
    
    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end

end
plot(ELTry,MIndentDU(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(ELTry,MIndentDU(:,2),'bs-.','MarkerFaceColor','b')
plot(ELTry,MindentVlassak(:,1),'r^-','MarkerFaceColor','r')
plot(ELTry,MindentVlassak(:,2),'r^-.','MarkerFaceColor','r')
xlabel('$E_L$ [GPa]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
plot(ELJager90(:,1),ELJager90(:,2),'ko-','MarkerFaceColor','k')
plot(ELJager0(:,1),ELJager0(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$','D\&U, $M_T$',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'J et al, 90$^\circ$','J et al, 0$^\circ$','location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14)
xlim([20 90])
ylim([5 35])
pause(0.5)

clear MIndentDU MindentVlassak
subplot(3,2,1)    
for aLoop = 1:length(ETTry)
    Et = ETTry(aLoop);   
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;

    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end

end
plot(ETTry,MIndentDU(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(ETTry,MIndentDU(:,2),'bs-.','MarkerFaceColor','b')
plot(ETTry,MindentVlassak(:,1),'r^-','MarkerFaceColor','r')
plot(ETTry,MindentVlassak(:,2),'r^-.','MarkerFaceColor','r')
xlabel('$E_T$ [GPa]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
plot(ETJager90(:,1),ETJager90(:,2),'ko-','MarkerFaceColor','k')
plot(ETJager0(:,1),ETJager0(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$','D\&U, $M_T$',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'J et al, 90$^\circ$','J et al, 0$^\circ$','location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 20])
ylim([5 35])
pause(0.5)


clear MIndentDU MindentVlassak
subplot(3,2,3)  
for aLoop = 1:length(GLTTry)
    Glt = GLTTry(aLoop);  
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;

    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end
end
plot(GLTTry,MIndentDU(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(GLTTry,MIndentDU(:,2),'bs-.','MarkerFaceColor','b')
plot(GLTTry,MindentVlassak(:,1),'r^-','MarkerFaceColor','r')
plot(GLTTry,MindentVlassak(:,2),'r^-.','MarkerFaceColor','r')
plot(GLTJager90(:,1),GLTJager90(:,2),'ko-','MarkerFaceColor','k')
plot(GLTJager0(:,1),GLTJager0(:,2),'ko-.','MarkerFaceColor','k')
xlabel('$G_{LT}$ [GPa]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
plot(GLTJager90(:,1),GLTJager90(:,2),'ko-','MarkerFaceColor','k')
plot(GLTJager0(:,1),GLTJager0(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$','D\&U, $M_T$',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'J et al, 90$^\circ$','J et al, 0$^\circ$','location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 6])
ylim([5 35])
pause(0.5)

clear MIndentDU MindentVlassak
subplot(3,2,4)
for aLoop = 1:length(nutlTry)
    nutl = nutlTry(aLoop);
    
    MIndent = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
    MIndentDU(aLoop,:) = MIndent;

    for bLoop = 1:length(MFAToTry)
        MIndent = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassak(aLoop,bLoop) = MIndent(1);
    end
end
plot(nutlTry,MIndentDU(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(nutlTry,MIndentDU(:,2),'bs-.','MarkerFaceColor','b')
plot(nutlTry,MindentVlassak(:,1),'r^-','MarkerFaceColor','r')
plot(nutlTry,MindentVlassak(:,2),'r^-.','MarkerFaceColor','r')
xlabel('$\nu_{TL}$ [-]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
% plot(GLTJager90(:,1),GLTJager90(:,2),'ko-','MarkerFaceColor','k')
% plot(GLTJager0(:,1),GLTJager0(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$','D\&U, $M_T$',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'J et al, 90$^\circ$','J et al, 0$^\circ$','location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 0.6])
ylim([5 35])
pause(0.5)
 
clear MIndentDU MindentVlassak
subplot(3,2,5)
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
plot(nuttTry,MIndentDU(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(nuttTry,MIndentDU(:,2),'bs-.','MarkerFaceColor','b')
plot(nuttTry,MindentVlassak(:,1),'r^-','MarkerFaceColor','r')
plot(nuttTry,MindentVlassak(:,2),'r^-.','MarkerFaceColor','r')
xlabel('$\nu_{TT}$ [-]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
plot(nuttJager90(:,1),nuttJager90(:,2),'ko-','MarkerFaceColor','k')
plot(nuttJager0(:,1),nuttJager0(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$','D\&U, $M_T$',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'J et al, 90$^\circ$','J et al, 0$^\circ$','location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 0.6])
ylim([5 35])
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
subplot(3,2,6)
plot([MFAToTry],MindentVlassak,'r^-','MarkerFaceColor','r')
hold on
legend('V et al','location','best','interpreter','latex')
xlabel('MFA [Deg]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([-10 100])
ylim([5 35])   
pause(0.5)    
    
    




