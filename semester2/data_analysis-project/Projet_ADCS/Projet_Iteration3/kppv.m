%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%
% Données :
% DataA      : les données d'apprentissage (connues) => liste images
% vectorisées de la bdd
% LabelA     : les labels des données d'apprentissage  => 
% label associé (différent en fonction de classement personne ou classement
% par posture)
%
% DataT      : les données de test (on veut trouver leur label) => images vectorisées classer
%
% Nt_test    : nombre de données tests qu'on veut labelliser : max 32
%
% K          : le K de l'algorithme des k-plus-proches-voisins
% ListeClass : les classes possibles (== les labels possibles) => 
% liste_personnes_base ou liste_posture
%
% Résultat :
% Partition : pour les Nt_test données de test, le label calculé
%
%--------------------------------------------------------------------------
function [Partition] = kppv(DataA, LabelA, DataT, Nt_test, K, ListeClass)

[Na,~] = size(DataA);

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

% disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
% disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre le vecteur de test 
    % et les vecteurs d'apprentissage (voisins)
    distance = sqrt(sum((DataT(i,:) - DataA).^2,2));
    
    % On ne garde que les indices des K + proches voisins
    [~,I] = sort(distance,"ascend");
    data = I(1:K);

    % Comptage du nombre de voisins appartenant à chaque classe
    occurences = zeros(K, 1);
    for k = ListeClass
        occurences(k+1) = length(find(LabelA(data) == k));
    end

    % Recherche des classes contenant le maximum de voisins
    maximum = max(occurences);
    classes_max = find(occurences == maximum);
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    if length(classes_max) == 1
        classe = ListeClass(classes_max);
    else
        classe = LabelA(I(1));
    end
   
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    Partition(i) = classe;

end

