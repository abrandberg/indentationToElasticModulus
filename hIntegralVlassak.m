function hSave = hIntegralVlassak(dTheta,C,normalVector,angleVec,plotFlag)

if plotFlag
    figure;
end

% Initialize
hSave = zeros(length(angleVec),1);

for mLoop = 1:length(angleVec)
    angleTemp = angleVec(mLoop);
    yVector = [cosd(angleTemp+dTheta) sind(angleTemp+dTheta) 0];
    hSave(mLoop) = hVlassak(C,yVector,normalVector) ;
   
    if plotFlag
        polarplot(deg2rad(angleTemp),hSave(mLoop),'ob')
        hold on
        pause(0.2)
    end
end