%Léo Meissner


% TP1 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom :
% Prénom : 
% Groupe : 1SN-

function varargout = fonctions_TP1_proba(varargin)

    switch varargin{1}     
        case 'ecriture_RVB'
            varargout{1} = feval(varargin{1},varargin{2:end});
        case {'vectorisation_par_colonne','decorrelation_colonnes'}
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
        case 'calcul_parametres_correlation'
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end}); 
    end

end

% Fonction ecriture_RVB (exercice_0.m) ------------------------------------
% (Copiez le corps de la fonction ecriture_RVB du fichier du meme nom)
function image_RVB = ecriture_RVB(image_originale)
    Rouge = image_originale(1:2:end,2:2:end)  
    Vert = (image_originale(1:2:end,1:2:end) + image_originale(2:2:end,2:2:end))
    Bleu = image_originale(2:2:end,1:2:end)
    image_RVB = cat(3, Rouge, Vert/2, Bleu)

end

% Fonction vectorisation_par_colonne (exercice_1.m) -----------------------
function [Vd,Vg] = vectorisation_par_colonne(I)
V_Droite = I(:, 2:2:end);
V_Gauche = I(:, 1:2:end-1);
Vg = V_Gauche(:);
Vd = V_Droite(:);
end


% Fonction calcul_parametres_correlation (exercice_1.m) -------------------
function [r,a,b] = calcul_parametres_correlation(Vd,Vg)
E_Vd = sum(Vd)/length(Vd)
E_Vg = sum(Vg)/length(Vg)
Cov_Vg_Vd = mean(Vg.*Vd) - E_Vd*E_Vg
Ecart_type_Vd = sqrt(mean(Vd.^2) - (E_Vd)^2)
Ecart_type_Vg = sqrt(mean(Vg.^2) - (E_Vg)^2)
r = Cov_Vg_Vd/(Ecart_type_Vd*Ecart_type_Vg)
a = Cov_Vg_Vd/(Ecart_type_Vd^2)
b = -a*E_Vd +E_Vg
end

% Fonction decorrelation_colonnes (exercice_2.m) --------------------------
function [I_decorrelee,I_min] = decorrelation_colonnes(I,I_max)
I_min = -I_max
I_decorrelee = I
I_decorrelee(:,2:1:end) = I(:,2:1:end) - I(:,1:1:end-1)
end



