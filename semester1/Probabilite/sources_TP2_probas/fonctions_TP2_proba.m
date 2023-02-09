
% TP2 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : Meissner
% Prenom : Léo
% Groupe : 1SN-N

function varargout = fonctions_TP2_proba(varargin)

    switch varargin{1}
        
        case {'calcul_frequences_caracteres','determination_langue','coeff_compression','gain_compression','partitionnement_frequences'}

            varargout{1} = feval(varargin{1},varargin{2:end});
            
        case {'recuperation_caracteres_presents','tri_decroissant_frequences','codage_arithmetique'}
            
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
            
        case 'calcul_parametres_correlation'
            
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end});
            
    end

end

% Fonction calcul_frequences_caracteres (exercice_0.m) --------------------
function frequences = calcul_frequences_caracteres(texte,alphabet)
    % Note : initialiser le vecteur avec 'size(alphabet)' pour garder la bonne orientation

n = length(alphabet);
frequences = zeros(size(alphabet)); 
for i = 1:n
    indices = find(texte == alphabet(i));
    frequences(i)=  length(indices)/length(texte);
end

end

% Fonction recuperation_caracteres_presents (exercice_0.m) ----------------
function [selection_frequences,selection_alphabet] = ...
                      recuperation_caracteres_presents(frequences,alphabet)
val_non_nul = find(frequences>0);
selection_frequences = frequences(val_non_nul);
selection_alphabet = alphabet(val_non_nul);

end

% Fonction tri_decremental_frequences (exercice_0.m) ----------------------
function [frequences_triees,indices_frequences_triees] = ...
                           tri_decroissant_frequences(selection_frequences)
[frequences_triees, indices_frequences_triees] = sort(selection_frequences, 'descend');


end

% Fonction determination_langue (exercice_1.m) ----------------------------
function indice_langue = determination_langue(frequences_texte, frequences_langue, nom_norme)
    % Note : la variable nom_norme peut valoir 'L1', 'L2' ou 'Linf'.
mat_frequences_textes = repmat(frequences_texte,15,1);
diff_mat_frequ = mat_frequences_textes - frequences_langue;
switch nom_norme
    case{'L1'}
        norme =  sum(abs(diff_mat_frequ), 2);
         
    case{'L2'}
        norme =  (sum((diff_mat_frequ.*diff_mat_frequ),2));
        
    case{'Linf'}
        norme = max(abs(diff_mat_frequ), [], 2);
end
langue = min(norme);
indice_langue = find(norme == langue);
end

% Fonction coeff_compression (exercice_2.m) -------------------------------
function coeff_comp = coeff_compression(signal_non_encode,signal_encode)
coeff_comp = (length(signal_non_encode)*8)/length(signal_encode); %Multiplication du signal non encoder par 8 car les caractères sont encodés sur 8 bits


end

% Fonction coeff_compression (exercice_2bis.m) -------------------------------
function gain_comp = gain_compression(coeff_comp_avant,coeff_comp_apres)
gain_comp = coeff_comp_apres/coeff_comp_avant;


end

% Fonction partitionnement_frequences (exercice_3.m) ----------------------
function bornes = partitionnement_frequences(selection_frequences)
bornes= zeros(2, length(selection_frequences) );
bornes(2,1) = selection_frequences(1);
for i = 2:length(selection_frequences)
    bornes(1,i) = sum(selection_frequences(1:i-1));
    bornes(2,i) = sum(selection_frequences(1:i));
end
bornes(2,length(selection_frequences))= 1;
end

% Fonction codage_arithmetique (exercice_3.m) -----------------------------
function [borne_inf,borne_sup] = ...
                       codage_arithmetique(texte,selection_alphabet,bornes)
borne_inf = 0;
borne_sup = 1;
for i = 1:length(texte(:))
    indice = find(selection_alphabet == texte(i));

    largeur = borne_sup-borne_inf;
    borne_sup = borne_inf+largeur*bornes(2,indice);
    borne_inf = borne_inf+largeur*bornes(1,indice);
end
k = 1;
while (floor(k*borne_inf) == floor(k*borne_sup))
	k = 10*k;	
end

    
end