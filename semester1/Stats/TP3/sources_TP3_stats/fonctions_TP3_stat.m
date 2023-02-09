
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : MEISSNER
% Prenom : Léo
% Groupe : 1SN-N

function varargout = fonctions_TP3_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)


A = [cos(theta), sin(theta)];
X = A \ rho;
rho_F = sqrt(X'*X);
theta_F = atan2 (X(2), X(1));


    % A modifier lors de l'utilisation de l'algorithme RANSAC (exercice 2)
    
    estime_rho = rho_F*cos(theta - theta_F);
    ecart_moyen = mean(abs(rho - estime_rho));

end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres)

S1 = parametres(1);
S2 = parametres(2);
k_max = parametres(3);
ecart_min = inf;

for iteration = 1:k_max
    Sous_ensemble = randperm(length(rho), 2);
    rho_test = rho(Sous_ensemble);
    theta_test = theta(Sous_ensemble);
    
    [rho_estime,theta_estime,~] = estimation_F(rho_test,theta_test);
    
    estime_rho = rho_estime*cos(theta - theta_estime);
    ecart = abs(rho - estime_rho);
    rho_conformes = rho(ecart <= S1);
    theta_conformes = theta(ecart <= S1);
    if length(rho_conformes)/length(rho) >= S2 
         [rho_accepter,theta_accepter,ecart_moyen] = estimation_F(rho_conformes,theta_conformes);
         if ecart_moyen < ecart_min
             rho_F_estime = rho_accepter;
             theta_F_estime = theta_accepter;
             ecart_min = ecart_moyen;
         end
    end 
end
end

% Fonction G_et_R_moyen (exercice_3.m, bonus, fonction du TP1) ------------
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

% Fonction estimation_C_et_R (exercice_3.m, bonus, fonction du TP1) -------
function [C_estime,R_estime,critere] = ...
         estimation_C_et_R(x_donnees_bruitees,y_donnees_bruitees,n_tests,C_tests,R_tests)
     
    % Attention : par rapport au TP1, le tirage des C_tests et R_tests est 
    %             considere comme etant deje effectue 
    %             (il doit etre fait au debut de la fonction RANSAC_3)
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

    distances_C_estime = ((C_estime(1) - x_donnees_bruitees).^2 + (C_estime(2) - y_donnees_bruitees).^2);
    critere = abs(distances_C_estime-distances);
end

% Fonction RANSAC_3 (exercice_3, bonus) -----------------------------------
function [C_estime,R_estime] = ...
         RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres)
     
    % Attention : il faut faire les tirages de C_tests et R_tests ici
S1 = parametres(1);
S2 = parametres(2);
k_max = parametres(3);
ecart_min = inf;

for iteration = 1:k_max
    Sous_ensemble = randperm(length(x_donnees_bruitees), 3);
    x_test = x_donnees_bruitees(Sous_ensemble);
    y_test = y_donnees_bruitees(Sous_ensemble);
    
    [C, R, dist] = G_et_R_moyen(x_test, y_test);

    distances_C_estime = ((C(1) - x_donnees_bruitees).^2 + (C(2) - y_donnees_bruitees).^2);
    ecart = abs(distances_C_estime-R);
    x_conformes = x_donnees_bruitees(ecart <= S1);
    y_conformes = y_donnees_bruitees(ecart <= S1);
    if length(x_conformes)/length(x_donnees_bruitees) >= S2 
         [C_accepter,R_accepter,ecart_moyen] = estimation_C_et_R(x_conformes,y_conformes, n_tests, C_tests, R_tests);
         if ecart_moyen < ecart_min
             C_estime = C_accepter;
             R_estime = R_accepter;
             ecart_min = ecart_moyen;
         end
    end 
end


end
