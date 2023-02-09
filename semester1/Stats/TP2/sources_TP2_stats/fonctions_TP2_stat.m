
% TP2 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom :Meissner
% Prénom : Léo
% Groupe : 1SN-N

function varargout = fonctions_TP2_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction centrage_des_donnees (exercice_1.m) ----------------------------
function [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)
     
    x_G = mean(x_donnees_bruitees);
    y_G = mean(y_donnees_bruitees);
    x_donnees_bruitees_centrees = x_donnees_bruitees - x_G;
    y_donnees_bruitees_centrees = y_donnees_bruitees - y_G;
end

% Fonction estimation_Dyx_MV (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
           estimation_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)
[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

phi = pi*(rand(n_tests, 1)-0.5);
a = tan(phi);

X = repmat(x_donnees_bruitees_centrees, n_tests, 1);
Y = repmat(y_donnees_bruitees_centrees, n_tests, 1);

[~, ind_phi_min] = min(sum((Y - a.*X).^2, 2));
a_Dyx = a(ind_phi_min);
b_Dyx = y_G - a_Dyx*x_G;

end

% Fonction estimation_Dyx_MC (exercice_2.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
                   estimation_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)
vect_1 = zeros(length(x_donnees_bruitees), 1) +1;
A_transpose = cat(1, x_donnees_bruitees, vect_1.');
A = A_transpose.'
B = y_donnees_bruitees;

A_plus = inv(A'*A)*A';
X = A_plus*B';
a_Dyx = X(1);
b_Dyx = X(2);
    
end

% Fonction estimation_Dorth_MV (exercice_3.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
         estimation_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)
[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

theta = pi*(rand(n_tests, 1)-0.5);

X = repmat(x_donnees_bruitees_centrees, n_tests, 1);
Y = repmat(y_donnees_bruitees_centrees, n_tests, 1);

[~, ind_theta_min] = min(sum((Y.*sin(theta) + X.*cos(theta)).^2, 2));
theta_Dorth = theta(ind_theta_min);
rho_Dorth = x_G*cos(theta_Dorth) + y_G*sin(theta_Dorth);

end

% Fonction estimation_Dorth_MC (exercice_4.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
                 estimation_Dorth_MC(x_donnees_bruitees,y_donnees_bruitees)
[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

C = [x_donnees_bruitees_centrees; y_donnees_bruitees_centrees].';
[V,Diag] = eigs(C.'*C);
[~,min_valeur_propre] = min(diag(Diag));
vec_propre = V(:, min_valeur_propre);
theta_Dorth = atan2(vec_propre(2), vec_propre(1));
rho_Dorth = x_G*cos(theta_Dorth) + y_G*sin(theta_Dorth);

end
