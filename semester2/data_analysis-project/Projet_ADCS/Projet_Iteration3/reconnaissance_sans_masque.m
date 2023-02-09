clear;
close all;

load eigenfaces_part3;

nb_test = 20;
% classe a comparer
g_posture_reelle= zeros(1,nb_test);
g_bonhomme_reelle = zeros(1,nb_test);
g_posture_trouvee_kppv = zeros(1,nb_test);
g_bonhomme_trouvee_kppv = zeros(1,nb_test);
g_posture_trouvee_bayesien = zeros(1,nb_test);
g_bonhomme_trouvee_bayesien = zeros(1,nb_test);


DataA = zeros(nb_personnes_base*nb_postures_base, 120000);
LabelA_Personne = zeros(nb_personnes_base*nb_postures_base, 1);
LabelA_Posture = zeros(nb_personnes_base*nb_postures_base, 1);

for i=1:nb_personnes_base
    for j=1:nb_postures_base
        ficF = strcat('./Data/', liste_personnes_base{i}, liste_postures{liste_postures_base(j)}, '-300x400.gif');
        img = imread(ficF);
        image_Data = double(transpose(img(:)));
        DataA((i-1)*nb_postures_base + j,:) = image_Data-individu_moyen;
        LabelA_Personne((i-1)*nb_postures_base+j)= i;
        LabelA_Posture((i-1)*nb_postures_base+j)= liste_postures_base(j);
    end
end
labels_personnes = zeros(nb_personnes_base, 1);
for k=1:nb_personnes_base
    labels_personnes(k) = k;
end
labels_postures = zeros(nb_postures_base, 1);
for k=1:nb_postures_base
    labels_postures(k) = liste_postures_base(k);
end

DataAbis = DataA*W;

for i=1:nb_test
    % Tirage aléatoire d'une image de test :
    personne = randi(nb_personnes)
    posture = randi(nb_postures)

    % si on veut tester/mettre au point, on fixe l'individu
    %personne = 10
    %posture = 6
    
    g_posture_reelle(i) = posture;
    g_bonhomme_reelle(i)= personne;

    ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif');
    img = imread(ficF);
    image_test = (double(transpose(img(:)))-individu_moyen)*W;
      
    %% Estimation kppv
    
    [Partition_Personne] = kppv(DataAbis, LabelA_Personne, image_test, 1, 1, labels_personnes);
    [Partition_Posture] = kppv(DataAbis, LabelA_Posture, image_test, 1, 1, labels_postures);
    
    
    % Nombre q de composantes principales à prendre en compte 
    q = 2;
    
    % dans un second temps, q peut être calculé afin d'atteindre le pourcentage
    % d'information avec q valeurs propres (contraste)
    % Pourcentage d'information 
    % per = 0.75;
    
    % individu pseudo-résultat pour l'affichage (A CHANGER)
    personne_proche = Partition_Personne;
    posture_proche = Partition_Posture;
    
    g_posture_trouvee_kppv(i) = posture_proche;
    g_bonhomme_trouvee_kppv(i) = personne_proche;

    figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);
    
    subplot(1, 2, 1);
    % Affichage de l'image de test :
    ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif');
    img = imread(ficF);
    
    colormap gray;
    imagesc(img);
    title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
    axis image;
    
    ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures{posture_proche}, '-300x400.gif');
    img = imread(ficF);
            
    subplot(1, 2, 2);
    imagesc(img);
    title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 20);
    axis image;

% % %     %% Estimation bayesienne
% % %     
% % %     % Vraisemblance
% % %     [individu_trouvee, posture_trouvee] = bayesienbis(DataAbis, nb_personnes_base, nb_postures_base, image_test)
% % %     g_bonhomme_trouvee_bayesien = individu_trouvee;
% % %     g_posture_trouvee_bayesien = posture_trouvee;
% % %     figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);
% % %     
% % %     subplot(1, 2, 1);
% % %     % Affichage de l'image de test :
% % %     ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif');
% % %     img = imread(ficF);
% % %     
% % %     colormap gray;
% % %     imagesc(img);
% % %     title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
% % %     axis image;
% % % 
% % %     ficF = strcat('./Data/', liste_personnes_base{individu_trouvee}, liste_postures{posture_trouvee}, '-300x400.gif');
% % %     img = imread(ficF);
% % %             
% % %     subplot(1, 2, 2);
% % %     imagesc(img);
% % %     title({['Individu la plus proche : posture ' num2str(posture_trouvee) ' de ', liste_personnes_base{individu_trouvee}]}, 'FontSize', 20);
% % %     axis image;

end

confusion_posture_kppv = confusionmat(g_posture_reelle, g_posture_trouvee_kppv)

% Cette INFO n'est pas exploitable
confusion_bonhomme_kppv = confusionmat(g_bonhomme_reelle, g_bonhomme_trouvee_kppv);


