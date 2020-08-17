function xBracket = computeOneBracket(xA,xB,C)
%
% Inputs:
% xA = vector 1
% xB = vector 2
%
% C = stiffness tensor
%
% Test
% C = makeTransversallyIsotropicStiffnessTensor(El, Et, Glt, Gtt, nutl);
% 
% xA = [1 0 0]';
% xB = [0 1 0]';
%

% Test 1: (cd)_jk = c_i * C_ijkm * d_m
xBracket = zeros(3,3);
for i = 1:3
   for j = 1:3
      for k = 1:3
         for m = 1:3
             xBracket(j,k) = xBracket(j,k) + xA(i) * getS4Element(C,i,j,k,m) * xB(m);
         end
      end
   end
end


