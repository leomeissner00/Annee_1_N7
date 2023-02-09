function X = moyenne(im)
%MOYENNE Summary of this function goes here
%   Detailed explanation goes here

% Decoupage de l'image en trois canaux et conversion en doubles :
R = single(im(:, :, 1));
V = single(im(:, :, 2));
B = single(im(:, :, 3));

somme = R(:)+B(:)+V(:);
ind = find(somme <= 1);

somme(ind) = 1;

r = mean(R(:)./somme);
v = mean(V(:)./somme);

X = [r,v];
end

