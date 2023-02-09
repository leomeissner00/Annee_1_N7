
% TP3 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom :Meissner
% Prénom : Léo
% Groupe : 1SN-N

function varargout = fonctions_TP3_proba(varargin)

    switch varargin{1}
        
        case 'matrice_inertie'
            
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
            
        case {'ensemble_E_recursif','calcul_proba'}
            
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end});
    
    end
end

% Fonction ensemble_E_recursif (exercie_1.m) ------------------------------
function [E,contour,G_somme] = ...
    ensemble_E_recursif(E,contour,G_somme,i,j,voisins,G_x,G_y,card_max,cos_alpha)
    contour(i,j)=0;
    k = 0;
    while k< 8 & size(E,1)< card_max
        k = k+1;
        if contour(i+voisins(k,1),j+voisins(k,2))
            if (dot(G_somme, [G_x(i+voisins(k,1),j+voisins(k,2)); G_y(i+voisins(k,1),j+voisins(k,2))])/(norm([G_x(i+voisins(k,1),j+voisins(k,2));G_y(i+voisins(k,1),j+voisins(k,2))])*norm(G_somme)))>=cos_alpha
                [E,contour,G_somme] = ensemble_E_recursif(E,contour,G_somme,i+voisins(k,1),j+voisins(k,2),voisins,G_x,G_y,card_max,cos_alpha);
                G_somme = G_somme + [G_x(i+voisins(k,1),j+voisins(k,2)) G_y(i+voisins(k,1),j+voisins(k,2))];
                E= [E ;[i+voisins(k,1),j+voisins(k,2)]];
            end
        
        end
    end

    
end

% Fonction matrice_inertie (exercice_2.m) ---------------------------------
function [M_inertie,C] = matrice_inertie(E,G_norme_E)
E = fliplr(E);
pi_maj = sum(G_norme_E);
x_barre = (G_norme_E'*E(:,1))/pi_maj;
y_barre = (G_norme_E'*E(:,2))/pi_maj;
C = [x_barre y_barre];

M_11 =  sum(G_norme_E.*(E(:,1)-x_barre).*(E(:,1)-x_barre))/pi_maj;
M_12 =  sum(G_norme_E.*(E(:,1)-x_barre).*(E(:,2)-y_barre))/pi_maj;
M_22 = sum(G_norme_E.*(E(:,2)-y_barre).*(E(:,2)-y_barre))/pi_maj;
M_inertie = [M_11 M_12 ; M_12 M_22];
 

end

% Fonction calcul_proba (exercice_2.m) ------------------------------------
function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)
n = length(E_nouveau_repere(:,1));

x_min = min(E_nouveau_repere(:,1));
x_max = max(E_nouveau_repere(:,1));
y_min = min(E_nouveau_repere(:,2));
y_max = max(E_nouveau_repere(:,2));
val = (x_max-x_min)*(y_max-y_min);
N = round(val);


probabilite = 1 - binocdf(n-1,N,p);
    
end
