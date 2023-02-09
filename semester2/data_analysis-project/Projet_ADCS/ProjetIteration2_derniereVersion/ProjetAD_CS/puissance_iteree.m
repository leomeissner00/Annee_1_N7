clear variables;clc
% tolerance relative minimum pour l'ecart entre deux iteration successives 
% de la suite tendant vers la valeur propre dominante 
% (si |lambda-lambda_old|/|lambda_old|<eps, l'algo a converge)
eps = 1e-8;
% nombre d iterations max pour atteindre la convergence 
% (si i > kmax, l'algo finit)
imax = 5000; 

% Generation d une matrice rectangulaire aleatoire A de taille n x p.
% On cherche le vecteur propre et la valeur propre dominants de AA^T puis
% de A^TA
n = 15;
A = randn(n,n);
% AAt = A*A';
AAt = A;
%% Methode de la puissance iteree pour la matrice AAt de taille nxn
% Point de depart de l'algorithme de la puissance iteree : un vecteur
% aleatoire, normalise
m = 12;
V = randn(n, m);

cv = false;
iv1 = 0;        % pour compter le nombre d'iterations effectuees
t_v1 = cputime; % pour calculer le temps d execution de l'algo
err1 = 0;       % indication que le calcul est satisfaisant
                % on stoppe quand err1 < eps 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODER L'ALGORITHME DE LA PUISSANCE ITEREE POUR LA MATRICE AAt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda1 = V'*AAt*V;
    while(~cv)
        mu = lambda1;
        V = AAt*V;
        for k = 1:m
            V(:,k) = V(:,k)/norm(V(:,k));
        end
        lambda1 = V'*AAt*V;
        iv1 = iv1 + 1;
        err1 = (norm(lambda1-mu, 2)/norm(mu, 2));
        cv = (err1 <= eps) || (iv1 >= imax);
    end
t_v1 = cputime-t_v1; % t_version1 : temps d execution de l algo de la 
                     % puissance iteree pour la matrice AAt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APRES VOUS ETRE ASSURE DE LA CONVERGENCE DES DEUX METHODES, AFFICHER 
% L'ECART RELATIF ENTRE LES DEUX VALEURS PROPRES TROUVEES, ET LE TEMPS
% MOYEN PAR ITERATION POUR CHACUNE DES DEUX METHODES. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt = [repmat('%4d     ', 1, size(V,2)-1), '%4d\n'];
fprintf(fmt, V.');
fprintf('Erreur pour la methode avec la grande matrice = %0.3e\n', err1);
fprintf('Temps pour une ite avec la grande matrice = %0.3e\n', t_v1/iv1);