function X = MCO(x,y)
% -------------
A = [x.^2 x.*y y.^2 x y ones(length(x),1)];
B_tild = [zeros(1, length(x)) 1]';
A_tild = [A ; 1 0 1 0 0 0];
X = pinv(A_tild)*B_tild;
end

