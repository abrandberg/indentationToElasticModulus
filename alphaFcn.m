function [alpha,ecc] = alphaFcn(C,normalVector,indenterType)


% Discretization for numerical integration
numSteps = 1*60;
angleVec = linspace(0,180,numSteps);
hSave = hIntegralVlassak(0,C,normalVector,angleVec,0);


[~,mIdx] = max(hSave);
% Determine the major axis of the ellipse.

hSaveOld = [hSave ; hSave];         % Double the hSave for the range (180 , 360]
hSave = hSaveOld(mIdx:mod((mIdx+numSteps-1),length(hSaveOld)));      


if strcmp(indenterType,'Cone')
    costFcn = @(XIN) costFcnPyr(XIN,angleVec,hSave);
    ecc = fminbnd(costFcn,0,1);
elseif strcmp(indenterType,'Sphere')
    costFcn = @(XIN) trapz(deg2rad(angleVec),hSave' ./ sqrt(1 - XIN(1)^2.*cosd(angleVec).^2))*sqrt(2-XIN(1)^2);
    ecc = fminbnd(costFcn,0,1);
end


alpha = trapz(deg2rad(angleVec),hSave' ./ sqrt(1 - ecc^2.*cosd(angleVec).^2));
