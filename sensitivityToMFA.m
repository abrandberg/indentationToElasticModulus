function sensitivityToMFA(ctrl)

options = optimoptions(@fminunc,'Display','iter','StepTolerance',0.0001,'FunctionTolerance',0.001);
%  options = optimoptions(@fminunc,'Display','iter');
opts = optimoptions(@fmincon,'Display','iter','StepTolerance',0.0001,'FunctionTolerance',0.001);       
GTL  = 2.51;
nuTT = 0.25;
nuTL = 0.25;
Mexp = [7.45 , 4.37 , 2.92];
Mexp = [7.70 , 5.85 , 2.92];
Mexp = [3.6693 , 4.1755 , 1.57];
% Mexp = [8.5663 , 6.9931 , 1.57];


% Mexp = [8.5663 , 6.9931 , 4];


MFAToTry = 0:2:26; % Offset angle, in degrees

fontSize = 10;
linePlotInstructions = {'linewidth',ctrl.linewidth};
axisPlotInstructions = {'TickLabelInterpreter',ctrl.interpreter, ...
                        'fontsize',fontSize};

figure('color','w','units','centimeters','OuterPosition',[10 10 16 16]);
for aLoop = 1%:3
    ctrl.indenterMix = aLoop;


    for cLoop = 1:length(MFAToTry)
        assumedMFA = MFAToTry(cLoop);
        if ctrl.indenterMix == 1
            % Only hemisphere
            xTry = [4.5, 1.5]';
            selVec = [1 3];
            costFcn = @(x) [vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[1 0 0])];           
        elseif ctrl.indenterMix == 2
            % Pyramid + transverse hemisphere
            xTry = [4.5 , 1.5]';
            selVec = [2 3];
            costFcn = @(x) [vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Cone',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[1 0 0])];
        elseif ctrl.indenterMix == 3 
            % All data
            xTry = [4.5 , 1.5]';
            selVec = [1 2 3];
            costFcn = @(x) [vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Cone',[0 0 1]) ...
                            vlassakMethod([x ; GTL ; nuTT ; nuTL ; assumedMFA],'Sphere',[1 0 0])];
                        
        end
      optiFcn = @(x) sqrt(1/length(selVec) * sum( (costFcn(x) - Mexp(selVec)).^2./Mexp(selVec)));
%       optiFcn = @(x) sqrt(1/length(selVec) * sum( (costFcn(x) - Mexp(selVec)).^2));
%       optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp(selVec)).^2./Mexp(selVec)));
%       [x,~,~,~] = fminunc(optiFcn,xTry,options);
        [x,~,~,~] = fminsearch(optiFcn,xTry);
        
        
        costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
        optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp([1 3])).^2./Mexp([1 3])));  
        x2 = obtainStiffnessComponentEstimate(ctrl,xTry',optiFcn);  
        
        
      output(aLoop).ELET(cLoop,:) = x';
      
%       plot(MFAToTry(cLoop),output(aLoop).ELET(cLoop,1)./output(aLoop).ELET(1,1),'Marker',ctrl.marker{1},linePlotInstructions{:})
%         hold on 
%         plot(MFAToTry(cLoop),output(aLoop).ELET(cLoop,2)./output(aLoop).ELET(1,2),'Marker',ctrl.marker{1},linePlotInstructions{:})
        plot(MFAToTry(cLoop),output(aLoop).ELET(cLoop,1),'Marker',ctrl.marker{1},linePlotInstructions{:})
        hold on 
        plot(MFAToTry(cLoop),output(aLoop).ELET(cLoop,2),'Marker',ctrl.marker{1},linePlotInstructions{:})
        
        plot(MFAToTry(cLoop),x2(1),'Marker',ctrl.marker{1},linePlotInstructions{:})
        hold on 
        plot(MFAToTry(cLoop),x2(2),'Marker',ctrl.marker{1},linePlotInstructions{:})
        
        
        pause(0.5)
    end
end

figure('color','w','units','centimeters','OuterPosition',[10 10 16 16]);

plot(MFAToTry,output(1).ELET(:,1)./output(1).ELET(1,1),'Marker',ctrl.marker{1},linePlotInstructions{:})
hold on 
plot(MFAToTry,output(1).ELET(:,2)./output(1).ELET(1,2),'Marker',ctrl.marker{2},linePlotInstructions{:})
% plot(MFAToTry,output(2).ELET(:,1),'Marker',ctrl.marker{3},linePlotInstructions{:})
% plot(MFAToTry,output(3).ELET(:,1),'Marker',ctrl.marker{4},linePlotInstructions{:})
xlabel('MFA/offset angle [Deg]','interpreter',ctrl.interpreter)
ylabel('Normalized modulus E/E(MFA=0) [-]','interpreter',ctrl.interpreter)
% legend('E_L hemi-sphere','E_T hemi-sphere','E_L pyramid','E_L both','location','northwest','interpreter',ctrl.interpreter)
legend('E_L','E_T','location','northwest','interpreter',ctrl.interpreter)

set(gca,axisPlotInstructions{:})
    
    
% Image export
print([ctrl.workDir filesep 'plots' filesep 'sensitivityToMFA'],'-dpng','-r0')
print([ctrl.workDir filesep 'plots' filesep 'sensitivityToMFA'],'-dpdf')





% costFcn = @(x) delafargueAndUlmMethod([x ; GTL ; nuTT ; nuTL],'Cone');
% optiFcn = @(x) 1/2 * sqrt( sum( (costFcn(x) - Mexp).^2./Mexp));   


