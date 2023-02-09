% Auteur : J. Gergaud
% décembre 2017
% -----------------------------
% 



function Jac = diff_finies_avant(fun,x,option)
%
% Cette fonction calcule les différences finies avant sur un schéma
% Paramètres en entrées
% fun : fonction dont on cherche à calculer la matrice jacobienne
%       fonction de IR^n à valeurs dans IR^m
% x   : point où l'on veut calculer la matrice jacobienne
% option : précision du calcul de fun (ndigits)
%
% Paramètre en sortie
% Jac : Matrice jacobienne approximé par les différences finies
%        real(m,n)
% ------------------------------------
n = length(x);
v = eye(n);
h = sqrt(max(eps, 10^(-option)))*max(abs(x(1)),1)*sign(x(1));
Jac = (fun(x + h*v(:,1))- fun(x))/h;
for k = 2:n
    h = sqrt(max(eps, 10^(-option)))*max(abs(x(k)),1)*sign(x(k));
    Col = (fun(x + h*v(:,k))- fun(x))/h;
    [Jac] = [Jac Col];
end
end

function s = sgn(x)
% fonction signe qui renvoie 1 si x = 0
if x==0
  s = 1;
else 
  s = sign(x);
end
end







