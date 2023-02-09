
% TP1 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : MEISSNER
% Prénom : Léo
% Groupe : 1SN-N

function varargout = fonctions_TP1_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction G_et_R_moyen (exercice_1.m) ----------------------------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)
    G_x = mean(x_donnees_bruitees);
    G_y = mean(y_donnees_bruitees);
    G = [G_x G_y];
    pts_G_x = repmat(G_x, length(x_donnees_bruitees),1);
    pts_G_y = repmat(G_y, length(y_donnees_bruitees),1);
    distances = sqrt((pts_G_x-x_donnees_bruitees).^2 + (pts_G_y-y_donnees_bruitees).^2);
     
    R_moyen_vect = mean(distances,2);
    R_moyen = mean(R_moyen_vect);
     
end

% Fonction estimation_C_uniforme (exercice_1.m) ---------------------------
function [C_estime, R_moyen] = ...
         estimation_C_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)
     [G, R_moyen,~] = G_et_R_moyen(x_donnees_bruitees, y_donnees_bruitees);
     C = G + 2*R_moyen*(rand(n_tests, 2)-0.5);
     
     pts_C_x = repmat(C(:,1), length(x_donnees_bruitees), 1);
     
     donnees_x = repmat(x_donnees_bruitees, 1 , n_tests);
     pts_C_y = repmat(C(:,2), length(y_donnees_bruitees), 1);
     donnees_y = repmat(y_donnees_bruitees, 1 , n_tests);
     distances_C = sqrt((pts_C_x-donnees_x).^2 + (pts_C_y-donnees_y).^2);
     

     [~, ind_min] = min(sum((distances_C-R_moyen).^2, 2));
     C_estime = C(ind_min,:);

     

end

% Fonction estimation_C_et_R_uniforme (exercice_2.m) ----------------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    [G, R_moyen,distances] = G_et_R_moyen(x_donnees_bruitees, y_donnees_bruitees);

    R = R_moyen + R_moyen*(rand(n_tests, 1)-0.5);
    R_vect = repmat(R, length(x_donnees_bruitees),1);
    

    C = G + 2*R_moyen*(rand(n_tests, 2)-0.5);

    pts_C_x = repmat(C(:,1), length(x_donnees_bruitees), 1);
    donnees_x = repmat(x_donnees_bruitees, 1 , n_tests);
    pts_C_y = repmat(C(:,2), length(y_donnees_bruitees), 1);
    donnees_y = repmat(y_donnees_bruitees, 1 , n_tests);
    distances_C = sqrt((pts_C_x-donnees_x).^2 + (pts_C_y-donnees_y).^2);

    
    [~, ind_min] = min(sum((distances_C-R_vect).^2, 2));
    C_estime = C(ind_min,:);
    R_estime = R_vect(ind_min, :);

end

% Fonction occultation_donnees (donnees_occultees.m) ----------------------
function [x_donnees_bruitees, y_donnees_bruitees] = ...
         occultation_donnees(x_donnees_bruitees, y_donnees_bruitees, theta_donnees_bruitees)
theta_tirage = 2*pi*rand(1,2)
if theta_tirage(1) <= theta_tirage(2)
    x_donnees_bruitees = x_donnees_bruitees(theta_tirage(1) <= theta_donnees_bruitees & theta_donnees_bruitees <= theta_tirage(2));
    y_donnees_bruitees = y_donnees_bruitees(theta_tirage(1) <= theta_donnees_bruitees & theta_donnees_bruitees <= theta_tirage(2));
else
    x_1 = x_donnees_bruitees(theta_donnees_bruitees <= theta_tirage(2));
    y_1 = y_donnees_bruitees(theta_donnees_bruitees <= theta_tirage(2));
    x_2 = x_donnees_bruitees(theta_donnees_bruitees >= theta_tirage(1));
    y_2 = y_donnees_bruitees(theta_donnees_bruitees >= theta_tirage(1));
    x_donnees_bruitees = [x_1 x_2];
    y_donnees_bruitees = [y_1 y_2];
end
end

% Fonction estimation_C_et_R_normale (exercice_4.m, bonus) ----------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_normale(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [G, R_moyen,distances] = G_et_R_moyen(x_donnees_bruitees, y_donnees_bruitees);

    R = R_moyen + randn(n_tests, 1);
    R_vect = repmat(R, length(x_donnees_bruitees),1);
    

    C = G + randn(n_tests, 2);

    pts_C_x = repmat(C(:,1), length(x_donnees_bruitees), 1);
    donnees_x = repmat(x_donnees_bruitees, 1 , n_tests);
    pts_C_y = repmat(C(:,2), length(y_donnees_bruitees), 1);
    donnees_y = repmat(y_donnees_bruitees, 1 , n_tests);
    distances_C = sqrt((pts_C_x-donnees_x).^2 + (pts_C_y-donnees_y).^2);

    
    [~, ind_min] = min(sum((distances_C-R_vect).^2, 2));
    C_estime = C(ind_min,:);
    R_estime = R_vect(ind_min, :);

end
