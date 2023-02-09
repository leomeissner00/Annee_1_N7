
% nb (nb de classes) : nb_personnes_base

function [h2] = bayesien(X, nb_personnes_base, nb_postures_base)

tab_P = zeros(nb_personnes_base*nb_postures_base,nb_personnes_base);
somme_P = zeros(1,nb_personnes_base);
for i=1:nb_personnes_base
    [mu, sigma] = estimation_mu_Sigma(X(:,(i-1)*nb_postures_base + 1 : i*nb_postures_base));
    tab_P(:,i) = gaussienne(X(:,(i-1)*nb_postures_base + 1 : i*nb_postures_base), mu, sigma);
    somme_P(i) = sum(tab_P(:,i));
end

[val, h2] = max(somme_P);

end