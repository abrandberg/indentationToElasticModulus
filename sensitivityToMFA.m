function sensitivityToMFA(ctrl)

options = optimoptions(@fminunc,'Display','iter','StepTolerance',0.001,'FunctionTolerance',0.01);
opts = optimoptions(@fmincon,'Display','iter','StepTolerance',0.001,'FunctionTolerance',0.01);       
GTL  = 2.51;
nuTT = 0.25;
nuTL = 0.25;
Mexp = [7.45 , 4.37 , 2.92];
Mexp = [7.70 , 5.85 , 2.92];


MFAToTry = 0:2:26; % Offset angle, in degrees

fontSize = 10;
linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize};


for aLoop = 1:3
    ctrl.indenterMix = aLoop;


    for cLoop = 1:length(MFAToTry)
        assumedMFA = MFAToTry(cLoop);
        if ctrl.indenterMix == 1
            % Only hemisphere
            xTry = [7.5 , 2.5]';
            selVec = [1 3];
            costFcn = @(x) [vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[1 0 0])];           
        elseif ctrl.indenterMix == 2
            % Pyramid + transverse hemisphere
            xTry = [4.5 , 2.5]';
            selVec = [2 3];
            costFcn = @(x) [vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Cone',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[1 0 0])];
        elseif ctrl.indenterMix == 3 
            % All data
            xTry = [4.5 , 2.5]';
            selVec = [1 2 3];
            costFcn = @(x) [vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Cone',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[1 0 0])];
                        
        end
      optiFcn = @(x) sqrt(1/length(selVec) * sum( (costFcn(x) - Mexp(selVec)).^2./Mexp(selVec)));
      [x,~,~,~] = fminunc(optiFcn,xTry,options);

      output(aLoop).ELET(cLoop,:) = x';
      
    end
end

figure('color','w','units','centimeters','OuterPosition',[10 10 16 16]);

plot(MFAToTry,output(1).ELET(:,1),'Marker',ctrl.marker{1},linePlotInstructions{:})
hold on 
plot(MFAToTry,output(1).ELET(:,2),'Marker',ctrl.marker{2},linePlotInstructions{:})
plot(MFAToTry,output(2).ELET(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:})
plot(MFAToTry,output(3).ELET(:,1),'Marker',ctrl.marker{4},linePlotInstructions{:})
xlabel('MFA/offset angle [Deg]','interpreter',ctrl.interpreter)
ylabel('Modulus [GPa]','interpreter',ctrl.interpreter)
legend('E_L hemi-sphere','E_T hemi-sphere','E_L pyramid','E_L both','location','northwest','interpreter',ctrl.interpreter)

set(gca,axisPlotInstructions{:})
    
    
% Image export
print([ctrl.workDir filesep 'plots' filesep 'sensitivityToMFA'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'sensitivityToMFA'],'-dpdf')








