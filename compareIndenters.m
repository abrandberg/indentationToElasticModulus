function compareIndenters()





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

    MIndentDUCone(aLoop,:) = delafargueAndUlmMethod([El, Et, Glt, nutt, nutl],'Cone');
   
    for bLoop = 1:length(MFAToTry)
        MindentVlassakCone(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Cone');
        MindentVlassakSphere(aLoop,bLoop) = vlassakMethod([El ; Et ; Glt ; nutt ; nutl ; MFAToTry(bLoop)],'Sphere');
    end

end




plot(ELTry,MIndentDUCone(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(ELTry,MIndentDUCone(:,2),'bs-.','MarkerFaceColor','b')
plot(ELTry,MindentVlassakCone(:,1),'r^-','MarkerFaceColor','r')
plot(ELTry,MindentVlassakCone(:,2),'r^-.','MarkerFaceColor','r')
plot(ELTry,MindentVlassakSphere(:,1),'ko-','MarkerFaceColor','k')
plot(ELTry,MindentVlassakSphere(:,2),'ko-.','MarkerFaceColor','k')
xlabel('$E_L$ [GPa]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
legend('D\&U, $M_L$, cone','D\&U, $M_T$, cone',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'V et al, 90$^\circ$, sphere','V et al, 0$^\circ$, sphere',...
       'location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14)
xlim([20 90])
ylim([5 35])
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
plot(ETTry,MIndentDUCone(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(ETTry,MIndentDUCone(:,2),'bs-.','MarkerFaceColor','b')
plot(ETTry,MindentVlassakCone(:,1),'r^-','MarkerFaceColor','r')
plot(ETTry,MindentVlassakCone(:,2),'r^-.','MarkerFaceColor','r')
plot(ETTry,MindentVlassakSphere(:,1),'ko-','MarkerFaceColor','k')
plot(ETTry,MindentVlassakSphere(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$, cone','D\&U, $M_T$, cone',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'V et al, 90$^\circ$, sphere','V et al, 0$^\circ$, sphere',...
       'location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 20])
ylim([5 35])
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
plot(GLTTry,MIndentDUCone(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(GLTTry,MIndentDUCone(:,2),'bs-.','MarkerFaceColor','b')
plot(GLTTry,MindentVlassakCone(:,1),'r^-','MarkerFaceColor','r')
plot(GLTTry,MindentVlassakCone(:,2),'r^-.','MarkerFaceColor','r')
plot(GLTTry,MindentVlassakSphere(:,1),'ko-','MarkerFaceColor','k')
plot(GLTTry,MindentVlassakSphere(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$, cone','D\&U, $M_T$, cone',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'V et al, 90$^\circ$, sphere','V et al, 0$^\circ$, sphere',...
       'location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 6])
ylim([5 35])
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
plot(nutlTry,MIndentDUCone(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(nutlTry,MIndentDUCone(:,2),'bs-.','MarkerFaceColor','b')
plot(nutlTry,MindentVlassakCone(:,1),'r^-','MarkerFaceColor','r')
plot(nutlTry,MindentVlassakCone(:,2),'r^-.','MarkerFaceColor','r')
plot(nutlTry,MindentVlassakSphere(:,1),'ko-','MarkerFaceColor','k')
plot(nutlTry,MindentVlassakSphere(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$, cone','D\&U, $M_T$, cone',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'V et al, 90$^\circ$, sphere','V et al, 0$^\circ$, sphere',...
       'location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 0.6])
ylim([5 35])
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
plot(nuttTry,MIndentDUCone(:,1),'bs-','MarkerFaceColor','b')
hold on
plot(nuttTry,MIndentDUCone(:,2),'bs-.','MarkerFaceColor','b')
plot(nuttTry,MindentVlassakCone(:,1),'r^-','MarkerFaceColor','r')
plot(nuttTry,MindentVlassakCone(:,2),'r^-.','MarkerFaceColor','r')
plot(nuttTry,MindentVlassakSphere(:,1),'ko-','MarkerFaceColor','k')
plot(nuttTry,MindentVlassakSphere(:,2),'ko-.','MarkerFaceColor','k')
legend('D\&U, $M_L$, cone','D\&U, $M_T$, cone',...
       'V et al, 90$^\circ$','V et al, 0$^\circ$',...
       'V et al, 90$^\circ$, sphere','V et al, 0$^\circ$, sphere',...
       'location','best','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([0 0.6])
ylim([5 35])
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
plot([MFAToTry],MindentVlassakCone,'r^-','MarkerFaceColor','r')
hold on
plot([MFAToTry],MindentVlassakSphere,'b^-','MarkerFaceColor','b')
legend('V et al, Cone','V et al, Sphere','location','best','interpreter','latex')
xlabel('MFA [Deg]','interpreter','latex')
ylabel('$M$ [GPa]','interpreter','latex')
set(gca,'TickLabelInterpreter','latex','fontsize',14) 
xlim([-10 100])
ylim([5 35])   
pause(0.5)    

