function h = hVlassak(C,yVector,normalVector)

yVecDir = yVector;
% Outer loop needs to handle generation of vectors
v1=(cross(yVecDir,[0 1 0]));
if v1==0
    v1=(cross(yVecDir,[1 0 0]));
end
v1=v1/norm(v1);
v2=(cross(yVecDir,v1));
v2=v2/norm(v2);

nint=60;
theta=[0:nint-1]/nint*(2*pi);
dtheta = (2*pi)/nint;
B = zeros(3,3);
for m=1:nint
    zA = v1*cos(theta(m)) + v2*sin(theta(m));           % 1st vector in the plane
    zB = v1*cos(pi/2+theta(m)) + v2*sin(pi/2+theta(m)); % 2nd vector in the plane
    
    B = B + ...
        (computeOneBracket(zA,zA,C)      - ...
            computeOneBracket(zA,zB,C)      * ...
            inv(computeOneBracket(zB,zB,C)) * ...
            computeOneBracket(zB,zA,C) )    * dtheta;

    if sum(sum(isnan(B)))> 0
        disp(stop)
    end
end
B = B/(8*pi^2);

Binv = inv(B);

h = 1/(8*pi^2)*normalVector*Binv*normalVector';

