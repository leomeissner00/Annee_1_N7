clear all;
close all;
clc;

%% Données utilisées

N = 1000;    % Longueur du message généré
Fe = 24000;
Rb = 3000;
Tb = 1/Rb;
Ns = Fe/Rb;
Ts = Ns/Fe;
Te = 1/Fe;

%% 5.2 Chaîne de référence

        % Génération d'un signal binaire aléatoire

bits = randi([0 1], 1, N);


        % Modulateur

% On réalise le mapping de la suite de bits  en affectant 1 aux bits 1 et -1 aux bits 0
Symboles = 2*bits - 1;

% On réalise le suréchantillonage 
Diracs = kron(Symboles, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre de mise en forme du modulateur 
h = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac

x = filter(h, 1, Diracs);


        % Démodulateur

% On génère la réponse impulsionnelle du filtre de réception
hr = h;

% On filtre notre signal

r = filter(hr, 1, x);


        % Instant optimale pour echantillonner sans interférences entre symboles n0 + m.Ns
n0 = Ns;    
% On prend n0 = Ns car à cette valeur, pour tout m != 0 g(n0 + m*Ns) = 0 : 
% respectant ainsi le critère de Nyquist 


        % Verification du taux d'erreur binaire à n0 = Ns
%Échantillonnage
r_ech = r(n0 : n0 : length(r));
%demapping
r_erreur = ((r_ech/Ns) + 1)/2;
%Calcul TEB
TEB = length(find((r_erreur - bits).^2 ~= 0)) / N 


        % MISE EN PLACE DU BRUIT 

Px = mean(abs(x).^2);%Puissance de x
M = 2;
TEB_bruit = [];
TEB_th = [];
for i = 0:8
    Eb_div_N0 = power(10, i/10); %calcul de Eb/N0
    sigma_n_carre = (Px * Ns) / (2 * log2(M) * (Eb_div_N0));%calcul de sigma carré
    bruit = sqrt(sigma_n_carre) * randn(1, length(x)); %calcul du bruit
    x_bruit = x + bruit; %ajout du bruit au signal
    r_bruit = filter(h, 1, x_bruit); %filtrage de réception
  

        % Tracé diagrammes de l'oeil

    figure (i+1)
    
    plot(reshape(r_bruit(Ns+1:end), Ns, length(r_bruit(Ns+1:end))/Ns));
    
    %echantillonnage
    r_ech_bruit = r_bruit(n0 : n0 : length(r_bruit));
    %détecteur de seuil
    r_ech_bruit(find(r_ech_bruit >= 0)) = 1;
    r_ech_bruit(find(r_ech_bruit < 0)) = 0;
    %calcul et ajout du TEB
    TEB_bruit = [TEB_bruit length(find((r_ech_bruit - bits).^2 ~= 0)) / N];
    
%Calucl du TEB théorique
    arg = sqrt(2*Eb_div_N0);
    TEB_th = [TEB_th qfunc(arg)];

end

        % Tracé de TEB en fonction de Eb/N0
figure (9) 
semilogy([0 : 1 : 8], TEB_bruit);
title("TEB de la chaine de référence en fonction de Eb/N0");
xlabel('Eb/N0');
ylabel('TEB');


        % Comparaison TEB simulé et théorique

figure (10)
semilogy([0 : 1 : 8], TEB_bruit, '-g');
hold on
semilogy([0 : 1 : 8], TEB_th, '-r');
title("TEB de la chaine de réf : simulé en vert, théorique en rouge.");
xlabel('Eb/N0');
ylabel('TEB');

    
%% 5.3 Première chaîne à étudier, implanter et comparer à la chaîne de référence

%% 5.3.1 Implantaiton de la chaîne sans bruit.
% Modulateur

% On réalise le mapping de la suite de bits  en affectant 1 aux bits 1 et -1 aux bits 0
Symboles1 = 2*bits - 1;

% On réalise le suréchantillonage 
Diracs1 = kron(Symboles1, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre de mise en forme du modulateur 
h1 = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac

x1 = filter(h1, 1, Diracs);

 % Démodulateur

% On génère la réponse impulsionnelle du filtre de réception
hr1 = ones(1, Ns/2);

% On filtre notre signal

r1 = filter(hr1, 1, x);

% Tracé du diagramme de l'oeil

figure (11)
plot(reshape(r1(Ns+1:end), Ns, length(r1(Ns+1:end))/Ns));
title('Diagramme de l oeil 1')
xlabel('Temps')
ylabel('Amplitude')

% Avec le diagramme de l'oeil on peut trouver un no0 convenable
n01 = Ns;

% Tracé du TEB de la chaîne 1 sans bruit
%échantillonnage
r_ech_1 = r1(n01 : n01 : length(r1));
%Détecteur de seuil
r_ech_1(find(r_ech_1 >= 0)) = 1;
r_ech_1(find(r_ech_1 < 0)) = 0;
%calcul TEB
TEB1 = length(find((r_ech_1 - bits).^2 ~= 0)) / N

%% Implantation de la chaîne avec bruit

Px1 = mean(abs(x1).^2); %Puissance x1
M = 2; 
TEB_bruit1 = [];
TEB_th1 = [];
for i = 0:8
    Eb_div_N0 = power(10, i/10);
    sigma_n_carre1 = (Px1 * Ns) / (2 * log2(M) * (Eb_div_N0));
    bruit1 = sqrt(sigma_n_carre1) * randn(1, length(x1));
    x_bruit1 = x1 + bruit1;
    r_bruit1 = filter(h1, 1, x_bruit1);
  

        % Tracé diagrammes de l'oeil

    figure (i+12)
    plot(reshape(r_bruit1(Ns+1:end), Ns, length(r_bruit1(Ns+1:end))/Ns));
    
    %échantillonnage
    r_ech_bruit1 = r_bruit1(n0 : n0 : length(r_bruit1));
    %détecteur de seuil
    r_ech_bruit1(find(r_ech_bruit1 >= 0)) = 1;
    r_ech_bruit1(find(r_ech_bruit1 < 0)) = 0;
    %calcul TEB
    TEB_bruit1 = [TEB_bruit1 length(find((r_ech_bruit1 - bits).^2 ~= 0)) / N];
    %Calcul TEB théorique
    arg1 = sqrt(2*Eb_div_N0);
    TEB_th1 = [TEB_th1 qfunc(arg1)];

end

% Tracé de TEB en fonction de Eb/N0
figure (20)
semilogy([0 : 1 : 8], TEB_bruit);


        % Comparaison TEB simulé et théorique

figure (21)
semilogy([0 : 1 : 8], TEB_bruit1, '-g');
hold on
semilogy([0 : 1 : 8], TEB_bruit, '-r');
title("TEB de la chaine 1 : chaine 1 en vert, réference en rouge.");
xlabel('Eb/N0');
ylabel('TEB');

% Comparaison TEB simulé de la chaîne 1 avec la chaîne de réfeérence.

figure (22)
semilogy([0 : 1 : 8], TEB_bruit1, '-r');
hold on
semilogy([0 : 1 : 8], TEB_bruit, '-b');  
title("TEB de la chaîne de ref en bleu, de la chaîne 1 en rouge.");
xlabel('Eb/N0');
ylabel('TEB');

%% Deuxième chaîne à étudier, implanter et comparer à la chaîne de référence.

Symboles2 = (2*bi2de(reshape(bits, 2, N/2).') - 3).';

% On réalise le suréchantillonage 
Diracs2 = kron(Symboles2, [1 zeros(1, Ns-1)]);

% On génére la réponse impulsionnelle du filtre de mise en forme du modulateur 
h2 = ones(1, Ns);

% On filtre notre suite d'impulsions de Dirac

x2 = filter(h2, 1, Diracs2);

 % Démodulateur

% On génère la réponse impulsionnelle du filtre de réception
hr2 = h2;

% On filtre notre signal

r2 = filter(hr2, 1, x2);

% Tracé du diagramme de l'oeil

figure (23)
plot(reshape(r2(Ns+1:end), Ns, length(r2(Ns+1:end))/Ns));
title("Diagramme de l'oeil chaîne 2.");
xlabel('Temps')
ylabel('Amplitude')



% Calcul du TEB de la chaîne 2 sans bruit.

n02 = Ns;

r_ech_2 = r2(n02 : n02 : length(r2));

%Détecteur de seuil 
r_ech_2(find(r_ech_2 < 16 & r_ech_2 >= 0)) = 1;
r_ech_2(find(r_ech_2 > -16 & r_ech_2 <= 0)) = -1;
r_ech_2(find(r_ech_2 >= 16)) = 3;
r_ech_2(find(r_ech_2 <= -16)) =-3;


r_erreur_2 = reshape(de2bi((r_ech_2 + 3)/2).', 1, length(bits));

TES2 = length(find((r_ech_2 - Symboles2).^2 ~= 0)) / N*2
TEB2 = length(find((r_erreur_2 - bits).^2 ~= 0)) / N


