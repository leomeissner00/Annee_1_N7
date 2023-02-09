function  [mu , Sigma] = estimation_mu_Sigma(X)
%ESTIMATION_M_SIGMA Summary of this function goes here
%   Detailed explanation goes here

[n,~] = size(X);

mu = mean(X)';

Xc = X-mu';

Sigma = (Xc'*Xc)/n;


end

