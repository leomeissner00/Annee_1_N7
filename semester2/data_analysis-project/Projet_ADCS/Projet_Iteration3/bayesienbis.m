
% nb (nb de classes) : nb_personnes_base

function [individu_trouvee, posture_trouvee] = bayesienbis(base_donnee, nb_personnes_base, nb_postures_base, individu_test)


    % determiner individu le plus proche
    P_Individu = zeros(nb_personnes_base, 1);
    for i=1:nb_personnes_base
        %Nous calculons le mu et le sigma pour l'individu i
        [mu_individu, sigma_individu] = estimation_mu_Sigma(base_donnee((i-1)*nb_postures_base + 1 : i*nb_postures_base,:));
        size(sigma_individu) %Pour vérifier que les dimensions sont correctes
        %Calcul de la probabilité conditionnelle C sachant individu i
        Proba = gaussienne(individu_test, mu_individu, sigma_individu);
        P_Individu(i) = sum(Proba);
    end
    %L'indice du Max de P_individu correspond à l'individu le plus proche de
    %l'individu test
    [~, individu_trouvee] = max(P_Individu);
    
    % déterminer la posture de l'image
    P_Posture = zeros(nb_postures_base, 1);
    for i=1:nb_postures_base
        %Nous calculons le mu et le sigma pour la posture i
        [mu_posture, sigma_posture] = estimation_mu_Sigma(base_donnee(i:nb_postures_base:end,:));
        size(sigma_posture) %Pour vérifier que les dimensions sont correctes
        %Calcul de la probabilité conditionnelle C sachant position i
        Proba = gaussienne(individu_test,mu_posture, sigma_posture);
        P_Posture(i) = sum(Proba);
    end
    %L'indice du Max de P_Posture correspond à la posture la plus proche de
    %la posture de l'individu test
    [~, posture_trouvee] = max(P_Posture);
end


% [~,n]= size(base_donnee)
% %Determiner W_Individus, W_Postures
% W_Individus = zeros(nb_personnes_base,nb_postures_base*n)
% W_Postures = zeros(nb_postures_base,nb_personnes_base*n)
% for i=1:nb_personnes_base
%     Individu = base_donnee((i-1)*nb_postures_base + 1 : i*nb_postures_base,:);
%     W_Individus(i,:) = Individu(:);
% end
% for i=1:nb_postures_base
%     Posture= base_donnee(i:nb_postures_base:end,:);
%     W_Postures(i,:)=Posture(:);
% end
% size(W_Postures)
% size(W_Individus)
% 
% %Nous calculons C_Personne(x) et C_Posture(x)
% C_Personne = W_Individus*repmat(individu_test',nb_postures_base,1);
% C_Posture = W_Postures*repmat(individu_test',nb_personnes_base,1);


%% TRUC TESTE 1
% C = composante_principale'*individu_test';
% 
% % determiner individu le plus proche
% P_Individu = zeros(nb_personnes_base, 1);
% for i=1:nb_personnes_base
%     %Nous calculons le mu et le sigma pour l'individu i
%     [mu_individu, sigma_individu] = estimation_mu_Sigma(base_donnee((i-1)*nb_postures_base + 1 : i*nb_postures_base,:));
%     size(sigma_individu) %Pour vérifier que les dimensions sont correctes
%     %Calcul de la probabilité conditionnelle C sachant individu i
%     Proba = gaussienne(C', mu_individu, sigma_individu);
%     P_Individu(i) = sum(Proba);
% end
% %L'indice du Max de P_individu correspond à l'individu le plus proche de
% %l'individu test
% [~, individu_trouvee] = max(P_Individu);
% 
% % déterminer la posture de l'image
% P_Posture = zeros(nb_postures_base, 1);
% for i=1:nb_postures_base
%     %Nous calculons le mu et le sigma pour la posture i
%     [mu_posture, sigma_posture] = estimation_mu_Sigma(base_donnee(i:nb_postures_base:end,:));
%     size(sigma_posture) %Pour vérifier que les dimensions sont correctes
%     %Calcul de la probabilité conditionnelle C sachant position i
%     Proba = gaussienne(C',mu_posture, sigma_posture);
%     P_Posture(i) = sum(Proba);
% end
% %L'indice du Max de P_Posture correspond à la posture la plus proche de
% %la posture de l'individu test
% [~, posture_trouvee] = max(P_Posture);

%% TENTATIVE3
% C = composante_principale'*individu_test';
% P= zeros(1, nb_personnes_base*nb_postures_base);
% for i=1:nb_personnes_base
%     for j=1:nb_postures_base
%         [mu, sigma] = estimation_mu_Sigma(base_donnee((i-1)*nb_postures_base+j,:));
%         Proba = gaussienne(C', mu, sigma);
%         P((i-1)*nb_postures_base+j) = sum(Proba);
%     end
% end
% [~,index] = max(P);
% posture_trouvee = rem(index,nb_postures_base);
% if (posture_trouvee == 0)
%     posture_trouvee = nb_postures_base;
% end
% individu_trouvee = floor(index/nb_postures_base)+1;
