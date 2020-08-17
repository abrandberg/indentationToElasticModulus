function cost = costFcnPyr(eTemp,angleVec,hSave)

[~,E] = ellipke(eTemp);
cost = trapz(deg2rad(angleVec),hSave' ./ sqrt(1 - eTemp^2.*cosd(angleVec).^2))*E;
