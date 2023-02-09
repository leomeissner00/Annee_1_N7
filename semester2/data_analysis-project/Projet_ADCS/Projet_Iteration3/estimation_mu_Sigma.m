% Fonction estimation_mu_Sigma estime une loi normale
% bidimensionnelle
function [mu, sigma] = estimation_mu_Sigma(X)
n = size(X,1);

X_c = X - mean(X);
sigma = 1/n*(X_c)'*X_c;

mu = mean(X);

end